import 'package:flutter_meu_bnz/domain/models/Produto.dart';

class ProdutoRepository {

  static List<Produto> listarProdutos() {
    return [
      Produto(id: 1, nome: 'Água', preco: 3.50, foto: 'agua.png', percentualDesconto: 0.5, categoria: 'Bebidas'),
      Produto(id: 2, nome: 'Biscoito', preco: 8.90, foto: 'biscoito.png', percentualDesconto: 1.5, categoria: 'Alimento'),
      Produto(id: 3, nome: 'Café', preco: 14.75, foto: 'cafe.png', percentualDesconto: 2.0, categoria: 'Bebidas'),
      Produto(id: 4, nome: 'Carne', preco: 999.99, foto: 'carne.png', percentualDesconto: 5.0, categoria: 'Proteinas'),
      Produto(id: 5, nome: 'Coca Cola', preco: 7.50, foto: 'coca_cola.png', percentualDesconto: 1.0, categoria: 'Bebidas'),
      Produto(id: 6, nome: 'Frango', preco: 24.90, foto: 'frango.png', percentualDesconto: 3.5, categoria: 'Proteinas'),
      Produto(id: 7, nome: 'Iogurte', preco: 34.90, foto: 'iogurte.png', percentualDesconto: 1.2, categoria: 'Frios'),
      Produto(id: 8, nome: 'Lula', preco: 45.99, foto: 'lula.png', percentualDesconto: 6.0, categoria: 'Proteinas'),
      Produto(id: 9, nome: 'Mamão', preco: 5.30, foto: 'mamao.png', percentualDesconto: 1.0, categoria: 'Fruta'),
      Produto(id: 10, nome: 'Ovo', preco: 134.89, foto: 'ovo.png', percentualDesconto: 2.5, categoria: 'Proteinas'),
      Produto(id: 11, nome: 'Pão Integral', preco: 9.80, foto: 'pao_integral.png', percentualDesconto: 1.8, categoria: 'Alimento'),
      Produto(id: 12, nome: 'Salgadinho', preco: 4.99, foto: 'salgadinho.png', percentualDesconto: 1.0, categoria: 'Alimento'),

      Produto(id: 13, nome: 'Detergente', preco: 2.99, foto: 'detergente.png', percentualDesconto: 5.0, categoria: 'Limpeza'),
      Produto(id: 14, nome: 'Sabão em Pó', preco: 12.90, foto: 'sabao_po.png', percentualDesconto: 10.0, categoria: 'Limpeza'),
      Produto(id: 15, nome: 'Desinfetante', preco: 8.50, foto: 'desinfetante.png', percentualDesconto: 3.0, categoria: 'Limpeza'),

    ];
  }
}