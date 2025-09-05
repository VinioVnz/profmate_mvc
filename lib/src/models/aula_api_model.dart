import 'package:flutter/material.dart';

class AulaApiModel {
  final int? id;
  final String data;
  final String horario;
  final int idAluno;

  AulaApiModel({this.id, required this.data,required this.horario, required this.idAluno});

  factory AulaApiModel.fromJson(Map<String, dynamic> json) {
    return AulaApiModel(
      id: json['id'],
      data: json['data'],
      horario: json['horario'],
      idAluno: json['aluno']?['id'] ?? 0, //precisa ser assim, pois json['aluno_id'] não é encontrado na api
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id, 
      'data': data, 
      'horario': horario,
      'aluno_id': idAluno};
  }
}
