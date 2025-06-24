import 'package:flutter/foundation.dart';
import 'package:profmate/src/models/tarefas_model.dart';

class TarefasController {
  final ValueNotifier<List<TarefasModel>> tarefas =
      ValueNotifier<List<TarefasModel>>([]);

  void adicionaTarefa(String texto) {
    if (texto.isEmpty) return;
    final novaTarefa = TarefasModel(texto, DateTime.now());
    tarefas.value = List<TarefasModel>.from(tarefas.value)
      ..add(novaTarefa);
  }

  void concluirTarefa(int index){
    final tarefasConcluidas = List<TarefasModel>.from(tarefas.value);
    tarefasConcluidas[index].concluida = ! tarefasConcluidas[index].concluida;
    tarefas.value = tarefasConcluidas;

  }

  
}
