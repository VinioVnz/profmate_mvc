import '../models/aula_model.dart';

class ProgressController {
  List<AulaModel> aulas = [
    AulaModel(titulo: 'Aula 1 - Introdução a Dart', concluida: true),
    AulaModel(titulo: 'Aula 2 - Estruturas Condicionais'),
    AulaModel(titulo: 'Aula 3 - Laços de Repetição'),
    AulaModel(titulo: 'Aula 4 - POO'),
    AulaModel(titulo: 'Aula 5 - Introdução a Flutter'),
  ];

  double calcularProgresso() {
    int concluidas = aulas.where((aula) => aula.concluida).length;
    return concluidas / aulas.length;
  }
}
