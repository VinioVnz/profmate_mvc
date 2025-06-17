import 'package:flutter/material.dart';
import '../models/aluno_model.dart';

class AlunoTile extends StatelessWidget {
  final Aluno aluno;
  const AlunoTile({super.key, required this.aluno});

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: const CircleAvatar(backgroundColor: Colors.grey),
      title: Text(aluno.nome),
      subtitle: Text("Vencimento: ${aluno.vencimento}"),
      trailing: Text("R\$${aluno.valor.toStringAsFixed(2)}"),
    );
  }
}
