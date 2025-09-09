import 'package:flutter/material.dart';
import 'package:profmate/src/models/financeiro_model.dart';
import 'package:profmate/src/services/financeiro_service.dart';

class FinanceiroController {
  final vencimento = TextEditingController();
  final nomeAluno = TextEditingController();
  final custoAula = TextEditingController();

  final ValueNotifier<bool> isLoading = ValueNotifier<bool>(false);
  final ValueNotifier<String?> errorMessage = ValueNotifier<String?>(null);

  // Notifier que guarda a lista de pagamentos
  final ValueNotifier<List<FinanceiroModel>> pagamentos =
      ValueNotifier<List<FinanceiroModel>>([]);

  final FinanceiroService _service = FinanceiroService();

  // Carrega todos os pagamentos e atualiza o ValueNotifier
  Future<void> listarPagamento(BuildContext context) async {
    try {
      isLoading.value = true;
      errorMessage.value = null;

      final result = await _service.getAll(context);
      pagamentos.value = result;
    } catch (e) {
      errorMessage.value = e.toString();
    } finally {
      isLoading.value = false;
    }
  }

  // Libera os controllers e notifiers
  void dispose() {
    vencimento.dispose();
    nomeAluno.dispose();
    custoAula.dispose();
    isLoading.dispose();
    errorMessage.dispose();
    pagamentos.dispose();
  }

  void clear() {
    vencimento.clear();
    nomeAluno.clear();
    custoAula.clear();
  }

  // CRUD
  Future<void> criarPagamento(FinanceiroModel pagamento) async {
    await _service.create(pagamento);
  }

  Future<void> atualizarPagamento(FinanceiroModel pagamento) async {
    await _service.update(pagamento);
  }

  Future<void> deletarPagamento(FinanceiroModel pagamento) async {
    await _service.delete(int.parse(pagamento.id)); // forçando não nulo
  }

  Future<FinanceiroModel> buscarPagamento(FinanceiroModel pagamento) async {
    return await _service.getOne(int.parse(pagamento.id)); // forçando não nulo
  }

  // Total recebido (soma dos pagos)
  double getTotalRecebido() {
    return pagamentos.value.fold<double>(
      0.0,
      (prev, p) => prev + (p.estaPago ? p.custoAula : 0.0),
    );
  }

  // Quantidade de pendentes
  int getTotalPendentes() {
    return pagamentos.value.where((p) => !p.estaPago).length;
  }
}
