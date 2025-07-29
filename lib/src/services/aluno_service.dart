import 'dart:convert';

import 'package:flutter/widgets.dart';
import 'package:profmate/src/models/aluno_api_model.dart';
import 'package:profmate/src/services/auth_service.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;

class AlunoService {
  //trocar para a url do servidor depois
  final String baseUrl = 'http://10.0.2.2:3000';

  Future<String?> _getToken()async{
    final prefs = await SharedPreferences.getInstance();
    return prefs.getString('jwt_token');
  }

  Future<List<AlunoApiModel>> getAll(BuildContext context)async{
    final token = await _getToken();

    final response = await http.get(
      Uri.parse('$baseUrl/alunos'),
      headers: {'Authorization': 'Bearer $token'}
    );

    if(response.statusCode == 401){
      await AuthService().logout();
      if(context.mounted){
        Navigator.pushReplacementNamed(context, '/login');
      }
      throw Exception('Usuário não autorizado');
    }else if(response.statusCode == 200){
      final List data = jsonDecode(response.body);
      return data.map((e) => AlunoApiModel.fromJson(e)).toList();
    }else{
      throw Exception('Erro ao buscar alunos');
    }
  }

  Future<void> create(AlunoApiModel aluno) async{
    final _token = await _getToken();
    await http.post(
      Uri.parse('$baseUrl/alunos'),
      headers: {
        'Authorization' : 'Bearer $_token',
        'Content-Type' : 'application/json'
      },
      body: jsonEncode(aluno.toJson())
    );
  }

  Future<void> update(AlunoApiModel aluno) async{
    final _token = await _getToken();

    await http.put(
      Uri.parse('$baseUrl/alunos/${aluno.id}'),
      headers: {
        'Authorization': 'Bearer $_token',
        'Content-type' : 'application/json'
      },
    );
  }

  Future<void> delete(int id) async{
    final _token = await _getToken();

    await http.delete(
      Uri.parse('$baseUrl/alunos/$id'),
      headers: {
        'Authorization':'Bearer $_token',
      }
    );
  }
}