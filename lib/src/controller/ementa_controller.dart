import 'package:flutter/cupertino.dart';
import 'package:profmate/src/services/ementa_service.dart';
import '../models/ementa_api_model.dart';

class EmentaController {
  final moduloController = TextEditingController();
  final topicoController = TextEditingController();
  final descricaoController = TextEditingController(); 

  void dispose() {
    moduloController.dispose();
    topicoController.dispose();
    descricaoController.dispose();
  }

  final EmentaService _service = EmentaService();
  Future<List<EmentaApiModel>> listarEmenta(BuildContext context) =>
  _service.getAll(context);
  Future<void> criarEmenta(EmentaApiModel ementa) => _service.create(ementa);
  Future<void> atualizarEmenta(EmentaApiModel ementa) => _service.update(ementa);
  Future<void> deletarEmenta(int id) => _service.delete(id);
  Future<void> buscarEmenta(int id) => _service.getOne(id);

}
