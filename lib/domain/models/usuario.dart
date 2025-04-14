class Usuario {
  final int id;
  final DateTime createdAt;
  final String cpf;
  final String senha;
  final String nomeCompleto;
  final String genero;
  final String dataNascimento;
  final String telefone;
  final String email;
  final DateTime? updatedAt;

  Usuario({
    required this.id,
    required this.createdAt,
    required this.cpf,
    required this.senha,
    required this.nomeCompleto,
    required this.genero,
    required this.dataNascimento,
    required this.telefone,
    required this.email,
    this.updatedAt,
  });

  factory Usuario.fromJson(Map<String, dynamic> json) {
    return Usuario(
      id: json['id'] as int,
      createdAt: DateTime.parse(json['created_at'] as String),
      cpf: json['cpf'] as String,
      senha: json['senha'] as String,
      nomeCompleto: json['nome'] as String,
      genero: json['genero'] as String,
      dataNascimento: json['data_nascimento'] as String,
      telefone: json['telefone'] as String,
      email: json['email'] as String,
      updatedAt: json['updated_at'] != null
          ? DateTime.parse(json['updated_at'] as String)
          : null,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'created_at': createdAt.toIso8601String(),
      'cpf': cpf,
      'senha': senha,
      'nome': nomeCompleto,
      'genero': genero,
      'data_nascimento': dataNascimento,
      'telefone': telefone,
      'email': email,
      'updated_at': updatedAt?.toIso8601String(),
    };
  }

  factory Usuario.createNew({
    required String cpf,
    required String senha,
    required String nomeCompleto,
    required String genero,
    required String dataNascimento,
    required String telefone,
    required String email,
  }) {
    return Usuario(
      id: 0,
      createdAt: DateTime.now(),
      cpf: cpf.replaceAll(RegExp(r'[^0-9]'), ''),
      senha: senha,
      nomeCompleto: nomeCompleto,
      genero: genero,
      dataNascimento: dataNascimento,
      telefone: telefone.replaceAll(RegExp(r'[^0-9]'), ''),
      email: email,
    );
  }

  Usuario copyWith({
    int? id,
    DateTime? createdAt,
    String? cpf,
    String? senha,
    String? nomeCompleto,
    String? genero,
    String? dataNascimento,
    String? telefone,
    String? email,
    DateTime? updatedAt,
  }) {
    return Usuario(
      id: id ?? this.id,
      createdAt: createdAt ?? this.createdAt,
      cpf: cpf ?? this.cpf,
      senha: senha ?? this.senha,
      nomeCompleto: nomeCompleto ?? this.nomeCompleto,
      genero: genero ?? this.genero,
      dataNascimento: dataNascimento ?? this.dataNascimento,
      telefone: telefone ?? this.telefone,
      email: email ?? this.email,
      updatedAt: updatedAt ?? this.updatedAt,
    );
  }
}