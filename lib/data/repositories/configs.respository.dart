import 'package:flutter_meu_bnz/domain/models/Config.dart';
import 'package:supabase_flutter/supabase_flutter.dart';


class ConfigsRepository {
  static final _supabase = Supabase.instance.client;

  static Future<Config?> configs() async {
    final response = await _supabase
        .from('configs')
        .select('*')
        .limit(1)
        .single();

    print(response);

    if (response == null) {
      return null;
    }

    return Config.fromJson(response);
  }

  static Future<void> atualizarCashback(double novoValor) async {
    await _supabase
        .from('configs')
        .update({'cashback': novoValor})
        .eq('id', 1);
  }
}
