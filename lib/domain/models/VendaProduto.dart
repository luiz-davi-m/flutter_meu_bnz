import 'dart:ffi';

class VendaProduto {
  int? id;
  int id_venda;
  int id_produto;
  Float valor;
  Float cashback;


  VendaProduto({
    this.id,
    required this.id_venda,
    required this.id_produto,
    required this.valor,
    required this.cashback
  });

  @override
  String toString() {
    return "{ id_venda=$id_venda, id_produto=$id_produto valor=$valor cashback=$cashback }";
  }
}