import 'package:flutter/material.dart';
import 'package:mask_text_input_formatter/mask_text_input_formatter.dart';
import 'package:profmate/src/controller/cadastro_aluno_controller.dart';
import 'package:profmate/src/controller/pagamento_controller.dart';
import 'package:profmate/src/models/aluno_api_model.dart';
import 'package:profmate/src/models/pagamento_api_model.dart';
import 'package:profmate/src/views/progresso_view.dart';
import 'package:profmate/src/widgets/base_layout.dart';
import 'package:profmate/src/widgets/campo_formulario.dart';
import 'package:profmate/src/widgets/custom_dialog.dart';
import 'package:profmate/src/widgets/custom_dropdown_api.dart';
import 'package:profmate/src/widgets/custom_elevated_button.dart';
import 'package:profmate/theme/app_colors.dart';
import 'package:shared_preferences/shared_preferences.dart';

class VerAlunoView extends StatefulWidget {
  final AlunoApiModel? aluno;
  final PagamentoApiModel? pagamento;
  final CadastroAlunoController? controller;
  final PagamentoController? pagamentoController;
  const VerAlunoView({
    super.key,
    this.aluno,
    this.controller,
    this.pagamento,
    this.pagamentoController,
  });

  @override
  State<VerAlunoView> createState() => _VerAlunoViewState();
}

class _VerAlunoViewState extends State<VerAlunoView> {
  final _chaveDoFormulario = GlobalKey<FormState>();
  final CadastroAlunoController controller = CadastroAlunoController();
  final PagamentoController pagamentoController = PagamentoController();
  int? usuarioId;
  String? metodoSelecionado;
  List<String> metodosPagamento = [
    "Pix",
    "Cartão de Crédito",
    "Cartão de Débito",
    "Dinheiro",
    "Boleto",
  ];

  String? frequenciaSelecionado;
  List<String> frequenciasPagamento = [
    "Diariamente",
    "Semanal",
    "Mensal",
    "Trimestral",
    "Anual",
  ];
  String? campoObrigatorio(String? value) {
    if (value == null || value.isEmpty) {
      return "Campo obrigatório";
    }
    return null;
  }

