import 'package:flutter_meu_bnz/domain/models/Produto.dart';

class ProdutoRepositoy {

  static List<Produto> listarProdutos() {
    return [
      Produto(id: 1,nome: 'teste 1', preco: 21, foto: 'teste_1.png'),
      Produto(id: 2,nome: 'teste 2', preco: 22, foto: 'teste_2.png'),
      Produto(id: 3,nome: 'teste 3', preco: 23, foto: 'teste_3.png'),
      Produto(id: 4,nome: 'teste 4', preco: 24, foto: 'teste_4.png'),
      Produto(id: 5,nome: 'teste 5', preco: 25, foto: 'teste_5.png'),
    ];
  }
}