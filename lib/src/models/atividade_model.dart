class AtividadeModel {
  final String titulo;
  final String descricao;
  final String turmaOuAlunos;
  final String dtEntrega;
  final bool valeNota;
  final String? arquivo;

  AtividadeModel({
    required this.titulo,
    required this.descricao,
    required this.turmaOuAlunos,
    required this.dtEntrega,
    required this.valeNota,
    this.arquivo,
  });

  Map<String, dynamic> toJson() {
    return {
      'titulo': titulo,
      'descricao': descricao,
      'turmaOuAlunos': turmaOuAlunos,
      'dtEntrega': dtEntrega,
      'valeNota': valeNota,
      'arquivo': arquivo,
    };
  }

  factory AtividadeModel.fromJson(Map<String, dynamic> json) {
    return AtividadeModel(
      titulo: json['titulo'] ?? '',
      descricao: json['descricao'] ?? '',
      turmaOuAlunos: json['turmaOuAlunos'] ?? '',
      dtEntrega: json['dtEntrega'] ?? '',
      valeNota: json['valeNota'] ?? false,
      arquivo: json['arquivo'],
    );
  }
}