  void _carregarIdUsuario() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    final id = prefs.getInt('user_id');
    if (id != null) {
      setState(() {
        usuarioId = id;
      });
    }
  }

  void _deletar() async {
    final aluno = widget.aluno;
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return CustomDialog(
          titulo: "Deletar aluno",
          mensagem: 'Tem certeza que deseja deletar ${aluno!.nome}?',
          aoCancelar: () {
            Navigator.of(context).pop();
          },

          aoConfirmar: () async {
            await controller.deletarAluno(aluno.id!);
            Navigator.pushReplacementNamed(context, '/alunos');
          },
        );
      },
    );
  }

  void _salvarAlteracoes() async {
    final alunoAtualizado = AlunoApiModel(
      id: widget.aluno!.id,
      nome: controller.nomeController.text,
      cpf: controller.cpfController.text,
      email: controller.emailController.text,
      endereco: controller.enderecoController.text,
      telefone: controller.telefoneController.text,
      nomeResponsavel: controller.nomeResponsavelController.text,
      cpfResponsavel: controller.cpfResponsavelController.text,
      dataNascimento: controller.dataNascimentoController.text,
      usuarioId: usuarioId,
    );
    print('usuario id: $usuarioId');
    final pagamentoAtualizado = PagamentoApiModel(
      valorAula:
          double.tryParse(pagamentoController.valorAulaController.text) ?? 0.0,
      vencimento: pagamentoController.vencimentoController.text,
      formaPagamento: metodoSelecionado!,
      frequenciaPagamento:
          frequenciaSelecionado!,
      idAluno: widget.aluno!.id ?? 0,
    );

    try {
      await controller.atualizarAluno(alunoAtualizado);
      await pagamentoController.atualizarPagamento(pagamentoAtualizado);
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(SnackBar(content: Text("Aluno alterado com sucesso!")));
      Navigator.pushReplacementNamed(context, '/alunos');
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("Erro ao salvar o aluno, Erro: $e")),
      );
    }
  }

  @override
  void initState() {
    super.initState();
    if (widget.aluno != null) {
      
      controller.nomeController.text = widget.aluno!.nome;
      controller.cpfController.text = widget.aluno!.cpf;
      controller.dataNascimentoController.text = widget.aluno!.dataNascimento;
      controller.enderecoController.text = widget.aluno!.endereco;
      controller.telefoneController.text = widget.aluno!.telefone;
      controller.emailController.text = widget.aluno!.email;
      controller.nomeResponsavelController.text =
          widget.aluno!.nomeResponsavel ?? '';
      controller.cpfResponsavelController.text =
          widget.aluno!.cpfResponsavel ?? '';

      if (widget.aluno!.pagamentos != null &&
          widget.aluno!.pagamentos!.isNotEmpty) {

        final pagamento = widget.aluno!.pagamentos!.first;
        pagamentoController.valorAulaController.text = pagamento.valorAula
            .toString();
        pagamentoController.vencimentoController.text = pagamento.vencimento;
        frequenciaSelecionado =
            pagamento.frequenciaPagamento;
        metodoSelecionado =
            pagamento.formaPagamento;
      }
    }
    _carregarIdUsuario();
  }

  bool edit = false;
  void _editar() {
    setState(() {
      edit = !edit;
    });
  }

  final formatarCPF = MaskTextInputFormatter(
    mask: "###.###.###-##",
    filter: {"#": RegExp(r'[0-9]')},
  );

  final formatarTelefone = MaskTextInputFormatter(
    mask: "(##) #####-####",
    filter: {"#": RegExp(r'[0-9]')},
  );

  final formatarData = MaskTextInputFormatter(
    mask: "##/##/####",
    filter: {"#": RegExp(r'[0-9]')},
  );

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BaseLayout(
        title: 'Informações do aluno',
        body: Padding(
          padding: EdgeInsets.all(16),
          child: Center(
            child: SingleChildScrollView(
              child: Form(
                key: _chaveDoFormulario,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    //Dados Pessoais:
                    SizedBox(
                      height: 56, // altura suficiente pros ícones
                      child: Stack(
                        children: [
                          Align(
                            alignment: Alignment.center,
                            child: Text(
                              "Dados pessoais",
                              style: TextStyle(
                                fontSize: 20,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                          Align(
                            alignment: Alignment.centerRight,
                            child: Row(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                IconButton(
                                  padding: EdgeInsets.zero,
                                  constraints: BoxConstraints(),
                                  icon: Icon(Icons.delete),
                                  onPressed: _deletar,
                                  color: Colors.redAccent,
                                ),
                                SizedBox(width: 12),
                                IconButton(
                                  padding: EdgeInsets.zero,
                                  constraints: BoxConstraints(),
                                  icon: Icon(Icons.edit),
                                  onPressed: _editar,
                                ),
                                SizedBox(width: 8),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),

                    SizedBox(height: 8),

                    CampoFormulario(
                      controller: controller.nomeController,
                      titulo: "Nome completo:",
                      hintText: "Ex: Maria Silva",
                      readOnly: !edit,
                      validator: campoObrigatorio,
                    ),

                    CampoFormulario(
                      formatar: [formatarCPF],
                      controller: controller.cpfController,
                      titulo: "CPF:",
                      hintText: "Ex: 000.000.000-00",
                      readOnly: !edit,
                      validator: campoObrigatorio,
                    ),

                    CampoFormulario(
                      formatar: [formatarData],
                      controller: controller.dataNascimentoController,
                      titulo: "Data de nascimento:",
                      hintText: "Ex: 00/00/0000",
                      readOnly: !edit,
                      validator: campoObrigatorio,
                    ),

                    CampoFormulario(
                      controller: controller.enderecoController,
                      titulo: "Endereço:",
                      hintText: "Ex: Rua das flores, 140",
                      readOnly: !edit,
                      validator: campoObrigatorio,
                    ),

                    CampoFormulario(
                      formatar: [formatarTelefone],
                      controller: controller.telefoneController,
                      titulo: "Telefone:",
                      hintText: "Ex: (99) 99999-9999",
                      readOnly: !edit,
                      validator: campoObrigatorio,
                    ),

                    CampoFormulario(
                      controller: controller.emailController,
                      titulo: "E-mail:",
                      hintText: "Ex: meuEmail@email.com",
                      readOnly: !edit,
                      validator: campoObrigatorio,
                    ),

                    SizedBox(height: 8),

                    //Dados do Responsável (caso menor de idade):
                    const Text(
                      "Dados do responsável",
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                      ),
                    ),

                    SizedBox(height: 8),

                    CampoFormulario(
                      controller: controller.nomeResponsavelController,
                      titulo: "Nome do responsável:",
                      hintText: "Ex: Osvaldo Silva",
                      readOnly: !edit,
                    ),

                    CampoFormulario(
                      formatar: [formatarCPF],
                      controller: controller.cpfResponsavelController,
                      titulo: "CPF do responsável:",
                      hintText: "Ex: 000.000.000-00",
                      readOnly: !edit,
                    ),

                    SizedBox(height: 8),

                    const Text(
                      "Informações de pagamento",
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                      ),
                    ),

                    SizedBox(height: 8),

                    CampoFormulario(
                      controller: pagamentoController.valorAulaController,
                      titulo: "Valor da aula:",
                      hintText: "Ex: 80,00",
                      readOnly: !edit,
                      validator: campoObrigatorio,
                    ),

                    CampoFormulario(
                      formatar: [formatarData],
                      controller: pagamentoController.vencimentoController,
                      titulo: "Primeiro vencimento:",
                      hintText: "Ex: 10/10/25",
                      readOnly: !edit,
                      validator: campoObrigatorio,
                    ),

                       CustomDropdownApi(
                    value: frequenciaSelecionado,
                    titulo: 'Freqência de pagamento:',
                    hintText: "Selecione a frequência de pagamento",
                    items: frequenciasPagamento,
                    itemLabel: (item) => item,
                    onChanged: (value) {
                      setState(() {
                        frequenciaSelecionado = value;
                      });
                    },
                    validator: campoObrigatorio,
                    readOnly: !edit,
                  ),

                  CustomDropdownApi(
                    value: metodoSelecionado,
                    titulo: 'Método de Pagamento:',
                    hintText: "Selecione o método de pagamento",
                    items: metodosPagamento,
                    itemLabel: (item) => item,
                    onChanged: (value) {
                      setState(() {
                        metodoSelecionado = value;
                      });
                    },
                    validator: campoObrigatorio,
                    readOnly: !edit,
                  ),

                    SizedBox(height: 8),

                    Container(
                      padding: EdgeInsets.all(12),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(20),
                        border: Border.all(color: Colors.black),
                      ),
                      child: Column(
                        children: [
                          Text(
                            "Progresso do aluno",
                            style: TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                            ),
                          ),

                          SizedBox(height: 8),

                          Container(
                            padding: EdgeInsets.all(10),
                            child: LinearProgressIndicator(
                              value:
                                  0.6, // substituir pelo progresso real depois
                              minHeight: 6,
                              borderRadius: BorderRadius.circular(8),
                              backgroundColor: Colors.grey[300],
                              color: AppColors.azulEscuro,
                            ),
                          ),

                          SizedBox(height: 16),

                          CustomElevatedButton(
                            tituloBotao: "Mais detalhes do progresso",
                            onPressed: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => ProgressoView(),
                                ),
                              );
                            },
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
      floatingActionButton: edit
          ? SizedBox(
              width: 200,
              height: 60,
              child: FloatingActionButton.extended(
                onPressed: _salvarAlteracoes,
                label: Text("Salvar Alterações"),
                backgroundColor: Colors.black,
                foregroundColor: Colors.white,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(32),
                ),
              ),
            )
          : null,
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
    );
  }
}