import '../../domain/models/usuario.dart';
import '../repositories/usuario.repository.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class UsuarioService {
  static final _supabase = Supabase.instance.client;
  static Usuario? _currentUser;


  static Usuario? get currentUser => _currentUser;


  static void _setCurrentUser(Usuario? user) {
    _currentUser = user;
  }

  static Future<bool> usuarioExiste(String cpf) async {
    final usuario = await UsuarioRepository.buscarPorCpf(cpf);
    return usuario != null;
  }

  static Future<Usuario?> autenticar(String cpf, String senha) async {
    try {
      final user = await UsuarioRepository.autenticar(cpf, senha);
      if (user != null) {
        _setCurrentUser(user);
      }
      return user;
    } catch (e) {
      _setCurrentUser(null);
      rethrow;
    }
  }

  static Future<Usuario> registrar({
    required String cpf,
    required String senha,
    required String nomeCompleto,
    required String genero,
    required String dataNascimento,
    required String telefone,
    required String email,
  }) async {
    try {

      final documentoLimpo = _limparDocumento(cpf);
      if (!_validarCpfOuCnpj(documentoLimpo)) {
        throw Exception('CPF/CNPJ inválido');
      }

      if (senha.length < 6) {
        throw Exception('Senha deve ter pelo menos 6 caracteres');
      }

      if (nomeCompleto.trim().split(' ').length < 2) {
        throw Exception('Informe nome e sobrenome');
      }

      if (!validarDataNascimento(dataNascimento)) {
        throw Exception('Data de nascimento inválida');
      }

      final telefoneLimpo = _limparTelefone(telefone);
      if (telefoneLimpo.length < 10) {
        throw Exception('Telefone inválido');
      }

      if (!validarEmail(email)) {
        throw Exception('E-mail inválido');
      }

      if (await usuarioExiste(documentoLimpo)) {
        throw Exception('CPF/CNPJ já cadastrado');
      }

      final usuarioCadastrado = await UsuarioRepository.registrar(
        cpf: documentoLimpo,
        senha: senha,
        nomeCompleto: nomeCompleto.trim(),
        genero: genero,
        dataNascimento: dataNascimento,
        telefone: telefoneLimpo,
        email: email.trim().toLowerCase(),
      );

      if (usuarioCadastrado == null) {
        throw Exception('Falha ao cadastrar usuário');
      }

      return usuarioCadastrado;
    } catch (e) {
      throw Exception('Erro no registro: ${e.toString()}');
    }
  }

  static String _limparDocumento(String documento) {
    return documento.replaceAll(RegExp(r'[^0-9]'), '');
  }

  static String _limparTelefone(String telefone) {
    return telefone.replaceAll(RegExp(r'[^0-9]'), '');
  }

  static bool _validarCpfOuCnpj(String documento) {
    if (documento.length == 11) {
      return validarCpf(documento);
    } else if (documento.length == 14) {
      return validarCnpj(documento);
    }
    return false;
  }

  static bool validarCpf(String cpf) {
    if (cpf.length != 11) return false;

    if (RegExp(r'^(\d)\1*$').hasMatch(cpf)) {
      return false;
    }

    int soma = 0;
    for (int i = 0; i < 9; i++) {
      soma += int.parse(cpf[i]) * (10 - i);
    }
    int resto = soma % 11;
    int digito1 = resto < 2 ? 0 : 11 - resto;

    soma = 0;
    for (int i = 0; i < 10; i++) {
      soma += int.parse(cpf[i]) * (11 - i);
    }
    resto = soma % 11;
    int digito2 = resto < 2 ? 0 : 11 - resto;

    return int.parse(cpf[9]) == digito1 && int.parse(cpf[10]) == digito2;
  }

  static bool validarCnpj(String cnpj) {
    if (cnpj.length != 14) return false;

    if (RegExp(r'^(\d)\1*$').hasMatch(cnpj)) {
      return false;
    }

    int soma = 0;
    int peso = 5;
    for (int i = 0; i < 12; i++) {
      soma += int.parse(cnpj[i]) * peso;
      peso = (peso == 2) ? 9 : peso - 1;
    }
    int resto = soma % 11;
    int digito1 = resto < 2 ? 0 : 11 - resto;

    soma = 0;
    peso = 6;
    for (int i = 0; i < 13; i++) {
      soma += int.parse(cnpj[i]) * peso;
      peso = (peso == 2) ? 9 : peso - 1;
    }
    resto = soma % 11;
    int digito2 = resto < 2 ? 0 : 11 - resto;

    return int.parse(cnpj[12]) == digito1 && int.parse(cnpj[13]) == digito2;
  }

  static bool validarDataNascimento(String data) {
    try {
      final parts = data.split('/');
      if (parts.length != 3) return false;

      final dia = int.parse(parts[0]);
      final mes = int.parse(parts[1]);
      final ano = int.parse(parts[2]);

      if (dia < 1 || dia > 31) return false;
      if (mes < 1 || mes > 12) return false;
      if (ano < 1900 || ano > DateTime.now().year) return false;

      return true;
    } catch (e) {
      return false;
    }
  }

  static bool validarEmail(String email) {
    return RegExp(
        r"^[a-zA-Z0-9.!#$%&'*+/=?^_`{|}~-]+@[a-zA-Z0-9-]+(?:\.[a-zA-Z0-9-]+)*$"
    ).hasMatch(email.trim());
  }

  static Future<void> logout() async {
    try {

      final currentUser = _currentUser;
      if (currentUser == null) {
        print('Nenhum usuário logado para deslogar');
        return;
      }

      _currentUser = null;

      final userAfterLogout = _currentUser;
      if (userAfterLogout != null) {
        throw Exception('Falha ao desconectar o usuário');
      }

      print('Logout realizado com sucesso');
    } catch (e) {
      print('Erro durante o logout: $e');
      throw Exception('Não foi possível sair da conta. Tente novamente.');
    }
  }

  static bool get isLoggedIn {
    return _supabase.auth.currentUser != null;
  }

  static String? get currentUserId {
    return _supabase.auth.currentUser?.id;
  }

  static String? get currentUserEmail {
    return _supabase.auth.currentUser?.email;
  }

  static Future<String> getUserName() async {
    final currentUser = _currentUser;
    if (currentUser != null) {
      return currentUser.nomeCompleto;
    }else{
      return 'Usuário null';
    }

  }

}