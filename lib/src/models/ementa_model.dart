class EmentaModel {
  final String modulo;
  final String topico;
  final String descricao;
  bool concluida;

  EmentaModel({
    required this.modulo,
    required this.topico,
    required this.descricao,
    this.concluida = false,
  });
}

