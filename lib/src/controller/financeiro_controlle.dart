import '../models/aluno_model.dart';

class FinanceiroController {
  List<Aluno> getAlunosPendentes() {
    return [
      Aluno(nome: "Elynn Lee", vencimento: "11/04/25", valor: 250, fotoUrl: ""),
      Aluno(nome: "Oscar Dum", vencimento: "15/06/25", valor: 250, fotoUrl: ""),
      // Adicione os outros...
    ];
  }

  double getTotalRecebido() {
    return 45678.90; // Simulado
  }

  int getTotalPendentes() {
    return getAlunosPendentes().length;
  }
}
