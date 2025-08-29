import 'package:flutter/material.dart';
import 'package:profmate/src/models/user_api_model.dart';
import 'package:profmate/src/services/user_api_service.dart';

class UserApiController {
  final UserApiService _service = UserApiService();

  Future<List<UserApiModel>> listarUsuario(BuildContext context) =>
      _service.getAll(context);
  Future<UserApiModel> criarUsuario(UserApiModel usuario) =>
      _service.create(usuario);
  Future<void> atualizarUsuario(UserApiModel usuario) => _service.update(usuario);
  Future<void> deletarUsuario(int id) => _service.delete(id);
  Future<void> buscarUsuario(int id) => _service.getOne(id);
}
