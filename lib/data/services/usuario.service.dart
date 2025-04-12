import '../../domain/models/usuario.dart';
import '../repositories/usuario.repository.dart';

class UsuarioService {

  static Future<Usuario?> autenticar(String cpf, String senha) async {
    return await UsuarioRepository.autenticar(cpf, senha);
  }

  static Future<bool> usuarioExiste(String cpf) async {
    final usuario = await UsuarioRepository.buscarPorCpf(cpf);
    return usuario != null;
  }

  static Future<Usuario?> registrar(String cpf, String senha) async {
    return await UsuarioRepository.criarUsuario(cpf, senha);
  }
}