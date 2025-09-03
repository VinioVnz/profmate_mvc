import 'package:flutter/cupertino.dart';
import 'package:profmate/src/models/financeiro_model.dart';
import 'package:profmate/src/services/financeiro_service.dart';

class FinanceiroController {
  final vencimento = TextEditingController();
  final nomeAluno = TextEditingController();
  final custoAula = TextEditingController();

  final ValueNotifier<bool> isLoading = ValueNotifier<bool>(false);
  final ValueNotifier<String?> errorMessage = ValueNotifier<String?>(null);

  Future<void> alunoFinanceiro(BuildContext context) async {
    isLoading.value = true;
    errorMessage.value = null;

     List<FinanceiroModel> pagamento = [
      FinanceiroModel(nomeAluno: 'João Silva', vencimento: DateTime(2025, 9, 10), custoAula: 50.0),
      FinanceiroModel(nomeAluno: 'Maria Souza', vencimento: DateTime(2025, 9, 12), custoAula: 60.0),
      FinanceiroModel(nomeAluno: 'Lucas Lima', vencimento: DateTime(2025, 9, 15), custoAula: 55.0),
    ];

    void dispose(){
      vencimento.dispose();
      nomeAluno.dispose();
      custoAula.dispose();

    }

    void clear(){
      vencimento.clear();
      nomeAluno.clear();
      custoAula.clear();
    }

         //CRUD:
  final FinanceiroService _service = FinanceiroService();
  Future<List<FinanceiroModel>> listarPagamento(BuildContext context) =>
      _service.getAll(context);
  Future<void> criarPagamento(FinanceiroModel pagamento) => _service.create(pagamento);
  Future<void> atualizarPagamento(FinanceiroModel pagamento) => _service.update(pagamento);
  Future<void> deletarPagamento(int id) => _service.delete(id);
  Future<void> buscarPagamento(int id) => _service.getOne(id);

}