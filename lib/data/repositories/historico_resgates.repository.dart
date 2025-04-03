import 'package:flutter_meu_bnz/domain/models/ResgateCashback.dart';
import 'package:supabase_flutter/supabase_flutter.dart';


class HistoricoResgateRespository {
  static final _supabase = Supabase.instance.client;

  static Future<List<ResgateCashback>> historicoResgates() async {
    final response = await _supabase
        .from('resgates')
        .select('*')
        .order('dataResgate', ascending: false);

    print(response);

    if (response.isEmpty) {
      return [];
    }

    return response.map((json) => ResgateCashback.fromJson(json)).toList();
  }

  static Future<void> registrarResgate(String categoria, double valor) async {
    await _supabase.from('resgates')
        .insert({
          'categoria': categoria,
          'dataResgate': DateTime.now().toIso8601String(),
          'valorResgate': valor,
        });
  }
}
