class AulaApiModel {
  final int? id;
  final String data;
  final int idAluno;

  AulaApiModel({this.id, required this.data, required this.idAluno});

  factory AulaApiModel.fromJson(Map<String, dynamic> json) {
    return AulaApiModel(
      id: json['id'],
      data: json['data'],
      idAluno: json['aluno_id'] ?? 0,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id, 
      'data': data, 
      'aluno_id': idAluno};
  }
}
