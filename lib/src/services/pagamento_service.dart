import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:profmate/src/models/pagamento_model.dart'; // Importa o modelo de pagamento

class PagamentoService {
  // URL base da sua API
  final String apiUrl = "https://10.0.2.2:3000"; // Coloque a URL da sua API

  // Função para pegar os alunos pendentes
  Future<List<PagamentoModel>> getAlunosPendentes() async {
    final response = await http.get(Uri.parse('$apiUrl/alunos/pendentes'));

    if (response.statusCode == 200) {
      // A resposta da API é um JSON que será mapeado para uma lista de Pagamentos
      List<dynamic> data = json.decode(response.body);
      return data.map((e) => PagamentoModel.fromMap(e)).toList();
    } else {
      throw Exception('Erro ao carregar alunos pendentes');
    }
  }

  // Função para pegar o total recebido
  Future<double> getTotalRecebido() async {
    final response = await http.get(Uri.parse('$apiUrl/total/recebido'));

    if (response.statusCode == 200) {
      var data = json.decode(response.body);
      return data['total_recebido'] ?? 0.0;
    } else {
      throw Exception('Erro ao carregar total recebido');
    }
  }

  // Função para pegar o total de pendentes
  Future<int> getTotalPendentes() async {
    final response = await http.get(Uri.parse('$apiUrl/total/pendentes'));

    if (response.statusCode == 200) {
      var data = json.decode(response.body);
      return data['total_pendentes'] ?? 0;
    } else {
      throw Exception('Erro ao carregar total de pendentes');
    }
  }
}
