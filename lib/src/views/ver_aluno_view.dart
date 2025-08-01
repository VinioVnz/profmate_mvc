import 'package:flutter/material.dart';
import 'package:profmate/src/controller/alunos_controller.dart';
import 'package:profmate/src/controller/cadastro_aluno_controller.dart';
import 'package:profmate/src/controller/pagamento_controller.dart';
import 'package:profmate/src/models/aluno_api_model.dart';
import 'package:profmate/src/models/pagamento_api_model.dart';
import 'package:profmate/src/views/alunos_view.dart';
import 'package:profmate/src/widgets/base_layout.dart';
import 'package:profmate/src/widgets/campo_formulario.dart';
import 'package:profmate/src/widgets/custom_elevated_button.dart';

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

  void _salvarAlteracoes() {}
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
        pagamentoController.frequenciaPagamentoController.text =
            pagamento.frequenciaPagamento;
        pagamentoController.formaPagamentoController.text =
            pagamento.formaPagamento;
      }
    }
  }

  bool edit = false;
  void _editar() {
    setState(() {
      edit = !edit;
    });
  }

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
                    IconButton(icon: Icon(Icons.edit), onPressed: _editar),
                    //Dados Pessoais:
                    const Text(
                      "Dados pessoais",
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                      ),
                    ),

                    SizedBox(height: 8),

                    CampoFormulario(
                      controller: controller.nomeController,
                      titulo: "Nome completo:",
                      hintText: "Ex: Maria Silva",
                      readOnly: !edit,
                    ),

                    CampoFormulario(
                      controller: controller.cpfController,
                      titulo: "CPF:",
                      hintText: "Ex: 000.000.000-00",
                      readOnly: !edit,
                    ),

                    CampoFormulario(
                      controller: controller.dataNascimentoController,
                      titulo: "Data de nascimento:",
                      hintText: "Ex: 00/00/0000",
                      readOnly: !edit,
                    ),

                    CampoFormulario(
                      controller: controller.enderecoController,
                      titulo: "Endereço:",
                      hintText: "Ex: Rua das flores, 140",
                      readOnly: !edit,
                    ),

                    CampoFormulario(
                      controller: controller.telefoneController,
                      titulo: "Telefone:",
                      hintText: "Ex: (99) 99999-9999",
                      readOnly: !edit,
                    ),

                    CampoFormulario(
                      controller: controller.emailController,
                      titulo: "E-mail:",
                      hintText: "Ex: meuEmail@email.com",
                      readOnly: !edit,
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
                    ),

                    CampoFormulario(
                      controller: pagamentoController.vencimentoController,
                      titulo: "Primeiro vencimento:",
                      hintText: "Ex: 10/10/25",
                      readOnly: !edit,
                    ),

                    CampoFormulario(
                      controller:
                          pagamentoController.frequenciaPagamentoController,
                      titulo: "Frequência de pagamento:",
                      hintText: "Mensal, semanal...",
                      readOnly: !edit,
                    ),

                    CampoFormulario(
                      controller: pagamentoController.formaPagamentoController,
                      titulo: "Forma de pagamento:",
                      hintText: "Pix, cartão de crédito...",
                      readOnly: !edit,
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
