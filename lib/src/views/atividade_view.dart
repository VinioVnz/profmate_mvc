import 'package:flutter/material.dart';
import 'package:profmate/src/controller/atividade_controller.dart';
import 'package:profmate/src/models/atividade_model.dart';
import 'package:profmate/src/views/atividade_detalhes_view.dart';
import 'package:profmate/src/widgets/card_atividades.dart';
import 'package:profmate/src/widgets/custom_app_bar.dart';

class AtividadeView extends StatefulWidget {
  const AtividadeView({super.key});

  @override
  State<AtividadeView> createState() => _AtividadeViewState();
}

class _AtividadeViewState extends State<AtividadeView> {
  late AtividadeController controller;

  @override
  void initState() {
    super.initState();
    controller = AtividadeController();
    _carregarAtividades();
  }

  void _carregarAtividades() async {
    await controller.listarAtividades(context);
    setState(() {});
  }

  void _verDetalhesAtividade(AtividadeModel atividade) async {
    final result = await Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => AtividadeDetalhesView(atividade: atividade),
      ),
    );

    if (result == true) _carregarAtividades(); // Recarrega se houve mudança
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.only(left: 16.0, top: 16.0),
            child: Row(
              children: [
                ElevatedButton(
                  onPressed: () async {
                    final result = await Navigator.pushNamed(
                      context,
                      '/adicionar_atividade_view',
                    );
                    if (result == true) {
                      _carregarAtividades();
                    }
                  },
                  child: const Text("Criar nova atividade"),
                ),
              ],
            ),
          ),
          Expanded(
            child: ValueListenableBuilder<bool>(
              valueListenable: controller.isLoading,
              builder: (context, isLoading, _) {
                if (isLoading) {
                  return const Center(child: CircularProgressIndicator());
                }

                return ValueListenableBuilder<String?>(
                  valueListenable: controller.errorMessage,
                  builder: (context, errorMessage, _) {
                    if (errorMessage != null) {
                      return Center(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              errorMessage,
                              style: const TextStyle(
                                fontSize: 16,
                                color: Colors.red,
                              ),
                              textAlign: TextAlign.center,
                            ),
                            const SizedBox(height: 16),
                            ElevatedButton(
                              onPressed: _carregarAtividades,
                              child: const Text('Tentar novamente'),
                            ),
                          ],
                        ),
                      );
                    }

                    return ValueListenableBuilder<List<AtividadeModel>>(
                      valueListenable: controller.atividades,
                      builder: (context, atividades, _) {
                        if (atividades.isEmpty) {
                          return const Center(
                            child: Text(
                              'Não encontramos atividades cadastradas.',
                              style: TextStyle(fontSize: 16),
                            ),
                          );
                        }

                        return ListView.builder(
                          itemCount: atividades.length,
                          itemBuilder: (context, index) {
                            final atividade = atividades[index];
                            return CardAtividades(
                              atividade: atividade,
                              onTap: () => _verDetalhesAtividade(atividade),
                              onEdit: () => {}, //editarAtividade(index),
                            );
                          },
                        );
                      },
                    );
                  },
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
