// ementa_controller.dart
import '../models/emente_model.dart';

class EmentaController {
  static final EmentaController _instance = EmentaController._internal();
  factory EmentaController() => _instance;
  EmentaController._internal();

  final List<EmentaModel> _ementas = [];

  List<EmentaModel> get ementas => _ementas;

  void salvarEmenta(EmentaModel ementa) {
    _ementas.add(ementa);
  }
}
