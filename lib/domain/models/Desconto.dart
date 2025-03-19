import 'dart:ffi';

class Desconto {
  int? id;
  int id_produto;
  Float porcentagem_desconto;
  String categoria;

  Desconto({
    this.id,
    required this.id_produto,
    required this.porcentagem_desconto,
    required this.categoria
  });

  @override
  String toString() {
    return "{ id=$id, porcentagem_desconto=$porcentagem_desconto categoria=$categoria }";
  }
}