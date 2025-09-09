import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:profmate/src/models/financeiro_model.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';

class FinanceiroService {
  //final String baseUrl = dotenv.env['API_URL'] ?? 'http://127.0.0.1:8000'; //só define a URL base da api em localhost 
  final String baseUrl = 'https://api-profmate.onrender.com';
  Future<List<FinanceiroModel>> getAll(BuildContext context) async {
    final response = await http.get(Uri.parse(baseUrl));
    if (response.statusCode == 200) {
      final List<dynamic> data = json.decode(response.body);
      return data.map((e) => FinanceiroModel.fromJson(e)).toList();
    } else {
      throw Exception('Erro ao buscar pagamentos');
    }
  }

  Future<void> create(FinanceiroModel pagamento) async {
    final response = await http.post(
      Uri.parse(baseUrl),
      headers: {'Content-Type': 'application/json'},
      body: json.encode(pagamento.toJson()),
    );
    if (response.statusCode != 201 && response.statusCode != 200) {
      throw Exception('Erro ao criar pagamento');
    }
  }

  Future<void> update(FinanceiroModel pagamento) async {
    if (pagamento.id == null) throw Exception('ID não pode ser nulo');
    final response = await http.put(
      Uri.parse(baseUrl + pagamento.id.toString()),
      headers: {'Content-Type': 'application/json'},
      body: json.encode(pagamento.toJson()),
    );
    if (response.statusCode != 200) {
      throw Exception('Erro ao atualizar pagamento');
    }
  }

  Future<void> delete(int id) async {
    final response = await http.delete(Uri.parse(baseUrl + id.toString()));
    if (response.statusCode != 200 && response.statusCode != 204) {
      throw Exception('Erro ao deletar pagamento');
    }
  }

  Future<FinanceiroModel> getOne(int id) async {
    final response = await http.get(Uri.parse(baseUrl + id.toString()));
    if (response.statusCode == 200) {
      return FinanceiroModel.fromJson(json.decode(response.body));
    } else {
      throw Exception('Erro ao buscar pagamento');
    }
  }
}