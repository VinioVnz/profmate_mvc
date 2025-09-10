import 'package:flutter/material.dart';
import 'package:profmate/src/widgets/base_layout.dart';
import '../controller/atividade_controller.dart';
import '../models/atividade_model.dart';
import '../views/adicionar_atividade_view.dart';
import '../widgets/custom_app_bar.dart';
import '../widgets/custom_elevated_button.dart'; // ADICIONE ESTE IMPORT

class AtividadesView extends StatefulWidget {
  const AtividadesView({super.key});

  @override
  State<AtividadesView> createState() => _AtividadesViewState();
}

class _AtividadesViewState extends State<AtividadesView> {
  final AtividadeController _controller = AtividadeController();

  @override
  void initState() {
    super.initState();
    _controller.listarAtividades();
  }

  Future<void> _abrirAdicionarAtividade() async {
    final result = await Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => const AdicionarAtividadeView()),
    );
    if (result != null) {
      await _controller.listarAtividades();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          Expanded(
            child: ValueListenableBuilder<List<AtividadeModel>>(
              valueListenable: AtividadeController.atividades,
              builder: (context, lista, _) {
                if (lista.isEmpty) {
                  return const Center(
                    child: Text(
                      "Nenhuma atividade cadastrada.",
                      style: TextStyle(height: 16),
                    ),
                  );
                }
                return ListView.builder(
                  itemCount: lista.length,
                  itemBuilder: (context, index) {
                    final atividade = lista[index];
                    return Card(
                      margin: const EdgeInsets.all(8),
                      child: ListTile(
                        title: Text(atividade.titulo),
                        subtitle: Text(
                          "${atividade.descricao}\nEntrega: ${atividade.dtEntrega}\nVale nota: ${atividade.valeNota ? 'Sim' : 'Não'}",
                        ),
                        isThreeLine: true,
                      ),
                    );
                  },
                );
              },
            ),
          ),
          SizedBox(height: 20),
          Container(
            padding: const EdgeInsets.all(16.0),
            child: CustomElevatedButton(
              tituloBotao: 'Criar nova atividade',
              onPressed: _abrirAdicionarAtividade,
            ),
          ),
        ],
      ),
    );
  }
}
