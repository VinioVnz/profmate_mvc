class Turma {
  String? nomeTurma;
  String? localTurma;

  Turma({required nomeTurma, required localTurma});

  Map<String, dynamic> toJson() {
    return {'nomeTurma': nomeTurma, 'localTurma': localTurma};
  }

  factory Turma.fromJson(Map<String, dynamic> json) {
    return Turma(
      nomeTurma: json['nomeTurma'] as String,
      localTurma: json['localTurma'] as String,
    );
  }
}
