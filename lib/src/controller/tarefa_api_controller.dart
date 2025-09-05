import 'package:flutter/material.dart';
import 'package:profmate/src/models/tarefa_api_model.dart';
import 'package:profmate/src/services/tarefa_service.dart';

class TarefasApiController {
  final TarefaService _service = TarefaService();
  Future<List<TarefaApiModel>> listarTarefa(BuildContext context) =>
      _service.getAll(context);
  Future<void> criarTarefa(TarefaApiModel tarefa) => _service.create(tarefa);
  Future<void> atualizarTarefa(TarefaApiModel tarefa) => _service.update(tarefa);
  Future<void> deletarTarefa(int id) => _service.delete(id);
  Future<void> buscarTarefa(int id) => _service.getOne(id);
}