import 'package:flutter/material.dart';
import 'package:profmate/src/controller/atividade_controller.dart';
import 'package:profmate/src/models/atividade_model.dart';
import 'package:profmate/src/views/atividade_detalhes_view.dart';
import 'package:profmate/src/widgets/card_atividades.dart';
import 'package:profmate/src/widgets/custom_elevated_button.dart';

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

    if (result == true) _carregarAtividades();
  }

  void _navegarParaCriarAtividade() async {
    final result = await Navigator.pushNamed(
      context,
      '/adicionar_atividade_view',
    );

    print('Voltou da tela de criar, recarregando...');
    _carregarAtividades();
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
                        print('Mostrando ${atividades.length} atividades');

                        if (atividades.isEmpty) {
                          return const Center(
                            child: Text(
                              'Não há atividades cadastradas',
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
                              onEdit: () => {}, //editar atv
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
          Padding(
            padding: const EdgeInsets.all(16),
            child: CustomElevatedButton(
              tituloBotao: 'Criar atividade',
              onPressed: _navegarParaCriarAtividade,
            ),
          ),
        ],
      ),
    );
  }
}
