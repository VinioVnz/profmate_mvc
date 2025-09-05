import 'package:flutter/widgets.dart';
import 'package:profmate/src/models/aula_api_model.dart';
import 'package:profmate/src/services/aula_service.dart';

class AulaApiController {
  final AulaService _service = AulaService();

  Future<List<AulaApiModel>> listarAulas(BuildContext context) =>
      _service.getAll(context);
  Future<void> criarAula(AulaApiModel aula) => _service.create(aula);
  Future<void> deletarAula(int id) => _service.delete(id);
  Future<void> buscarAula(int id) => _service.getOne(id);
  Future<void> atualizarAula(AulaApiModel aula) => _service.update(aula);


}
