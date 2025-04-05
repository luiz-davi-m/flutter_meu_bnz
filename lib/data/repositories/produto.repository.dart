import 'package:supabase_flutter/supabase_flutter.dart';

import '../../domain/models/Produto.dart';

class ProdutoRepository {
  static final _supabase = Supabase.instance.client;

  static Future<List<Produto>> listarProdutos() async {
    final response = await _supabase
        .from('produto')
        .select('*');

    print(response);


    if (response.isEmpty) {
      return [];
    }

    return response.map((json) => Produto.fromJson(json)).toList();
  }
}
