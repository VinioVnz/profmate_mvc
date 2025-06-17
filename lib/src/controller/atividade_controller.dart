import 'package:profmate/src/models/atividade_model.dart';

class AtividadeController {
  List<AtividadeModel> listarAtividades() {
    return [
      AtividadeModel(
        titulo: 'Trabalho de Inglês',
        descricao: 'Resolver exercícios (cap. 5 do book 2)',
        turma: 'Turma 301',
        entrega: '31/05/2025',
        entregues: 9,
        total: 30,
      ),
      AtividadeModel(
        titulo: 'Seminário de Inglês',
        descricao: 'Apresentação em grupo dos temas discutidos em sala de aula',
        turma: 'Turma 301',
        entrega: '01/06/2025',
        entregues: 10,
        total: 10,
      ),
      AtividadeModel(
        titulo: 'Exercício de Inglês',
        descricao: 'Resolver exercícios (cap. 10 do book 4)',
        turma: 'Turma 305',
        entrega: '06/06/2025',
        entregues: 5,
        total: 10,
      ),
    ];
  }
}
