import 'dart:ffi';

class Produto {
  int? id;
  String nome;
  Float preco;
  String foto;

  Produto({
    this.id,
    required this.nome,
    required this.preco,
    required this.foto
  });

  @override
  String toString() {
    return "{ id=$id, nome=$nome preco=$preco foto=$foto }";
  }
}