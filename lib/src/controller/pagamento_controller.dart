
import 'package:flutter/widgets.dart';
import 'package:profmate/src/models/pagamento_api_model.dart';
import 'package:profmate/src/services/pagamento_service.dart';


class PagamentoController {
  final vencimentoController = TextEditingController();
  final frequenciaPagamentoController = TextEditingController();
  final formaPagamentoController = TextEditingController();
  final valorAulaController = TextEditingController();
  void dispose(){
    vencimentoController.dispose();
    frequenciaPagamentoController.dispose();
    formaPagamentoController.dispose();
    valorAulaController.dispose();
  }

  void clear(){
    vencimentoController.clear();
    frequenciaPagamentoController.clear();
    formaPagamentoController.clear();
    valorAulaController.clear();
  }

      //CRUD:
  final PagamentoService _service = PagamentoService();
  Future<List<PagamentoApiModel>> listarPagamento(BuildContext context) =>
      _service.getAll(context);
  Future<void> criarPagamento(PagamentoApiModel pagamento) => _service.create(pagamento);
  Future<void> atualizarPagamento(PagamentoApiModel pagamento) => _service.update(pagamento);
  Future<void> deletarPagamento(int id) => _service.delete(id);
  Future<void> buscarPagamento(int id) => _service.getOne(id);

}
