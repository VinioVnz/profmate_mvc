import 'package:flutter/material.dart';
import 'package:profmate/src/controller/tarefas_controller.dart';

enum FiltroTarefa { pendentes, conluidas }

class TarefasView extends StatefulWidget {
  const TarefasView({super.key, required this.controller});

  final TarefasController controller;

  @override
  State<TarefasView> createState() => _TarefasViewState();
}

class _TarefasViewState extends State<TarefasView> {
  FiltroTarefa filtroSelecionado = FiltroTarefa.pendentes;

  void _abrirAdicionarTarefa() {
    final TextEditingController _adicionarTarefasController =
        TextEditingController();

    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Nova Tarefa'),
        content: TextField(
          controller: _adicionarTarefasController,
          autofocus: true,
          decoration: const InputDecoration(hintText: 'Digite a tarefa'),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Cancelar'),
          ),
          TextButton(
            onPressed: () {
              final texto = _adicionarTarefasController.text.trim();
              if (texto.isNotEmpty) {
                widget.controller.adicionaTarefa(texto);
              }
              Navigator.pop(context);
            },
            child: const Text('Adicionar'),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: EdgeInsets.all(16),
        child: Center(
          child: Column(
            children: [
              SegmentedButton<FiltroTarefa>(
                segments: const [
                  ButtonSegment(
                    value: FiltroTarefa.pendentes,
                    label: Text("Pendentes"),
                  ),
                  ButtonSegment(
                    value: FiltroTarefa.conluidas,
                    label: Text("Concluídas"),
                  ),
                ],
                selected: <FiltroTarefa>{filtroSelecionado},
                onSelectionChanged: (Set<FiltroTarefa> newSelection) {
                  setState(() {
                    filtroSelecionado = newSelection.first;
                  });
                },
                style: ButtonStyle(
                  backgroundColor: WidgetStateProperty.resolveWith<Color?>((
                    states,
                  ) {
                    if (states.contains(WidgetState.selected)) {
                      return Colors.black;
                    }
                    return Colors.white;
                  }),
                  foregroundColor: WidgetStateProperty.resolveWith<Color?>((
                    states,
                  ) {
                    if (states.contains(WidgetState.selected)) {
                      return Colors.white;
                    }
                    return Colors.black;
                  }),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
