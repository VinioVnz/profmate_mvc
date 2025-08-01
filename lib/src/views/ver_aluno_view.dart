import 'package:flutter/material.dart';
import 'package:profmate/src/controller/alunos_controller.dart';
import 'package:profmate/src/controller/cadastro_aluno_controller.dart';
import 'package:profmate/src/controller/pagamento_controller.dart';
import 'package:profmate/src/models/aluno_api_model.dart';
import 'package:profmate/src/models/pagamento_api_model.dart';
import 'package:profmate/src/views/alunos_view.dart';
import 'package:profmate/src/widgets/base_layout.dart';
import 'package:profmate/src/widgets/campo_formulario.dart';

class VerAlunoView extends StatefulWidget {
  final AlunoApiModel? aluno;
  final PagamentoApiModel? pagamento;
  final CadastroAlunoController? controller;
  final PagamentoController? pagamentoController;
  const VerAlunoView({
    super.key,
    this.aluno,
    this.controller,
    this.pagamento, this.pagamentoController,
  });

  @override
  State<VerAlunoView> createState() => _VerAlunoViewState();
}

class _VerAlunoViewState extends State<VerAlunoView> {
  final _chaveDoFormulario = GlobalKey<FormState>();
  final CadastroAlunoController controller = CadastroAlunoController();
  final PagamentoController pagamentoController = PagamentoController();

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
    }
    if (widget.pagamento != null) {
      pagamentoController.valorAulaController.text = widget.pagamento!.valorAula
          .toString();
      pagamentoController.vencimentoController.text =
          widget.pagamento!.vencimento;
      pagamentoController.frequenciaPagamentoController.text =
          widget.pagamento!.frequenciaPagamento;
      pagamentoController.formaPagamentoController.text =
          widget.pagamento!.formaPagamento;
    }
  }

  @override
  Widget build(BuildContext context) {
    return BaseLayout(
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
                  const Text(
                    "Dados pessoais",
                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                  ),

                  SizedBox(height: 8),

                  CampoFormulario(
                    controller: controller.nomeController,
                    titulo: "Nome completo:",
                    hintText: "Ex: Maria Silva",
                  ),

                  CampoFormulario(
                    controller: controller.cpfController,
                    titulo: "CPF:",
                    hintText: "Ex: 000.000.000-00",
                  ),

                  CampoFormulario(
                    controller: controller.dataNascimentoController,
                    titulo: "Data de nascimento:",
                    hintText: "Ex: 00/00/0000",
                  ),

                  CampoFormulario(
                    controller: controller.enderecoController,
                    titulo: "Endereço:",
                    hintText: "Ex: Rua das flores, 140",
                  ),

                  CampoFormulario(
                    controller: controller.telefoneController,
                    titulo: "Telefone:",
                    hintText: "Ex: (99) 99999-9999",
                  ),

                  CampoFormulario(
                    controller: controller.emailController,
                    titulo: "E-mail:",
                    hintText: "Ex: meuEmail@email.com",
                  ),

                  SizedBox(height: 8),

                  //Dados do Responsável (caso menor de idade):
                  const Text(
                    "Dados do responsável",
                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                  ),

                  SizedBox(height: 8),

                  CampoFormulario(
                    controller: controller.nomeResponsavelController,
                    titulo: "Nome do responsável:",
                    hintText: "Ex: Osvaldo Silva",
                  ),

                  CampoFormulario(
                    controller: controller.cpfResponsavelController,
                    titulo: "CPF do responsável:",
                    hintText: "Ex: 000.000.000-00",
                  ),

                  SizedBox(height: 8),

                  const Text(
                    "Informações de pagamento",
                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                  ),

                  SizedBox(height: 8),

                  CampoFormulario(
                    controller: pagamentoController.valorAulaController,
                    titulo: "Valor da aula:",
                    hintText: "Ex: 80,00",
                  ),

                  CampoFormulario(
                    controller: pagamentoController.vencimentoController,
                    titulo: "Primeiro vencimento:",
                    hintText: "Ex: 10/10/25",
                  ),

                  CampoFormulario(
                    controller:
                        pagamentoController.frequenciaPagamentoController,
                    titulo: "Frequência de pagamento:",
                    hintText: "Mensal, semanal...",
                  ),

                  CampoFormulario(
                    controller: pagamentoController.formaPagamentoController,
                    titulo: "Forma de pagamento:",
                    hintText: "Pix, cartão de crédito...",
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
