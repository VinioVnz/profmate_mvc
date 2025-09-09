import 'dart:convert';
import 'package:flutter/widgets.dart';
import 'package:profmate/src/models/ementa_api_model.dart';
import 'package:profmate/src/services/auth_service.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;

class EmentaService {
  //trocar para a url do servidor depois
  /* final String baseUrl = 'http://10.0.2.2:3000'; */
  final String baseUrl = 'https://api-profmate.onrender.com';
  Future<String?> _getToken()async{
    final prefs = await SharedPreferences.getInstance();
    return prefs.getString('jwt_token');
  }

  Future<List<EmentaApiModel>> getAll(BuildContext context)async{
    final token = await _getToken();

    final response = await http.get(
      Uri.parse('$baseUrl/ementas'),
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
      return data.map((e) => EmentaApiModel.fromJson(e)).toList();
    }else{
      throw Exception('Erro ao buscar ementa');
    }
  }

  Future<void> create(EmentaApiModel ementa) async{
    final _token = await _getToken();
    await http.post(
      Uri.parse('$baseUrl/ementas'),
      headers: {
        'Authorization' : 'Baerer $_token',
        'Content-Type' : 'application/json'
      },
      body: jsonEncode(ementa.toJson())
    );
  }

  Future<void> update(EmentaApiModel ementa) async{
    final _token = await _getToken();

   await http.put(
  Uri.parse('$baseUrl/ementas/${ementa.id}'),
  headers: {
    'Authorization': 'Bearer $_token',
    'Content-Type': 'application/json',
  },
  body: jsonEncode(ementa.toJson()),
);
  }

  Future<void> delete(int id) async{
    final _token = await _getToken();

    await http.delete(
      Uri.parse('$baseUrl/ementas/$id'),
      headers: {
        'Authorization':'Bearer $_token',
      }
    );
  }

  Future<void> getOne(int id) async{
    final _token = await _getToken();
    final response = await http.get(
      Uri.parse('$baseUrl/ementas/$id'),
      headers: {
        'Authorization': 'Bearer $_token'
      }
      );
      if(response.statusCode == 404){
        throw Exception("Ementa não encontrada.");
      }
}
}