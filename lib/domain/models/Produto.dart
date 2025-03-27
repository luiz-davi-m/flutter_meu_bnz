
class Produto {
  int? id;
  String nome;
  double preco;
  String foto;
  double percentualDesconto;

  Produto({
    this.id,
    required this.nome,
    required this.preco,
    required this.foto,
    required this.percentualDesconto,
  });

  double get precoComDesconto => preco * (1 - percentualDesconto / 100);

  @override
  String toString() {
    return "{ id=$id, nome=$nome, preco=$preco, percentualDesconto=$percentualDesconto%, precoComDesconto=${precoComDesconto.toStringAsFixed(2)}, foto=$foto }";
  }
}
