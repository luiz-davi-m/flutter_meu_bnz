
class ResgateCashback {
  int? id;
  String categoria;
  DateTime dataResgate;
  double valorResgate;

  ResgateCashback({
    this.id,
    required this.categoria,
    required this.dataResgate,
    required this.valorResgate
  });

  @override
  String toString() {
    return "{ id=$id, categoria=$categoria, dataResgate=$dataResgate, valorResgate=$valorResgate }";
  }

  // Método para converter JSON do Supabase para um objeto Produto
  factory ResgateCashback.fromJson(Map<String, dynamic> json) {
    return ResgateCashback(
      id: json['id'],
      categoria: json['categoria'],
      dataResgate: DateTime.parse(json['dataResgate']),
      valorResgate: (json['valorResgate'] as num).toDouble(),
    );
  }
}
