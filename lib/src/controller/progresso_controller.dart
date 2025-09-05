import 'package:profmate/src/models/ementa_api_model.dart';

class ProgressoController {
double calcularProgresso(List<EmentaApiModel> ementas) {
  if (ementas.isEmpty) return 0.0;
  final concluidas = ementas.where((e) => e.concluida).length;
  return concluidas / ementas.length;

}
}

