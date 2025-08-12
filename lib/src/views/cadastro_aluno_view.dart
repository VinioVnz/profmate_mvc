import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:mask_text_input_formatter/mask_text_input_formatter.dart';
import 'package:profmate/src/controller/cadastro_aluno_controller.dart';
import 'package:profmate/src/controller/pagamento_controller.dart';
import 'package:profmate/src/models/aluno_api_model.dart';
import 'package:profmate/src/models/pagamento_api_model.dart';
import 'package:profmate/src/widgets/base_layout.dart';
import 'package:profmate/src/widgets/campo_formulario.dart';
import 'package:profmate/src/widgets/custom_elevated_button.dart';
import 'package:flutter_multi_formatter/flutter_multi_formatter.dart';

class CadastroAlunoView extends StatefulWidget {
  const CadastroAlunoView({super.key});

  @override
  State<CadastroAlunoView> createState() => _CadastroAlunoViewState();
}

class _CadastroAlunoViewState extends State<CadastroAlunoView> {
  final _chaveDoFormulario = GlobalKey<FormState>();
  final CadastroAlunoController controller = CadastroAlunoController();
  final PagamentoController pagamentoController = PagamentoController();
  final formatarValor = CurrencyInputFormatter(leadingSymbol: 'R\$ ',
  useSymbolPadding: true,);

  Future<AlunoApiModel?> _salvarAluno() async {
    final aluno = AlunoApiModel(
      nome: controller.nomeController.text,
      cpf: controller.cpfController.text,
      email: controller.emailController.text,
      endereco: controller.enderecoController.text,
      telefone: controller.telefoneController.text,
      nomeResponsavel: controller.nomeResponsavelController.text,
      cpfResponsavel: controller.cpfResponsavelController.text,
      dataNascimento: controller.dataNascimentoController.text,
    );

    try {
      final alunoCriado = await controller.criarAluno(aluno);
      return alunoCriado;
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("Erro ao salvar o aluno, Erro: $e")),
      );
      return null;
    }
  }

  Future<void> _salvarPagamento(int alunoId) async {
    final pagamento = PagamentoApiModel(
      valorAula:
          double.tryParse(pagamentoController.valorAulaController.text) ?? 0.0,
      vencimento: pagamentoController.vencimentoController.text,
      formaPagamento: pagamentoController.formaPagamentoController.text,
      frequenciaPagamento:
          pagamentoController.frequenciaPagamentoController.text,
      idAluno: alunoId,
    );
    try {
      await pagamentoController.criarPagamento(pagamento);
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("Erro ao criar pagamento, Erro: $e")),
      );
    }
  }

  final formatarCPF = MaskTextInputFormatter(
    mask: "###.###.###-##",
    filter: {"#" : RegExp(r'[0-9]')}
  );

  final formatarTelefone = MaskTextInputFormatter(
    mask: "(##) #####-####",
    filter: {"#" : RegExp(r'[0-9]')}
  );

  final formatarData = MaskTextInputFormatter(
    mask: "##/##/####",
    filter: {"#" : RegExp(r'[0-9]')}
  );

  

  

  @override
  Widget build(BuildContext context) {
    return BaseLayout(
      title: "Cadastrar aluno",
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
                  formatar: [formatarCPF],
                  controller: controller.cpfController,
                  titulo: "CPF:",
                  hintText: "Ex: 000.000.000-00"),
                 
               
                  CampoFormulario(
                  formatar: [formatarData],
                  controller: controller.dataNascimentoController,
                  titulo: "Data de nascimento:",
                  hintText: "Ex: 00/00/0000"),

                  CampoFormulario(
                  formatar: [formatarTelefone],
                  controller: controller.telefoneController,
                  titulo: "Telefone:",
                  hintText: "Ex: (99) 99999-9999"),
                  
                  CampoFormulario(
                    controller: controller.emailController,
                    titulo: "E-mail:",
                    hintText: "Ex: meuEmail@email.com",
                  ),

                  SizedBox(height: 8),

                  //Dados do Responsável (caso menor de idade):
                  const Text("Dados do responsável", style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),),

                  SizedBox(height: 8),
                  
                  CampoFormulario(
                  controller: controller.nomeResponsavelController,                  
                  titulo: "Nome do responsável:",
                  hintText: "Ex: Osvaldo Silva"),

                  CampoFormulario(
                  formatar: [formatarCPF],
                  controller: controller.cpfResponsavelController,                  
                  titulo: "CPF do responsável:",
                  hintText: "Ex: 000.000.000-00"),

                  SizedBox(height: 8),

                  const Text("Informações de pagamento", style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),),

                  SizedBox(height: 8),

                  CampoFormulario(
                    controller: pagamentoController.valorAulaController,
                    formatar: [formatarValor],
                    titulo: "Valor da aula:",
                    hintText: "Ex: 80,00",
                  ),

                  CampoFormulario(
                    formatar: [formatarData],
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

                  SizedBox(height: 8),

                  CustomElevatedButton(
                    tituloBotao: "Salvar",
                    onPressed: () async {
                      final alunoCriado = await _salvarAluno();
                      if (alunoCriado != null && alunoCriado.id != null) {
                        await _salvarPagamento(alunoCriado.id!);
                        Navigator.pop(context, true);
                      }
                      
                    },
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
