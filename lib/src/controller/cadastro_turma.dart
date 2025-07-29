import 'package:profmate/src/models/aluno_model.dart';
import 'package:profmate/src/models/turma_model.dart';

class CadastroTurma {
  void adicionarAluno(Aluno aluno) {
    TurmaModel turmaModel = TurmaModel();
    turmaModel.turma.add(aluno);
  }

  /* void removerAluno(Aluno aluno){

  } */
}
