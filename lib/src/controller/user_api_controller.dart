import 'package:flutter/material.dart';
import 'package:profmate/src/models/user_api_model.dart';
import 'package:profmate/src/services/user_api_service.dart';

class UserApiController {
  final UserApiService _service = UserApiService();

  Future<List<UserApiModel>> listarAluno(BuildContext context) =>
      _service.getAll(context);
  Future<UserApiModel> criarAluno(UserApiModel usuario) =>
      _service.create(usuario);
  Future<void> atualizarAluno(UserApiModel usuario) => _service.update(usuario);
  Future<void> deletarAluno(int id) => _service.delete(id);
  Future<void> buscarAluno(int id) => _service.getOne(id);
}
