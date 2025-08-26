import 'package:flutter/material.dart';
import 'package:profmate/src/controller/tarefa_api_controller.dart';
import 'package:profmate/src/controller/tarefas_controller.dart';
import 'package:profmate/src/models/tarefa_api_model.dart';
import 'package:profmate/src/models/tarefas_model.dart';
import 'package:profmate/src/utils/date_converter_util.dart';
import 'package:profmate/src/widgets/custom_dialog.dart';
import 'package:shared_preferences/shared_preferences.dart';

enum FiltroTarefa { pendentes, conluidas }

class TarefasView extends StatefulWidget {
  const TarefasView({super.key, required this.controller});

  final TarefasController controller;

  @override
  State<TarefasView> createState() => _TarefasViewState();
}

class _TarefasViewState extends State<TarefasView> {
  FiltroTarefa filtroSelecionado = FiltroTarefa.pendentes;
  final TextEditingController _adicionarTarefasController =
      TextEditingController();
  final TarefasApiController _controller = TarefasApiController();
  int? idUsuario;
  List<TarefaApiModel> tarefas = [];

  @override
  void initState() {
    super.initState();
    _carregarIdUsuario();
  }

  Future<void> _carregarTarefas() async {
    final todasTarefas = await _controller.listarTarefa(context);
    final filtradas = todasTarefas
        .where((t) => t.idUsuario == idUsuario)
        .toList();
    setState(() {
      tarefas = filtradas;
    });
    print("tarefas sem filtro $todasTarefas");
    print("ID do usuário: $idUsuario");
    print("tarefas carregadas: $filtradas");
  }

  void _carregarIdUsuario() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    final id = prefs.getInt('user_id');
    if (id != null) {
      setState(() {
        idUsuario = id;
      });
      _carregarTarefas();
    }
  }

  void _salvarTarefa() async {
    final TarefaApiModel tarefa = TarefaApiModel(
      titulo: 'tarefa',
      descricao: _adicionarTarefasController.text,
      dataEntrega: DateConverterUtil.toDatabaseFormat(DateTime.now()),
      idUsuario: idUsuario!,
      concluida: false,
    );
    await _controller.criarTarefa(tarefa);
    _carregarTarefas();
    Navigator.pop(context);
  }

  void _abrirAdicionarTarefa() {
    showModalBottomSheet(
      context: context,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      isScrollControlled: true,
      builder: (context) => Padding(
        padding: EdgeInsets.only(
          bottom: MediaQuery.of(context).viewInsets.bottom + 16,
          left: 16,
          right: 16,
          top: 16,
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const Text(
              'Nova tarefa',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 12),
            TextField(
              controller: _adicionarTarefasController,
              autofocus: true,
              decoration: const InputDecoration(
                hintText: 'Digite a tarefa',
                enabledBorder: OutlineInputBorder(
                  borderSide: BorderSide(
                    color: Color.fromARGB(255, 53, 91, 140),
                    width: 1.5,
                  ),
                ),
                focusedBorder: OutlineInputBorder(
                  borderSide: BorderSide(
                    color: Color.fromARGB(255, 53, 91, 140),
                    width: 2,
                  ),
                ),
              ),
            ),
            const SizedBox(height: 12),
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                TextButton(
                  onPressed: () => Navigator.pop(context),
                  child: const Text(
                    'Cancelar',
                    style: TextStyle(color: Color.fromARGB(255, 53, 91, 140)),
                  ),
                ),
                TextButton(
                  onPressed: () {
                    _salvarTarefa();
                    /*final texto = _adicionarTarefasController.text.trim();
                     if (texto.isNotEmpty) {
                      widget.controller.adicionaTarefa(texto);
                      Navigator.pop(context);
                    } */
                  },
                  child: const Text(
                    'Adicionar',
                    style: TextStyle(color: Color.fromARGB(255, 53, 91, 140)),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16),
      child: Center(
        child: Column(
          children: [
            Container(
              width: double.infinity,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(12),
              ),
              child: SegmentedButton<FiltroTarefa>(
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
                  backgroundColor: WidgetStateProperty.resolveWith<Color?>(
                    (states) => states.contains(WidgetState.selected)
                        ? Colors.black
                        : Colors.white,
                  ),
                  foregroundColor: WidgetStateProperty.resolveWith<Color?>(
                    (states) => states.contains(WidgetState.selected)
                        ? Colors.white
                        : Colors.black,
                  ),
                ),
              ),
            ),
            const SizedBox(height: 16),

            Expanded(
              child: tarefas.isEmpty
                  ? const Center(child: Text('Nenhuma tarefa aqui.'))
                  : ListView.builder(
                      itemCount: tarefas.length,
                      itemBuilder: (context, i) {
                        final tarefa = tarefas[i];

                        // aplica filtro antes de exibir
                        if (filtroSelecionado == FiltroTarefa.pendentes &&
                            tarefa.concluida) {
                          return const SizedBox.shrink(); // não mostra se for concluída
                        }
                        if (filtroSelecionado == FiltroTarefa.conluidas &&
                            !tarefa.concluida) {
                          return const SizedBox.shrink(); // não mostra se não for concluída
                        }

                        return Card(
                          color: Colors.white,
                          elevation: 3,
                          child: ListTile(
                            leading: Checkbox(
                              value: tarefa.concluida,
                              onChanged: (bool? novoValor) async {
                                if (novoValor != null) {
                                  setState(() {
                                    tarefa.concluida = novoValor;
                                  });
                                  // chama a API para atualizar no banco
                                  await _controller.atualizarTarefa(tarefa);
                                }
                              },
                            ),
                            title: Text(
                              tarefa.titulo,
                              style: tarefa.concluida
                                  ? const TextStyle(
                                      decoration: TextDecoration.lineThrough,
                                      color: Colors.grey,
                                    )
                                  : null,
                            ),
                            subtitle: Text(tarefa.descricao),
                            trailing: IconButton(
                              icon: const Icon(Icons.delete),
                              onPressed: () async {
                                final confirmar = await showDialog<bool>(
                                  context: context,
                                  builder: (context) => CustomDialog(
                                    titulo: 'Excluir tarefa',
                                    mensagem: 'Deseja realmente excluir essa tarefa?',
                                    aoCancelar: () => Navigator.pop(context, false),
                                    aoConfirmar: () => Navigator.pop(context, true),
                                    ),                                    
                                );
                                
                            

                                if (confirmar == true) {
                                  await _controller.deletarTarefa(tarefa.id!);
                                  _carregarTarefas(); // recarrega lista
                                }
                              },
                            ),
                          ),
                        );
                      },
                    ),
            ),

            SizedBox(
              width: double.infinity,
              child: ElevatedButton.icon(
                icon: Icon(Icons.add, color: Colors.white),
                label: Text(
                  "Adicionar tarefa",
                  style: TextStyle(color: Colors.white),
                ),
                onPressed: () {
                  _abrirAdicionarTarefa();
                },
                style: ElevatedButton.styleFrom(backgroundColor: Colors.black),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
