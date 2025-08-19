import 'dart:convert';

import 'package:flutter/widgets.dart';
import 'package:profmate/src/models/atividade_model.dart';
import 'package:profmate/src/services/auth_service.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;

class AtividadeService {
  //trocar para a url do servidor depois
  final String baseUrl = 'http://10.0.2.2:3000';

  Future<String?> _getToken() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getString('jwt_token');
  }

  Future<List<AtividadeModel>> getAll(BuildContext context) async {
    final token = await _getToken();

    final response = await http.get(
      Uri.parse('$baseUrl/atividades'),
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
      return data.map((e) => AtividadeModel.fromJson(e)).toList();
    } else {
      throw Exception('Erro ao buscar atividades');
    }
  }

  Future<AtividadeModel> create(AtividadeModel atividade) async {
    final _token = await _getToken();
    final response = await http.post(
      Uri.parse('$baseUrl/atividades'),
      headers: {
        'Authorization': 'Bearer $_token',
        'Content-Type': 'application/json',
      },
      body: jsonEncode(atividade.toJson()),
    );
    if (response.statusCode == 201 || response.statusCode == 200) {
      final Map<String, dynamic> json = jsonDecode(response.body);
      return AtividadeModel.fromJson(json);
    } else {
      throw Exception(
        'Erro ao criar atividade. Código: ${response.statusCode}',
      );
    }
  }

  Future<void> update(AtividadeModel atividade) async {
    final _token = await _getToken();

    final response = await http.put(
      Uri.parse('$baseUrl/atividades/${atividade.titulo}'), //precisa criar o id
      headers: {
        'Authorization': 'Bearer $_token',
        'Content-Type': 'application/json',
      },
      body: jsonEncode(atividade.toJson()),
    );

    if (response.statusCode != 200 && response.statusCode != 204) {
      throw Exception(
        'Erro ao atualizar atividade. Código: ${response.statusCode}',
      );
    }
  }

  Future<void> delete(int id) async {
    final _token = await _getToken();

    final response = await http.delete(
      Uri.parse('$baseUrl/atividades/$id'),
      headers: {'Authorization': 'Bearer $_token'},
    );

    if (response.statusCode == 200 || response.statusCode == 204) {
      print('Atividade deletada com sucesso');
    } else {
      throw Exception(
        'Erro ao deletar atividade. Código: ${response.statusCode}',
      );
    }
  }

  Future<AtividadeModel> getOne(int id) async {
    final _token = await _getToken();
    final response = await http.get(
      Uri.parse('$baseUrl/atividades/$id'),
      headers: {'Authorization': 'Bearer $_token'},
    );

    if (response.statusCode == 404) {
      throw Exception("Atividade não encontrada.");
    } else if (response.statusCode == 200) {
      final Map<String, dynamic> json = jsonDecode(response.body);
      return AtividadeModel.fromJson(json);
    } else {
      throw Exception(
        'Erro ao buscar atividade. Código: ${response.statusCode}',
      );
    }
  }
}
