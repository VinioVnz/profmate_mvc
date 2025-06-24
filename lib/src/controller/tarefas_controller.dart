import 'package:flutter/foundation.dart';
import 'package:profmate/src/models/tarefas_model.dart';

class TarefasController {
  final ValueNotifier<List<TarefasModel>> tarefas =
      ValueNotifier<List<TarefasModel>>([]);

  void adicionaTarefa(String texto) {
    if (texto.isEmpty) return;
    final novaTarefa = TarefasModel(texto);
    tarefas.value = List<TarefasModel>.from(tarefas.value)
      ..add(novaTarefa);
  }

 void concluirTarefa(TarefasModel tarefa) {
  final listaAtualizada = List<TarefasModel>.from(tarefas.value);
  final index = listaAtualizada.indexOf(tarefa);
  if (index != -1) {
    listaAtualizada[index].concluida = !listaAtualizada[index].concluida;
    tarefas.value = listaAtualizada;
  }
}

void excluirTarefa(TarefasModel tarefa){
  final listaAtualizada = List<TarefasModel>.from(tarefas.value);
  listaAtualizada.remove(tarefa);
  tarefas.value = listaAtualizada;
}
  
}
