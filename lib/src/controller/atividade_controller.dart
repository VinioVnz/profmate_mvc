import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../models/atividade_model.dart';

class AtividadeController {
  final tituloController = TextEditingController();
  final descricaoController = TextEditingController();
  final turmaOuAlunosController = TextEditingController();
  final dtEntregaController = TextEditingController();
  final valeNotaController = TextEditingController();
  final arquivoController = TextEditingController();

  static final ValueNotifier<List<AtividadeModel>> atividades = ValueNotifier(
    [],
  );

  Future<void> criarAtividade(
    String titulo,
    String descricao,
    String turmaOuAlunos,
    String dtEntrega,
    String valeNota,
    String? arquivo,
  ) async {
    final prefs = await SharedPreferences.getInstance();

    final novaAtividade = AtividadeModel(
      titulo: titulo,
      descricao: descricao,
      turmaOuAlunos: turmaOuAlunos,
      dtEntrega: dtEntrega,
      valeNota: valeNota.trim().toLowerCase() == "sim",
      arquivo: arquivo,
    );

    // Recupera lista existente
    final String? encodedData = prefs.getString('listaAtividades');
    List<AtividadeModel> lista = [];
    if (encodedData != null) {
      final List<dynamic> decodedData = jsonDecode(encodedData);
      lista = decodedData.map((e) => AtividadeModel.fromJson(e)).toList();
    }

    // Adiciona nova
    lista.add(novaAtividade);

    // Atualiza ValueNotifier
    atividades.value = List.from(lista);

    // Salva no SharedPreferences
    final String encoded = jsonEncode(lista.map((e) => e.toJson()).toList());
    await prefs.setString('listaAtividades', encoded);
  }

  Future<void> listarAtividades() async {
    final prefs = await SharedPreferences.getInstance();
    final String? encodedData = prefs.getString('listaAtividades');

    if (encodedData != null) {
      final List<dynamic> decodedData = jsonDecode(encodedData);
      atividades.value = decodedData
          .map((e) => AtividadeModel.fromJson(e))
          .toList();
      print("Qtd atividades carregadas: ${atividades.value.length}");
    } else {
      atividades.value = [];
      print("Qtd atividades carregadas: ${atividades.value.length}");
    }
  }

  void dispose() {
    tituloController.dispose();
    descricaoController.dispose();
    turmaOuAlunosController.dispose();
    dtEntregaController.dispose();
    valeNotaController.dispose();
    arquivoController.dispose();
  }
}
