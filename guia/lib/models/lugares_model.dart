class LugaresModel {
  final int id;
  final String nome;
  final String? categoria;
  final int categoriaid;
  final double latitude;
  final double longitude;
  final String? descricao;

  LugaresModel({
    required this.id,
    required this.nome,
    required this.latitude,
    required this.longitude,
    required this.categoriaid,
    this.categoria = '',
    this.descricao = '',
  });

  factory LugaresModel.fromJson(Map<String, dynamic> json) {
    return LugaresModel(
      id: json['id'],
      nome: json['nome'],
      categoria: json['categoria'] != null ? json['categoria']['nome'] : '',
      categoriaid: json['categoriaid'], 
      latitude: (json['latitude'] as num).toDouble(),
      longitude: (json['longitude'] as num).toDouble(),
      descricao: json['descricao'] ?? '',
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'nome': nome,
      'latitude': latitude,
      'longitude': longitude,
      'descricao': descricao,
      'categoria': categoria,
      'categoriaid': categoriaid
    };
  }
}