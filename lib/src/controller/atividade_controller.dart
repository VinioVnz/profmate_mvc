import 'package:flutter/material.dart';
import 'package:profmate/src/models/atividade_api_model.dart';
import 'package:profmate/src/models/atividade_model.dart';
//import 'package:profmate/src/services/adicionar_atividade_service.dart';

class AtividadeController {
  // Controllers dos campos de formulário
  final tituloController = TextEditingController();
  final descricaoController = TextEditingController();
  final turmaOuAlunosController = TextEditingController();
  final dtEntregaController = TextEditingController();
  final valeNotaController = TextEditingController();
  final arquivoController = TextEditingController();

  // ValueNotifiers para gerenciar estado
  final ValueNotifier<List<AtividadeModel>> atividades =
      ValueNotifier<List<AtividadeModel>>([]);

  final ValueNotifier<bool> isLoading = ValueNotifier<bool>(false);
  final ValueNotifier<String?> errorMessage = ValueNotifier<String?>(null);

  // Método para listar atividades
  Future<void> listarAtividades(BuildContext context) async {
    isLoading.value = true;
    errorMessage.value = null;

    try {
      // Simula uma chamada de API
      await Future.delayed(const Duration(seconds: 2));

      // Aqui você faria a chamada real para a API
      // final response = await AdicionarAtividadeService().buscarAtividades();

      // Simulação de dados vindos da API
      final List<AtividadeModel> atividadesCarregadas = atividades.value;

      atividades.value = atividadesCarregadas;
    } catch (e) {
      errorMessage.value = 'Erro ao carregar atividades: ${e.toString()}';
      atividades.value = [];
    } finally {
      isLoading.value = false;
    }
  }

  Future<void> adicionarAtividade() async {
    await criarAtividade(
      tituloController.text,
      descricaoController.text,
      turmaOuAlunosController.text,
      dtEntregaController.text,
      valeNotaController.text,
      arquivoController.text.isEmpty ? null : arquivoController.text,
    );
  }

  Future<AtividadeModel?> criarAtividade(
    String titulo,
    String descricao,
    String turmaOuAlunos,
    String dtEntrega,
    String valeNota,
    String? arquivo,
  ) async {
    if (titulo.trim().isEmpty) {
      errorMessage.value = 'Título é obrigatório';
      return null;
    }

    try {
      isLoading.value = true;
      errorMessage.value = null;

      final novaAtividade = AtividadeModel(
        titulo: titulo.trim(),
        descricao: descricao.trim(),
        turmaOuAlunos: turmaOuAlunos.trim(),
        dtEntrega: dtEntrega.trim(),
        valeNota: valeNota.trim() == 'sim',
        arquivo: arquivo?.trim() == 'sim',
      );

      atividades.value = List<AtividadeModel>.from(atividades.value)
        ..add(novaAtividade);

      clear();
      return novaAtividade;
    } catch (e) {
      errorMessage.value = 'Erro ao criar atividade: ${e.toString()}';
      return null;
    } finally {
      isLoading.value = false;
    }
  }

  void clear() {
    tituloController.clear();
    descricaoController.clear();
    turmaOuAlunosController.clear();
    dtEntregaController.clear();
    valeNotaController.clear();
    arquivoController.clear();
  }

  void dispose() {
    tituloController.dispose();
    descricaoController.dispose();
    turmaOuAlunosController.dispose();
    dtEntregaController.dispose();
    valeNotaController.dispose();
    arquivoController.dispose();
    atividades.dispose();
    isLoading.dispose();
    errorMessage.dispose();
  }
}
