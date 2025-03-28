import 'package:flutter_meu_bnz/domain/models/Produto.dart';

class ProdutoRepository {

  static List<Produto> listarProdutos() {
    return [
      Produto(id: 1, nome: 'Água', preco: 3.50, foto: 'agua.png', percentualDesconto: 0.5),
      Produto(id: 2, nome: 'Biscoito', preco: 8.90, foto: 'biscoito.png', percentualDesconto: 1.5),
      Produto(id: 3, nome: 'Café', preco: 14.75, foto: 'cafe.png', percentualDesconto: 2.0),
      Produto(id: 4, nome: 'Carne', preco: 999.99, foto: 'carne.png', percentualDesconto: 5.0),
      Produto(id: 5, nome: 'Coca Cola', preco: 7.50, foto: 'coca_cola.png', percentualDesconto: 1.0),
      Produto(id: 6, nome: 'Frango', preco: 24.90, foto: 'frango.png', percentualDesconto: 3.5),
      Produto(id: 7, nome: 'Iogurte', preco: 34.90, foto: 'iogurte.png', percentualDesconto: 1.2),
      Produto(id: 8, nome: 'Lula', preco: 45.99, foto: 'lula.png', percentualDesconto: 6.0),
      Produto(id: 9, nome: 'Mamão', preco: 5.30, foto: 'mamao.png', percentualDesconto: 1.0),
      Produto(id: 10, nome: 'Ovo', preco: 134.89, foto: 'ovo.png', percentualDesconto: 2.5),
      Produto(id: 11, nome: 'Pão Integral', preco: 9.80, foto: 'pao_integral.png', percentualDesconto: 1.8),
      Produto(id: 12, nome: 'Salgadinho', preco: 4.99, foto: 'salgadinho.png', percentualDesconto: 1.0),

    ];
  }
}