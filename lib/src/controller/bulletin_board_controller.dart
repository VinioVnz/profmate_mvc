import 'package:flutter/foundation.dart';
import 'package:profmate/src/models/bulletin_board_model.dart';

class BulletinBoardController {
  final ValueNotifier<List<BulletinBoardModel>> recados =
      ValueNotifier<List<BulletinBoardModel>>([]);

  void adicionaRecado(String texto) {
    if (texto.isEmpty) return;
    final novoRecado = BulletinBoardModel(texto, DateTime.now());
    recados.value = List<BulletinBoardModel>.from(recados.value)
      ..add(novoRecado);
  }

  void deletarRecado(BulletinBoardModel recado) {
    recados.value = List<BulletinBoardModel>.from(recados.value)
      ..remove(recado);
  }
}
