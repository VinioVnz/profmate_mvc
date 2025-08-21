import 'package:flutter/widgets.dart';
import 'package:profmate/src/services/aluno_service.dart';

class TurmaController {
  final nomeTurma = TextEditingController();
  final localTurma = TextEditingController();

  void dispose() {
    nomeTurma.dispose();
    localTurma.dispose();
  }

  void clear() {
    nomeTurma.clear();
    localTurma.clear();
  }

  /* 
  final AlunoService _service = AlunoService();
  Future<List<AlunoApiModel>> listarAluno(BuildContext context) =>
      _service.getAll(context);
  Future<AlunoApiModel> criarAluno(AlunoApiModel aluno) =>
      _service.create(aluno);
  Future<void> atualizarAluno(AlunoApiModel aluno) => _service.update(aluno);
  Future<void> deletarAluno(int id) => _service.delete(id);
  Future<void> buscarAluno(int id) => _service.getOne(id); */
}
