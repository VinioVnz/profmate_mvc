import 'package:flutter/material.dart';
import '../models/aluno_model.dart';
import '../services/Pagamento_service.dart';

class FinanceiroController with ChangeNotifier {
  final FinanceiroController _financeiroService = FinanceiroController();

  List<Aluno> _alunosPendentes = [];
  double _totalRecebido = 0.0;
  int _totalPendentes = 0;

  List<Aluno> get alunosPendentes => _alunosPendentes;
  double get totalRecebido => _totalRecebido;
  int get totalPendentes => _totalPendentes;

  // Função para carregar os alunos pendentes
  Future<void> loadAlunosPendentes() async {
    try {
      _alunosPendentes = await _financeiroService.getAlunosPendentes();
      notifyListeners();
    } catch (e) {
      throw Exception('Erro ao carregar alunos pendentes: $e');
    }
  }

  // Função para carregar o total recebido
  Future<void> loadTotalRecebido() async {
    try {
      _totalRecebido = await _financeiroService.getTotalRecebido();
      notifyListeners();
    } catch (e) {
      throw Exception('Erro ao carregar total recebido: $e');
    }
  }

  // Função para carregar o total de pendentes
  Future<void> loadTotalPendentes() async {
    try {
      _totalPendentes = await _financeiroService.getTotalPendentes();
      notifyListeners();
    } catch (e) {
      throw Exception('Erro ao carregar total de pendentes: $e');
    }
  }

  // Função para carregar todos os dados (pode ser chamada ao iniciar a página)
  Future<void> loadAllData() async {
    await Future.wait([
      loadAlunosPendentes(),
      loadTotalRecebido(),
      loadTotalPendentes(),
    ]);
  }
}

