import 'package:supabase_flutter/supabase_flutter.dart';

import '../../domain/models/ProdutoPromocao.dart';

class ProdutoPromocaoRepository  {
  static final _supabase = Supabase.instance.client;

  static Future<List<ProdutoPromocao>> listarProdutos() async {
    final response = await _supabase
        .from('produto_promocao')
        .select('*');

    if (response.isEmpty) {
      return [];
    }

    return response.map((json) => ProdutoPromocao.fromJson(json)).toList();
  }
}
