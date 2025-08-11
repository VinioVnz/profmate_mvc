import 'dart:convert';

import 'package:flutter/widgets.dart';
import 'package:profmate/src/models/aluno_api_model.dart';
import 'package:profmate/src/services/auth_service.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;

class AlunoService {
  //trocar para a url do servidor depois
  final String baseUrl = 'http://10.0.2.2:3000';

  Future<String?> _getToken() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getString('jwt_token');
  }

  Future<List<AlunoApiModel>> getAll(BuildContext context) async {
    final token = await _getToken();

    final response = await http.get(
      Uri.parse('$baseUrl/alunos'),
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
      return data.map((e) => AlunoApiModel.fromJson(e)).toList();
    } else {
      throw Exception('Erro ao buscar alunos');
    }
  }

  Future<AlunoApiModel> create(AlunoApiModel aluno) async {
    final _token = await _getToken();
    final response = await http.post(
      Uri.parse('$baseUrl/alunos'),
      headers: {
        'Authorization': 'Baerer $_token',
        'Content-Type': 'application/json',
      },
      body: jsonEncode(aluno.toJson()),
    );
    if (response.statusCode == 201 || response.statusCode == 200) {
      final Map<String, dynamic> json = jsonDecode(response.body);
      return AlunoApiModel.fromJson(json);
    } else {
      throw Exception('Erro ao criar aluno. Código: ${response.statusCode}');
    }
  }

  Future<void> update(AlunoApiModel aluno) async {
    final _token = await _getToken();

    await http.put(
      Uri.parse('$baseUrl/alunos/${aluno.id}'),
      headers: {
        'Authorization': 'Bearer $_token',
        'Content-Type': 'application/json',
      },
      body: jsonEncode(aluno.toJson()),
    );
  }

  Future<void> delete(int id) async {
    final _token = await _getToken();

    final response = await http.delete(
      Uri.parse('$baseUrl/alunos/$id'),
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
      Uri.parse('$baseUrl/alunos/$id'),
      headers: {'Authorization': 'Bearer $_token'},
    );
    if (response.statusCode == 404) {
      throw Exception("Aluno não encontrado.");
    }
  }
}
