import 'package:flutter_meu_bnz/domain/models/Produto.dart';
import '../repositories/produto.repository.dart';

class ProdutoService {
  static Future<List<Produto>> listarProdutos() {
    return ProdutoRepository.listarProdutos();
  }
}
