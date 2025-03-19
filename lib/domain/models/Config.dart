import 'dart:ffi';

class Config {
  int? id;
  int nome;
  Float cashback;
  String cashback_resgate;

  Config({
    this.id,
    required this.nome,
    required this.cashback,
    required this.cashback_resgate
  });

  @override
  String toString() {
    return "{ nome=$nome, cashback=$cashback cashback_resgate=$cashback_resgate }";
  }
}