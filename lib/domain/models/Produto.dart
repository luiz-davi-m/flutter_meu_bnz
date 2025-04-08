class Produto {
  int? id;
  String nome;
  double preco;
  String foto;
  double percentualDesconto;

  double get precoComDesconto => preco * (1 - percentualDesconto / 100);

  Produto({
    this.id,
    required this.nome,
    required this.preco,
    required this.foto,
    required this.percentualDesconto,
  });

  // Método para converter JSON do Supabase para um objeto Produto
  factory Produto.fromJson(Map<String, dynamic> json) {
    return Produto(
      id: json['id'],
      nome: json['nome'],
      preco: (json['preco'] as num).toDouble(),
      foto: json['foto'],
      percentualDesconto: (json['percentualDesconto'] as num).toDouble(),
    );
  }
}