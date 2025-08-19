import 'package:flutter/material.dart';
import 'package:profmate/src/models/atividade_model.dart';
import 'package:profmate/src/widgets/base_layout.dart';
import 'package:profmate/src/widgets/card_atividades.dart';

class AtividadeDetalhesView extends StatelessWidget {
  final AtividadeModel atividade;

  AtividadeDetalhesView({super.key, required this.atividade});

  /*   void editarAtividade(int index) {
    final atividades = controller.atividades.value;
    if (index < atividades.length) {
      print('Editar atividade: ${atividades[index].titulo}');
    } else {
      print('Atividade não encontrada');
    }
  } */
  @override
  Widget build(BuildContext context) {
    return BaseLayout(
      title: 'Detalhes da atividade',
      body: Expanded(child: CardAtividades(atividade: atividade)),
    );
  }
}
