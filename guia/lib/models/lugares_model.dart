class LugaresModel {
  final int id;
  final String nome;
  final String descricao;
  final int? categoriaId;
  final String? nomeCategoria;
  final double latitude;
  final double longitude;

  LugaresModel({
    required this.id,
    required this.nome,
    required this.descricao,
    required this.latitude,
    required this.longitude,
    this.categoriaId,
    this.nomeCategoria,
  });

  factory LugaresModel.fromJson(Map<String, dynamic> json) {
    String? nomeCat;
    if (json['categoria'] != null && json['categoria'] is Map) {
      nomeCat = json['categoria']['nome'];
    }

    return LugaresModel(
      id: int.tryParse(json['id'].toString()) ?? 0,
      nome: json['nome'] ?? 'Sem nome',
      descricao: json['descricao'] ?? '',
      categoriaId: json['categoriaId'] != null ? int.tryParse(json['categoriaId'].toString()) : null,
      nomeCategoria: nomeCat, 
      latitude: double.tryParse(json['latitude'].toString()) ?? 0.0,
      longitude: double.tryParse(json['longitude'].toString()) ?? 0.0,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'nome': nome,
      'descricao': descricao,
      'latitude': latitude,
      'longitude': longitude,
      'categoriaId': categoriaId, 
    };
  }
}