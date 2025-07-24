import 'package:flutter/material.dart';
import 'package:mask_text_input_formatter/mask_text_input_formatter.dart';
import 'package:profmate/src/models/cadastro_aluno_model.dart';

class CadastroAlunoController {
  //variáveis e máscaras de formatação:
  final nomeController = TextEditingController();
  final cpfController = TextEditingController();
  final emailController = TextEditingController();
  final enderecoController = TextEditingController();
  final telefoneController = TextEditingController();
  final valorAulaController = TextEditingController();
  final nomeResponsavelController = TextEditingController();
  final cpfResponsavelController = TextEditingController();

  DateTime? dataNascimento;
  DateTime? vencimento;
  String? frequenciaPagamento;
  String? formaPagamento;

  final formatarCpf = MaskTextInputFormatter(
    mask: '###.###.###-##',
    filter: {"#": RegExp(r'[0-9]')},
  );

  final formatarCpfResponsavel = MaskTextInputFormatter(
    mask: '###.###.###-##',
    filter: {"#": RegExp(r'[0-9]')},
  );

  final formatarTelefone = MaskTextInputFormatter(
    mask: '(##) #####-####',
    filter: {"#": RegExp(r'[0-9]')},
  );

  double get valorAula {
    String texto = valorAulaController.text.replaceAll(RegExp(r'[^\d,]'), '');
    texto = texto.replaceAll(',', '.');
    return double.tryParse(texto) ?? 0.0;
  }

  //dispose e clear
  void dispose() {
    nomeController.dispose();
    cpfController.dispose();
    emailController.dispose();
    enderecoController.dispose();
    telefoneController.dispose();
    valorAulaController.dispose();
    nomeResponsavelController.dispose();
    cpfResponsavelController.dispose();
  }

  void clear() {
    nomeController.clear();
    cpfController.clear();
    emailController.clear();
    enderecoController.clear();
    telefoneController.clear();
    valorAulaController.clear();
    nomeResponsavelController.clear();
    cpfResponsavelController.clear();

    dataNascimento = null;
    vencimento = null;
    frequenciaPagamento = null;
    formaPagamento = null;
  }

  //métodos e CRUD (posteriormente)
  final List<CadastroAlunoModel> listaAlunos = [];

  void salvarAluno(BuildContext context) {
    if (!validarFormulario(context)) return;

    final aluno = criarObjetoAluno();
    adicionarAluno(aluno); 

    debugPrint('Aluno salvo: ${aluno.nome}');

    Navigator.pop(context, aluno);
    clear();
  }

  //método para criar um aluno a partir dos dados
  CadastroAlunoModel criarObjetoAluno() {
    return CadastroAlunoModel(
      nome: nomeController.text.trim(),
      cpf: cpfController.text.replaceAll(RegExp(r'\D'), ''),
      email: emailController.text.trim(),
      endereco: enderecoController.text.trim(),
      telefone: telefoneController.text.replaceAll(RegExp(r'\D'), ''),
      dataNascimento: dataNascimento!,
      valorAula: valorAula,
      vencimento: vencimento!,
      formaPagamento: formaPagamento!,
      frequenciaPagamento: frequenciaPagamento ?? '',
      nomeResponsavel: nomeResponsavelController.text.trim(),
      cpfResponsavel: cpfResponsavelController.text.replaceAll(
        RegExp(r'\D'),
        '',
      ),
    );
  }

  void adicionarAluno(CadastroAlunoModel aluno) {
    listaAlunos.add(aluno);
  }

  void editarAluno(int index, CadastroAlunoModel alunoEditado) {
    listaAlunos[index] = alunoEditado;
  }

  void deletarAluno(int index) {
    listaAlunos.removeAt(index);
  }

  //método para carregar os dados do aluno ao selecionar
  void carregarAluno(CadastroAlunoModel aluno) {
    nomeController.text = aluno.nome;
    cpfController.text = formatarCpf.maskText(aluno.cpf);
    emailController.text = aluno.email;
    enderecoController.text = aluno.endereco;
    telefoneController.text = formatarTelefone.maskText(aluno.telefone);
    valorAulaController.text = aluno.valorAula
        .toStringAsFixed(2)
        .replaceAll('.', ',');
    nomeResponsavelController.text = aluno.nomeResponsavel ?? '';
    cpfResponsavelController.text = formatarCpfResponsavel.maskText(
      aluno.cpfResponsavel ?? '',
    );
    dataNascimento = aluno.dataNascimento;
    vencimento = aluno.vencimento;
    frequenciaPagamento = aluno.frequenciaPagamento;
    formaPagamento = aluno.formaPagamento;
  }

  //validações do formulário
  bool validarFormulario(BuildContext context) {
    bool mostrarErro(String mensagem) {
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(SnackBar(content: Text(mensagem)));
      return false;
    }

    if (nomeController.text.trim().isEmpty) {
      return mostrarErro("Informe o nome do aluno.");
    }

    if (cpfController.text.trim().length != 14) {
      return mostrarErro("Informe um CPF válido (com 11 números).");
    }

    if (emailController.text.trim().isEmpty ||
        !emailController.text.contains('@')) {
      return mostrarErro("Informe um e-mail válido.");
    }

    if (enderecoController.text.trim().isEmpty) {
      return mostrarErro("Informe o endereço.");
    }

    if (telefoneController.text.trim().length < 14) {
      return mostrarErro("Informe um telefone válido.");
    }

    if (valorAula <= 0) {
      return mostrarErro("Informe um valor válido para a aula.");
    }

    if (formaPagamento == null || formaPagamento!.isEmpty) {
      return mostrarErro("Selecione a forma de pagamento.");
    }

    if (frequenciaPagamento == null || frequenciaPagamento!.isEmpty) {
      return mostrarErro("Selecione a frequência de pagamento.");
    }

    if (dataNascimento == null) {
      return mostrarErro("Selecione a data de nascimento.");
    }

    if (vencimento == null) {
      return mostrarErro("Selecione o dia de vencimento.");
    }

    final hoje = DateTime.now();
    final idade =
        hoje.year -
        dataNascimento!.year -
        ((hoje.month < dataNascimento!.month ||
                (hoje.month == dataNascimento!.month &&
                    hoje.day < dataNascimento!.day))
            ? 1
            : 0);

    if (idade < 18) {
      if (nomeResponsavelController.text.trim().isEmpty) {
        return mostrarErro("Informe o nome do responsável.");
      }

      if (cpfResponsavelController.text.trim().length != 14) {
        return mostrarErro("Informe um CPF válido do responsável.");
      }
    }

    return true;
  }
}
