import 'package:flutter/material.dart';
import 'package:profmate/src/controller/tarefa_api_controller.dart';
import 'package:profmate/src/controller/tarefas_controller.dart';
import 'package:profmate/src/models/tarefa_api_model.dart';
import 'package:profmate/src/models/tarefas_model.dart';
import 'package:profmate/src/utils/date_converter_util.dart';
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
   final TextEditingController _adicionarTarefasController = TextEditingController();
  final TarefasApiController _controller = TarefasApiController();
  int? idUsuario;
  @override
  void initState() {
    super.initState();
    _carregarIdUsuario();
  }

  void _carregarIdUsuario() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      idUsuario = prefs.getInt(
        'user_id',
      ); // 'user_id' é a chave que salvamos no login
    });
  }

  void _salvarTarefa() async{
      final TarefaApiModel tarefa = TarefaApiModel(
      titulo: 'tarefa', 
      descricao: _adicionarTarefasController.text, 
      dataEntrega: DateConverterUtil.toDatabaseFormat(DateTime.now()), 
      idUsuario: idUsuario!
      ); 
      await _controller.criarTarefa(tarefa);
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
                    final texto = _adicionarTarefasController.text.trim();
                    if (texto.isNotEmpty) {
                      widget.controller.adicionaTarefa(texto);
                      Navigator.pop(context);
                    }
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
              child: ValueListenableBuilder<List<TarefasModel>>(
                valueListenable: widget.controller.tarefas,
                builder: (context, lista, _) {
                  final tarefasFiltradas = lista.asMap().entries.where((entry) {
                    final tarefa = entry.value;
                    return filtroSelecionado == FiltroTarefa.pendentes
                        ? !tarefa.concluida
                        : tarefa.concluida;
                  }).toList();

                  if (tarefasFiltradas.isEmpty) {
                    return const Center(child: Text('Nenhuma tarefa aqui.'));
                  }

                  return ListView.builder(
                    itemCount: tarefasFiltradas.length,
                    itemBuilder: (context, i) {
                      final entry = tarefasFiltradas[i];
                      final tarefa = entry.value;
                      final indexOriginal = entry.key;

                      return Card(
                        color: Colors.white,
                        elevation: 3,
                        child: ListTile(
                          leading: Checkbox(
                            value: tarefa.concluida,
                            fillColor: WidgetStateProperty.resolveWith<Color?>((
                              states,
                            ) {
                              if (states.contains(WidgetState.selected)) {
                                return Color.fromARGB(255, 53, 91, 140);
                              }
                              return null;
                            }),
                            onChanged: (bool? novoValor) {
                              if (novoValor != null) {
                                widget.controller.concluirTarefa(tarefa);
                              }
                            },
                          ),
                          title: Text(
                            tarefa.texto,
                            style: tarefa.concluida
                                ? const TextStyle(
                                    decoration: TextDecoration.lineThrough,
                                    color: Colors.grey,
                                  )
                                : null,
                          ),
                          trailing: IconButton(
                            onPressed: () async {
                              final confirmar = await showDialog<bool>(
                                context: context,
                                builder: (context) => AlertDialog(
                                  backgroundColor: Colors.white,
                                  title: const Text('Excluir tarefa'),
                                  content: const Text(
                                    'Deseja realmente excluir essa tarefa?',
                                  ),
                                  actions: [
                                    TextButton(
                                      onPressed: () =>
                                          Navigator.of(context).pop(false),
                                      child: const Text(
                                        'Cancelar',
                                        style: TextStyle(
                                          color: Color.fromARGB(
                                            255,
                                            53,
                                            91,
                                            140,
                                          ),
                                        ),
                                      ),
                                    ),
                                    TextButton(
                                      onPressed: () =>
                                          Navigator.of(context).pop(true),
                                      child: const Text(
                                        'Excluir',
                                        style: TextStyle(
                                          color: Color.fromARGB(
                                            255,
                                            53,
                                            91,
                                            140,
                                          ),
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              );
                              if (confirmar == true) {
                                widget.controller.excluirTarefa(tarefa);
                              }
                            },
                            icon: Icon(Icons.delete),
                          ),
                        ),
                      );
                    },
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
