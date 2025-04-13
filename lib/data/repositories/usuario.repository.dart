import 'package:supabase_flutter/supabase_flutter.dart';
import '../../domain/models/usuario.dart';

class UsuarioRepository {
  static final _supabase = Supabase.instance.client;

  static Future<Usuario?> autenticar(String cpf, String senha) async {
    try {
      final response = await _supabase
          .from('usuario')
          .select()
          .eq('cpf', cpf)
          .eq('senha', senha)
          .maybeSingle();

      if (response != null) {
        return Usuario.fromJson(response);
      }
      return null;
    } catch (e) {
      print('Erro ao autenticar usuário: $e');
      return null;
    }
  }

  static Future<Usuario?> buscarPorCpf(String cpf) async {
    try {
      final response = await _supabase
          .from('usuario')
          .select()
          .eq('cpf', cpf)
          .single();

      return response != null ? Usuario.fromJson(response) : null;
    } catch (e) {
      print('Erro ao buscar usuário por CPF: $e');
      return null;
    }
  }

  static Future<Usuario?> registrar({
    required String cpf,
    required String senha,
    required String nomeCompleto,
    required String genero,
    required String dataNascimento,
    required String telefone,
    required String email,
  }) async {
    try {

      final dateParts = dataNascimento.split('/');
      if (dateParts.length != 3) throw Exception('Formato de data inválido');

      final formattedDate = '${dateParts[2]}-${dateParts[1].padLeft(2, '0')}-${dateParts[0].padLeft(2, '0')}';

      final response = await _supabase
          .from('usuario')
          .insert({
        'cpf': cpf,
        'senha': senha,
        'nome': nomeCompleto,
        'genero': genero,
        'data_nascimento': formattedDate,
        'telefone': telefone,
        'email': email,
        'created_at': DateTime.now().toIso8601String(),
      })
          .select()
          .maybeSingle();

      if (response == null) {
        throw Exception('Falha ao cadastrar usuário - nenhum dado retornado');
      }

      print("TESTE RESPONSE REGISTER");
      print(response);

      return Usuario.fromJson(response);
    } catch (e) {
      print('Erro ao criar usuário: $e');
      rethrow;
    }
  }

  static Future<Usuario?> atualizarUsuarioCompleto(int userId, {
    required String cpf,
    required String senha,
    required String nomeCompleto,
    required String genero,
    required String dataNascimento,
    required String telefone,
    required String email,
  }) async {
    try {
      final response = await _supabase
          .from('usuario')
          .update({
        'cpf': cpf,
        'senha': senha,
        'nome': nomeCompleto,
        'genero': genero,
        'data_nascimento': dataNascimento,
        'telefone': telefone,
        'email': email,
        'updated_at': DateTime.now().toIso8601String(),
      })
          .eq('id', userId)
          .select()
          .single();

      return Usuario.fromJson(response);
    } catch (e) {
      print('Erro ao atualizar usuário: $e');
      return null;
    }
  }
}