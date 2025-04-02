import 'dart:ffi';

class Config {
  int? id;
  double cashback;

  Config({
    this.id,
    required this.cashback,
  });

  @override
  String toString() {
    return "{ cashback=$cashback }";
  }
  // Método para converter JSON do Supabase para um objeto Config
  factory Config.fromJson(Map<String, dynamic> json) {
    return Config(
      id: json['id'],
      cashback: (json['cashback'] as num).toDouble(),
    );
  }

}