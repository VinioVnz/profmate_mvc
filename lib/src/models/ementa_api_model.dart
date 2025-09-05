class EmentaApiModel {
  final int? id;
  final String modulo;
  final String topico;
  final String descricao;
  bool concluida;

  EmentaApiModel({
    this.id,
    required this.modulo,
    required this.topico,
    required this.descricao,
    this.concluida = false,
  });

factory EmentaApiModel.fromJson(Map<String, dynamic> json){
    return EmentaApiModel(
      id: json['id'],
      modulo: json['modulo'], 
      topico: json['topico'], 
      descricao: json['descricao'], 
      concluida: json['concluida'] ?? false,
      );
  }

  Map<String, dynamic> toJson(){
    return {
      'id': id,
      'modulo': modulo,
      'topico': topico,
      'descricao': descricao,
      'concluida': concluida,
    };
  }
}

