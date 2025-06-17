import 'package:flutter/foundation.dart';
import 'package:profmate/src/models/mural_model.dart';

class MuralController {
  final ValueNotifier<List<MuralModel>> recados =
      ValueNotifier<List<MuralModel>>([]);

  void adicionaRecado(String texto) {
    if (texto.isEmpty) return;
    final novoRecado = MuralModel(texto, DateTime.now());
    recados.value = List<MuralModel>.from(recados.value)
      ..add(novoRecado);
  }

  void deletarRecado(MuralModel recado) {
    recados.value = List<MuralModel>.from(recados.value)
      ..remove(recado);
  }
}
