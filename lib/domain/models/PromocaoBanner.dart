import 'dart:ffi';

class Promocaobanner {

  int? id;
  String banner;
  bool ativo;

  Promocaobanner({
    this.id,
    required this.banner,
    required this.ativo,
  });

  @override
  String toString() {
    return "{ id=$id, banner=$banner ativo=$ativo }";
  }
}