import 'dart:convert';

import 'package:flutter/widgets.dart';
import 'package:profmate/src/models/aluno_api_model.dart';
import 'package:profmate/src/models/user_api_model.dart';
import 'package:profmate/src/services/auth_service.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;

class UserApiService {
  //trocar para a url do servidor depois
  final String baseUrl = 'http://10.0.2.2:3000';

  Future<String?> _getToken() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getString('jwt_token');
  }

  Future<List<UserApiModel>> getAll(BuildContext context) async {
    final token = await _getToken();

    final response = await http.get(
      Uri.parse('$baseUrl/usuarios'),
      headers: {'Authorization': 'Bearer $token'},
    );

    if (response.statusCode == 401) {
      await AuthService().logout();
      if (context.mounted) {
        Navigator.pushReplacementNamed(context, '/login');
      }
      throw Exception('Usuário não autorizado');
    } else if (response.statusCode == 200) {
      final List data = jsonDecode(response.body);
      return data.map((e) => UserApiModel.fromJson(e)).toList();
    } else {
      throw Exception('Erro ao buscar usuarios');
    }
  }

  Future<UserApiModel> create(UserApiModel usuario) async {
    final _token = await _getToken();
    final response = await http.post(
      Uri.parse('$baseUrl/usuarios'),
      headers: {
        'Authorization': 'Baerer $_token',
        'Content-Type': 'application/json',
      },
      body: jsonEncode(usuario.toJson()),
    );
    if (response.statusCode == 201 || response.statusCode == 200) {
      final Map<String, dynamic> json = jsonDecode(response.body);
      return UserApiModel.fromJson(json);
    } else {
      throw Exception('Erro ao criar usuario. Código: ${response.statusCode}');
    }
  }

  Future<void> update(UserApiModel usuario) async {
    final _token = await _getToken();

    await http.put(
      Uri.parse('$baseUrl/usuarios/${usuario.id}'),
      headers: {
        'Authorization': 'Bearer $_token',
        'Content-Type': 'application/json',
      },
      body: jsonEncode(usuario.toJson()),
    );
  }

  Future<void> delete(int id) async {
    final _token = await _getToken();

    final response = await http.delete(
      Uri.parse('$baseUrl/usuarios/$id'),
      headers: {'Authorization': 'Baerer $_token'},
    );
    if(response.statusCode == 201 || response.statusCode == 200){
      print('TA FUUNCIONANDO CPA');
    } else{
      print('DEU RUIM FIOTE');
    }
  }

  Future<void> getOne(int id) async {
    final _token = await _getToken();
    final response = await http.get(
      Uri.parse('$baseUrl/usuarios/$id'),
      headers: {'Authorization': 'Bearer $_token'},
    );
    if (response.statusCode == 404) {
      throw Exception("Aluno não encontrado.");
    }
  }
}
