
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
}
