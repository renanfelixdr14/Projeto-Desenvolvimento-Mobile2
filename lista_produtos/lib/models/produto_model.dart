class ProdutoModel {
  int? id;
  final String nome;
  final String categoria;
  final double preco;
  final int estoque;
  final String caracteristica;
  
  ProdutoModel({
    required this.nome,
    required this.categoria,
    required this.preco,
    required this.estoque,
    required this.caracteristica,
    this.id,
  });

  factory ProdutoModel.fromJson(Map<String, dynamic> json) {
    return ProdutoModel(
      id: json['id'],
      nome: json['nome'] ?? '', 
      categoria: json['categoria'] ?? '', 
      // Converte com segurança para double, aceitando tanto String quanto num
      preco: json['preco'] != null 
          ? double.tryParse(json['preco'].toString()) ?? 0.0 
          : 0.0,
      // Converte com segurança para int, aceitando tanto String quanto num
      estoque: json['estoque'] != null 
          ? int.tryParse(json['estoque'].toString()) ?? 0 
          : 0,
      caracteristica: json['caracteristica'] ?? '',
    );
  }
 // escondido
  Map<String, dynamic> toJson() {
    return {
      "id": id,
      "nome": nome,
      "categoria": categoria,
      "preco": preco,
      "estoque": estoque,
      "caracteristica": caracteristica,
    };
  }
}