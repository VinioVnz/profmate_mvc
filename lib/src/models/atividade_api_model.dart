import 'package:profmate/src/models/atividade_model.dart';

class AtividadeApiModel {
  final int? id;
  final String titulo;
  final String descricao;
  final String turmaOuAlunos;
  final String dtEntrega;
  final String valeNota;
  final String? arquivo;

  AtividadeApiModel({
    this.id,
    required this.titulo,
    required this.descricao,
    required this.turmaOuAlunos,
    required this.dtEntrega,
    required this.valeNota,
    this.arquivo,
  });

  factory AtividadeApiModel.fromJson(Map<String, dynamic> json) {
    return AtividadeApiModel(
      id: json['id'],
      titulo: json['titulo'] ?? '',
      descricao: json['descricao'] ?? '',
      turmaOuAlunos: json['turmaOuAlunos'] ?? '',
      dtEntrega: json['dtEntrega'] ?? '',
      valeNota: json['valeNota'] ?? '',
      arquivo: json['arquivo'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'titulo': titulo,
      'descricao': descricao,
      'turmaOuAlunos': turmaOuAlunos,
      'dtEntrega': dtEntrega,
      'valeNota': valeNota,
      'arquivo': arquivo,
    };
  }

  // Método para converter para o modelo local
  AtividadeModel toAtividadeModel() {
    return AtividadeModel(
      titulo: titulo,
      descricao: descricao,
      turmaOuAlunos: turmaOuAlunos,
      dtEntrega: dtEntrega,
      valeNota: valeNota as bool,
      arquivo: arquivo,
    );
  }
}
