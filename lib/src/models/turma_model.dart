class TurmaModel {
  String? nomeTurma;
  String? localTurma;

  TurmaModel({required nomeTurma, required localTurma});

  Map<String, dynamic> toJson() {
    return {'nomeTurma': nomeTurma, 'localTurma': localTurma};
  }

  factory TurmaModel.fromJson(Map<String, dynamic> json) {
    return TurmaModel(
      nomeTurma: json['nomeTurma'] as String,
      localTurma: json['localTurma'] as String,
    );
  }
}
