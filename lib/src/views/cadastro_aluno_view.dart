import 'package:flutter/material.dart';
import 'package:profmate/src/controller/cadastro_aluno_controller.dart';
import 'package:profmate/src/models/cadastro_aluno_model.dart';
import 'package:profmate/src/widgets/base_layout.dart';
import 'package:profmate/src/widgets/campo_formulario.dart';

class CadastroAlunoView extends StatefulWidget {
  final CadastroAlunoController cadastroAlunoController;
  final CadastroAlunoModel? aluno;
  const CadastroAlunoView({
    required this.cadastroAlunoController,
    this.aluno,
    super.key,
  });

  @override
  State<CadastroAlunoView> createState() => _CadastroAlunoViewState();
}

class _CadastroAlunoViewState extends State<CadastroAlunoView> {
  final chaveDoFormulario = GlobalKey<FormState>();

  @override
  void initState() {
    super.initState();
    if (widget.aluno != null) {
      widget.cadastroAlunoController.carregarAluno(widget.aluno!);
    }
  }

  @override
  Widget build(BuildContext context) {
    final c = widget.cadastroAlunoController;

    return BaseLayout(
      title: 'Cadastrar Aluno',
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Center(
          child: SingleChildScrollView(
            child: Form(
              key: chaveDoFormulario,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  // Container Dados Pessoais
                  Container(
                    padding: const EdgeInsets.all(16),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      border: Border.all(
                        width: 1.0,
                        color: const Color(0xffE6E6E6),
                      ),
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        const Text(
                          "Dados pessoais",
                          style: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        const SizedBox(height: 8),

                        //campos do formulário de dados pessoais:
                        CampoFormulario(
                          controller: c.nomeController,
                          label: "Nome do Aluno",
                        ),

                        CampoFormulario(
                          controller: TextEditingController(
                            text: c.dataNascimento != null
                                ? "${c.dataNascimento!.day.toString().padLeft(2, '0')}/${c.dataNascimento!.month.toString().padLeft(2, '0')}/${c.dataNascimento!.year}"
                                : '',
                          ),
                          label: "Data de nascimento",
                          readOnly: true,
                          onTap: () async {
                            FocusScope.of(context).requestFocus(FocusNode());
                            final dataSelecionada = await showDatePicker(
                              context: context,
                              initialDate: DateTime(2005),
                              firstDate: DateTime(1900),
                              lastDate: DateTime.now(),
                            );

                            if (dataSelecionada != null) {
                              setState(() {
                                c.dataNascimento = dataSelecionada;
                              });
                            }
                          },
                        ),

                        CampoFormulario(
                          controller: c.cpfController,
                          label: "CPF",
                        ),

                        CampoFormulario(
                          controller: c.enderecoController,
                          label: "Endereço",
                        ),

                        CampoFormulario(
                          controller: c.telefoneController,
                          label: "Telefone",
                        ),

                        CampoFormulario(
                          controller: c.emailController,
                          label: "E-mail",
                        ),
                      ],
                    ),
                  ),

                  const SizedBox(height: 16),

                  //container dos dados do responsável (se menor de idade)
                  Container(
                    padding: const EdgeInsets.all(16),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      border: Border.all(
                        width: 1.0,
                        color: const Color(0xffE6E6E6),
                      ),
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        Text(
                          "Dados do Responsável",
                          style: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        Text(
                          "(caso o aluno for menor de idade)",
                          style: TextStyle(
                            fontSize: 12,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        const SizedBox(height: 8),
                        CampoFormulario(
                          controller: c.nomeResponsavelController,
                          label: "Nome do responsável",
                        ),

                        CampoFormulario(
                          controller: c.cpfResponsavelController,
                          label: "CPF do responsável",
                        ),
                      ],
                    ),
                  ),

                  const SizedBox(height: 16),

                  // Container Informações de Pagamento
                  Container(
                    padding: const EdgeInsets.all(16),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      border: Border.all(
                        width: 1.0,
                        color: const Color(0xffE6E6E6),
                      ),
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        const Text(
                          "Informações de pagamento",
                          style: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        const SizedBox(height: 8),

                        //campos de informações de pagamento
                        CampoFormulario(
                          controller: c.valorAulaController,
                          label: "Valor da aula/mensalidade",
                        ),

                        CampoFormulario(
                          controller: TextEditingController(
                            text: c.vencimento != null
                                ? "${c.vencimento!.day.toString().padLeft(2, '0')}/${c.vencimento!.month.toString().padLeft(2, '0')}/${c.vencimento!.year}"
                                : '',
                          ),
                          label: "Data de vencimento",
                          readOnly: true,
                          onTap: () async {
                            FocusScope.of(context).requestFocus(FocusNode());
                            final dataEscolhida = await showDatePicker(
                              context: context,
                              initialDate: DateTime.now(),
                              firstDate: DateTime(2025),
                              lastDate: DateTime(2100),
                            );

                            if (dataEscolhida != null) {
                              setState(() {
                                c.vencimento = dataEscolhida;
                              });
                            }
                          },
                        ),

                        Container(
                          padding: EdgeInsets.symmetric(
                            horizontal: 12,
                            vertical: 4,
                          ),
                          margin: EdgeInsets.only(bottom: 12),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10),
                            border: Border.all(color: Color(0xffE6E6E6)),
                            color: Colors.white,
                          ),
                          child: DropdownButton(
                            value: c.frequenciaPagamento,
                            isExpanded: true,
                            underline: SizedBox.shrink(),
                            hint: Text("Frequência de pagamento"),
                            items: ['Mensal', 'Semanal', 'Por aula'].map((
                              String valor,
                            ) {
                              return DropdownMenuItem(
                                value: valor,
                                child: Text(valor),
                              );
                            }).toList(),
                            onChanged: (valor) {
                              setState(() {
                                c.frequenciaPagamento = valor;
                              });
                            },
                          ),
                        ),

                        Container(
                          padding: EdgeInsets.symmetric(
                            horizontal: 12,
                            vertical: 4,
                          ),
                          margin: EdgeInsets.only(bottom: 12),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10),
                            border: Border.all(color: Color(0xffE6E6E6)),
                            color: Colors.white,
                          ),
                          child: DropdownButton(
                            value: c.formaPagamento,
                            isExpanded: true,
                            underline: SizedBox.shrink(),
                            hint: Text("Forma de pagamento"),
                            items:
                                [
                                  'Pix',
                                  'Cartão de débito',
                                  'Cartão de crédito',
                                  'Boleto',
                                ].map((String valor) {
                                  return DropdownMenuItem(
                                    value: valor,
                                    child: Text(valor),
                                  );
                                }).toList(),
                            onChanged: (valor) {
                              setState(() {
                                c.formaPagamento = valor;
                              });
                            },
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 16),

                  ElevatedButton(
                    onPressed: () {
                      c.salvarAluno(context);
                    },
                    style: ElevatedButton.styleFrom(
                      padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
                      backgroundColor: Colors.black,
                      foregroundColor: Colors.white,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10)
                      )
                      ),
                    child: Text("Salvar",
                    style: TextStyle(
                      fontSize: 18,
                    )),
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
