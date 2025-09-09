import 'package:flutter/material.dart';
import '../models/financeiro_model.dart';

class AlunoTile extends StatelessWidget {
  final FinanceiroModel aluno;
  const AlunoTile({super.key, required this.aluno});

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: aluno.fotoUrl != null
          ? CircleAvatar(backgroundImage: NetworkImage(aluno.fotoUrl!))
          : const CircleAvatar(backgroundColor: Colors.grey),
      title: Text(aluno.nomeAluno),
      subtitle: Text(
        "Vencimento: ${aluno.vencimento.day}/${aluno.vencimento.month}/${aluno.vencimento.year} - ${aluno.estaPago ? "Pago" : "Pendente"}",
      ),
      trailing: Text("R\$${aluno.custoAula.toStringAsFixed(2)}"),
    );
  }
}