class NovaAtividade {
  String titulo;
  String descricao;
  String turmaOuAlunos;
  String dataEntrega;
  bool valeNota;
  String? arquivo;

  NovaAtividade({
    required this.titulo,
    required this.descricao,
    required this.turmaOuAlunos,
    required this.dataEntrega,
    required this.valeNota,
    this.arquivo,
  });
}
