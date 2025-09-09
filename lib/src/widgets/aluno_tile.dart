import 'package:flutter/material.dart';
import 'package:profmate/src/models/aluno_api_model.dart';
import 'package:profmate/src/models/pagamento_api_model.dart';
import 'package:profmate/theme/app_colors.dart';

class AlunoTile extends StatelessWidget {
  final AlunoApiModel aluno;
  final PagamentoApiModel pagamento;

  const AlunoTile({
    super.key, 
    required this.aluno,
    required this.pagamento,
  });

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: CircleAvatar(
        backgroundColor: AppColors.azulEscuro,
        radius: 35,
        child: const Icon(
          Icons.person,
          size: 50,
          color: Colors.white,
        ),
      ),
      title: Text(aluno.nome),
      subtitle: Text("Vencimento: ${pagamento.vencimento}"),
      trailing: Text("R\$${pagamento.valorAula.toStringAsFixed(2)}"),
    );
  }
}
