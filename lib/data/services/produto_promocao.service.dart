import 'package:flutter_meu_bnz/domain/models/ProdutoPromocao.dart';
import '../repositories/produto_promocao.repository.dart';

class ProdutoPromocaoService {
  static Future<List<ProdutoPromocao>> listarProdutos() {
    return ProdutoPromocaoRepository.listarProdutos();
  }
}
