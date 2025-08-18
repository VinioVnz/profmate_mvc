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
      idAluno: json['aluno_id'] ?? 0,
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
