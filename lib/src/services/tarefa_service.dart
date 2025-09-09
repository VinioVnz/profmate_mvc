import 'dart:convert';

import 'package:flutter/widgets.dart';
import 'package:profmate/src/models/aula_api_model.dart';
import 'package:profmate/src/models/tarefa_api_model.dart';
import 'package:profmate/src/services/auth_service.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;

class TarefaService {
  /* final String baseUrl = 'http://10.0.2.2:3000'; */
   final String baseUrl = 'https://api-profmate.onrender.com';
  Future<String?> _getToken() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getString('jwt_token');
  }

  Future<List<TarefaApiModel>> getAll(BuildContext context) async {
    final token = await _getToken();

    final response = await http.get(
      Uri.parse('$baseUrl/tarefas'),
      headers: {'Authorization': 'Bearer $token'},
    );
    print('Status code: ${response.statusCode}');
    print('Body: ${response.body}');
    if (response.statusCode == 401) {
      await AuthService().logout();
      if (context.mounted) {
        Navigator.pushReplacementNamed(context, '/login');
      }
      throw Exception('Usuario não autorizado');
    } else if (response.statusCode == 200) {
      final List data = jsonDecode(response.body);
      return data.map((e) => TarefaApiModel.fromJson(e)).toList();
    } else {
      throw Exception('Erro ao buscar tarefa');
    }
  }

  Future<void> create(TarefaApiModel tarefa) async {
    final _token = await _getToken();
    await http.post(
      Uri.parse('$baseUrl/tarefas'),
      headers: {
        'Authorization': 'Bearer $_token',
        'Content-Type': 'application/json',
      },
      body: jsonEncode(tarefa.toJson()),
    );
  }

  Future<void> delete(int id) async {
    final _token = await _getToken();
    await http.delete(
      Uri.parse('$baseUrl/tarefas/$id'),
      headers: {'Authorization': 'Bearer $_token'},
    );
  }

  Future<void> getOne(int id) async {
    final _token = await _getToken();
    final response = await http.get(
      Uri.parse('$baseUrl/tarefas/$id'),
      headers: {'Authorization': 'Bearer $_token'},
    );
    if (response.statusCode == 404) {
      throw Exception("Tarefa não encontrada.");
    }
  }

  Future<void> update(TarefaApiModel tarefa) async {
    final _token = await _getToken();

    await http.put(
      Uri.parse('$baseUrl/tarefas/${tarefa.id}'),
      headers: {
        'Authorization': 'Bearer $_token',
        'Content-Type': 'application/json',
      },
      body: jsonEncode(tarefa.toJson()),
    );
  }
}
