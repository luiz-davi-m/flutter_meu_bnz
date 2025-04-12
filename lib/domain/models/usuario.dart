class Usuario {
  final int id;
  final DateTime createdAt;
  final String cpf;
  final String senha;

  Usuario({
    required this.id,
    required this.createdAt,
    required this.cpf,
    required this.senha,
  });

  factory Usuario.fromJson(Map<String, dynamic> json) {
    return Usuario(
      id: json['id'] as int,  // Conversão explícita para int
      createdAt: DateTime.parse(json['created_at'] as String),
      cpf: json['cpf'] as String,
      senha: json['senha'] as String,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'created_at': createdAt.toIso8601String(),
      'cpf': cpf,
      'senha': senha,
    };
  }
}