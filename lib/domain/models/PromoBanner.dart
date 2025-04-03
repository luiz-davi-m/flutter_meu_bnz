class PromoBanner {
  int? id;
  String banner;
  bool ativo;

  PromoBanner({
    this.id,
    required this.banner,
    required this.ativo
  });

  // Método para converter JSON do Supabase para um objeto PromoBanner
  factory PromoBanner.fromJson(Map<String, dynamic> json) {
    return PromoBanner(
      id: json['id'],
      banner: json['banner'],
      ativo: json['ativo'],
    );
  }
}
