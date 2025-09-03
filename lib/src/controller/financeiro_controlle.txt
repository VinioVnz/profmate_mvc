import '../models/aluno_model.dart';

class FinanceiroController {
  List<Aluno> getAlunosPendentes() {
    return [
      Aluno(nome: "Maria Silva", vencimento: "10/08/25", valor: 250, fotoUrl: ""),
      Aluno(nome: "João Souza", vencimento: "10/08/25", valor: 250, fotoUrl: ""),
      // Adicione os outros...
    ];
  }

  double getTotalRecebido() {
    return 500.00; // Simulado
  }

  int getTotalPendentes() {
    return getAlunosPendentes().length;
  }
}