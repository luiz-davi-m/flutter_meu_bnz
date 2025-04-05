import 'produto.dart';

class ProdutoPromocao extends Produto {
  String categoria;
  double precoPromocao;

  ProdutoPromocao({
    int? id,
    required String nome,
    required double preco,
    required String foto,
    required double percentualDesconto,
    required this.categoria,
    required this.precoPromocao,
  }) : super(
    id: id,
    nome: nome,
    preco: preco,
    foto: foto,
    percentualDesconto: percentualDesconto,
  );

  @override
  double get precoComDesconto => precoPromocao;

  // Método fromJson corrigido para garantir compatibilidade
  factory ProdutoPromocao.fromJson(Map<String, dynamic> json) {
    return ProdutoPromocao(
      id: json['id'] ?? json['ID'], // Versões alternativas de nome
      nome: json['nome'] ?? json['NOME'],
      preco: _parseDouble(json['preco'] ?? json['PRECO']),
      foto: json['foto'] ?? json['FOTO'],
      percentualDesconto: _parseDouble(json['percentualDesconto'] ??
          json['PERCENTUAL_DESCONTO'] ??
          json['percentual_desconto'] ??
          0.0),
      categoria: json['categoria'] ?? json['CATEGORIA'],
      precoPromocao: _parseDouble(json['preco_promocao'] ??
          json['PRECO_PROMOCAO'] ??
          json['precoPromocao']),
    );
  }

  static double _parseDouble(dynamic value) {
    if (value is num) return value.toDouble();
    if (value is String) return double.tryParse(value) ?? 0.0;
    return 0.0;
  }

  @override
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'nome': nome,
      'preco': preco,
      'foto': foto,
      'percentual_desconto': percentualDesconto, // Padrão snake_case para Supabase
      'categoria': categoria,
      'preco_promocao': precoPromocao, // Padrão snake_case para Supabase
    };
  }
}