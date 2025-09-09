import 'dart:convert';

import 'package:flutter/widgets.dart';
import 'package:profmate/src/models/aula_api_model.dart';
import 'package:profmate/src/services/auth_service.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;
class AulaService {
  final String baseUrl = 'http://10.0.2.2:3000';
   //final String baseUrl = 'https://api-profmate.onrender.com';
  Future<String?> _getToken()async{
    final prefs = await SharedPreferences.getInstance();
    return prefs.getString('jwt_token');
  }

  Future<List<AulaApiModel>> getAll(BuildContext context)async{
    final token = await _getToken();

    final response = await http.get(
      Uri.parse('$baseUrl/aulas'),
      headers: {'Authorization' : 'Bearer $token'}
    );

    if(response.statusCode == 401){
      await AuthService().logout();
      if(context.mounted){
        Navigator.pushReplacementNamed(context, '/login');
      }throw Exception('Usuário não autorizado');
    } else if(response.statusCode == 200){
      final List data = jsonDecode(response.body);
      return data.map((e) => AulaApiModel.fromJson(e)).toList();
    } else {
      throw Exception('Erro ao buscar aula');
    }
  }

  Future<void> create(AulaApiModel aula) async{
    final _token = await _getToken();

    await http.post(
      Uri.parse('$baseUrl/aulas'),
      headers: {
        'Authorization' : 'Bearer $_token',
        'Content-Type' : 'application/json'
      },
      body: jsonEncode(aula.toJson())
    );
  }

  Future<void> update(AulaApiModel aula) async{
    final _token = await _getToken();

    await http.put(
      Uri.parse('$baseUrl/aulas/${aula.id}'),
      headers: {
        'Authorization' : 'Bearer $_token',
        'Content-Type' : 'application/json'
      },
      body: jsonEncode(aula.toJson())
    );
  }

  Future<void> delete(int id) async{
    final _token = await _getToken();

    await http.delete(
      Uri.parse('$baseUrl/aulas/${id}'),
      headers: {
        'Authorization' : 'Bearer $_token',
      }
    );
  }

  Future<void> getOne(int id) async{
    final _token = await _getToken();

    final response = await http.get(
      Uri.parse('$baseUrl/aulas/$id'),
      headers: {
        'Authorization': 'Bearer $_token'
      }
    );
    if(response.statusCode == 404){
      throw Exception('Aula não encontrada');
    }
  }
}