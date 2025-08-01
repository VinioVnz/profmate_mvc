import 'package:flutter/material.dart';
import 'package:profmate/src/models/aluno_api_model.dart';
import 'package:profmate/src/services/aluno_service.dart';

class CadastroAlunoController {
  //Controllers dos campos de formulário:
  final nomeController = TextEditingController();
  final cpfController = TextEditingController();
  final emailController = TextEditingController();
  final enderecoController = TextEditingController();
  final telefoneController = TextEditingController();
  final nomeResponsavelController = TextEditingController();
  final cpfResponsavelController = TextEditingController();
  final dataNascimentoController = TextEditingController();

  //dispose e clear:
  void dispose() {
    nomeController.dispose();
    cpfController.dispose();
    emailController.dispose();
    enderecoController.dispose();
    telefoneController.dispose();
    nomeResponsavelController.dispose();
    cpfResponsavelController.dispose();
  }

  void clear() {
    nomeController.clear();
    cpfController.clear();
    emailController.clear();
    enderecoController.clear();
    telefoneController.clear();
    nomeResponsavelController.clear();
    cpfResponsavelController.clear();
  }

  //CRUD:
  final AlunoService _service = AlunoService();
  Future<List<AlunoApiModel>> listarAluno(BuildContext context) =>
      _service.getAll(context);
  Future<void> criarAluno(AlunoApiModel aluno) => _service.create(aluno);
  Future<void> atualizarAluno(AlunoApiModel aluno) => _service.update(aluno);
  Future<void> deletarAluno(int id) => _service.delete(id);
  Future<void> buscarAluno(int id) => _service.getOne(id);
}
