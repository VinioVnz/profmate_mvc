class TarefaApiModel {
  final int? id;
  final String titulo;
  final String descricao;
  final DateTime dataEntrega;
  final int idUsuario;

  TarefaApiModel({
    this.id,
    required this.titulo,
    required this.descricao,
    required this.dataEntrega,
    required this.idUsuario,
  });

  factory TarefaApiModel.fromJson(Map<String, dynamic> json){
    return TarefaApiModel(
      id: json['id'],
      titulo: json['titulo'], 
      descricao: json['descricao'], 
      dataEntrega: json['dataEntrega'], 
      idUsuario: json['aluno']?['id'] ?? 0);
  }

  Map<String,dynamic> toJson(){
    return {
      'id': id,
      'titulo': titulo,
      'descricao':descricao,
      'dataEntrega': dataEntrega,
      'usuario_id': idUsuario
    };
  }
}
