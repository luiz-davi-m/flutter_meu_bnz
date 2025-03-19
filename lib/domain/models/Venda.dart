import 'dart:ffi';

class Venda {
  int? id;
  Float valor_total;
  Float desconto;
  String tipo_desconto;
  Float cashback;


  Venda({
    this.id,
    required this.valor_total,
    required this.desconto,
    required this.tipo_desconto,
    required this.cashback
  });

  @override
  String toString() {
    return "{ valor_total=$valor_total, desconto=$desconto tipo_desconto=$tipo_desconto cashback=$cashback }";
  }
}