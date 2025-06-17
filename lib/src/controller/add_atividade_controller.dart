import 'package:profmate/src/views/add_Atividade.dart';

class AddAtividadeController {
  AddAtividade criarAtividade({
    required String titulo,
    required String descricao,
    required String turmaOuAlunos,
    required String dataEntrega,
    required bool valeNota,
    String? arquivo,
  }) {
    return AddAtividade(
      titulo: titulo,
      descricao: descricao,
      turmaOuAlunos: turmaOuAlunos,
      dataEntrega: dataEntrega,
      valeNota: valeNota,
      arquivo: arquivo,
    );
  }
}
