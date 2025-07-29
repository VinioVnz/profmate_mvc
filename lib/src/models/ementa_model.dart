class EmentaModel {
  String titulo;
  String descricao;
  bool concluida;

  EmentaModel({
    required this.titulo,
    required this.descricao,
    this.concluida = false,
  });
}

