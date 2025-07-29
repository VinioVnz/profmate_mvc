import 'package:profmate/src/controller/ementa_controller.dart';
import 'package:profmate/src/models/ementa_model.dart';

class ProgressController {
  final EmentaController _ementaController = EmentaController();

  List<EmentaModel> get ementas => _ementaController.ementas;

  double calcularProgresso() {
    if (ementas.isEmpty) return 0.0;
    final concluidas = ementas.where((e) => e.concluida).length;
    return concluidas / ementas.length;
  }
}

