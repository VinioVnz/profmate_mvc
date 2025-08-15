class AtividadeModel {
  final String titulo;
  final String descricao;
  final String turmaOuAlunos;
  final String dtEntrega;
  final bool valeNota;
  final bool? arquivo;

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
      titulo: json['title'] as String,
      descricao: json['description'] as String,
      turmaOuAlunos: json['description'] as String,
      dtEntrega: json['description'] as String,
      valeNota: json['description'] as bool,
      arquivo: json['description'] as bool,
    );
  }
}
