import 'package:supabase_flutter/supabase_flutter.dart';
import '../../domain/models/usuario.dart';

class UsuarioRepository {
  static final _supabase = Supabase.instance.client;

  static Future<Usuario?> autenticar(String cpf, String senha) async {
    try {
      print('Tentando autenticar CPF: $cpf, Senha: $senha');
      final response = await _supabase
          .from('usuario')
          .select()
          .eq('cpf', cpf)
          .eq('senha', senha)
          .maybeSingle();
      print('Resposta do Supabase: $response');

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

  static Future<Usuario?> criarUsuario(String cpf, String senha) async {
    try {
      final response = await _supabase
          .from('usuario')
          .insert({
        'cpf': cpf,
        'senha': senha,
      })
          .select()
          .single();

      return Usuario.fromJson(response);
    } catch (e) {
      print('Erro ao criar usuário: $e');
      return null;
    }
  }
}