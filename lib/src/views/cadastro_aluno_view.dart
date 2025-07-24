import 'package:flutter/material.dart';
import 'package:profmate/src/controller/cadastro_aluno_controller.dart';
import 'package:profmate/src/models/cadastro_aluno_model.dart';
import 'package:profmate/src/widgets/base_layout.dart';
import 'package:profmate/src/widgets/campo_formulario.dart';

class CadastroAlunoView extends StatefulWidget {
  final CadastroAlunoController cadastroAlunoController;
  final CadastroAlunoModel? aluno;
  final bool modoEdicao;
  const CadastroAlunoView({
    required this.cadastroAlunoController,
    this.aluno,
    this.modoEdicao = false,
    super.key,
  });

  @override
  State<CadastroAlunoView> createState() => _CadastroAlunoViewState();
}

class _CadastroAlunoViewState extends State<CadastroAlunoView> {
  final chaveDoFormulario = GlobalKey<FormState>();
  late bool modoEdicao;

  @override
  void initState() {
    super.initState();
    if (widget.aluno != null) {
      widget.cadastroAlunoController.carregarAluno(widget.aluno!);
      modoEdicao = false;
    } else {
      modoEdicao = true;
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
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          const Text(
                            "Dados pessoais",
                            style: TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          if (widget.aluno != null)
                            IconButton(
                              icon: Icon(modoEdicao ? Icons.check : Icons.edit),
                              onPressed: () {
                                setState(() {
                                  if (modoEdicao) {
                                    if (chaveDoFormulario.currentState!
                                        .validate()) {
                                      c.salvarAluno(context);
                                      modoEdicao = false;
                                    }
                                  } else {
                                    modoEdicao = true;
                                  }
                                });
                              },
                            ),
                        ],
                      ),
                      const SizedBox(height: 8),

                      //campos do formulário de dados pessoais:
                      CampoFormulario(
                        controller: c.nomeController,
                        titulo: "Nome do aluno:",
                        label: "Maria Silva",
                        readOnly: !modoEdicao,
                      ),

                      CampoFormulario(
                        controller: TextEditingController(
                          text: c.dataNascimento != null
                              ? "${c.dataNascimento!.day.toString().padLeft(2, '0')}/${c.dataNascimento!.month.toString().padLeft(2, '0')}/${c.dataNascimento!.year}"
                              : '',
                        ),
                        titulo: "Data de nascimento:",
                        label: "DD/MM/AA",
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
                        titulo: "CPF:",
                        label: "000.000.000-00",
                        readOnly: !modoEdicao,
                      ),

                      CampoFormulario(
                        controller: c.enderecoController,
                        titulo: "Endereço:",
                        label: "Rua das Flores, 130",
                        readOnly: !modoEdicao,
                      ),

                      CampoFormulario(
                        controller: c.telefoneController,
                        titulo: "Telefone:",
                        label: "(99) 99999-9999",
                        readOnly: !modoEdicao,
                      ),

                      CampoFormulario(
                        controller: c.emailController,
                        titulo: "E-mail:",
                        label: "seuemail@email.com",
                        readOnly: !modoEdicao,
                      ),
                    ],
                  ),

                  const SizedBox(height: 16),

                  //container dos dados do responsável (se menor de idade)
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
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
                        titulo: "Nome do responsável:",
                        label: "Maria Silva",
                        readOnly: !modoEdicao,
                      ),

                      CampoFormulario(
                        controller: c.cpfResponsavelController,
                        titulo: "CPF do responsável:",
                        label: "000.000.000-00",
                        readOnly: !modoEdicao,
                      ),
                    ],
                  ),

                  const SizedBox(height: 16),

                  // Container Informações de Pagamento
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
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
                        titulo: "Valor da mensalidade:",
                        label: "000,00",
                        readOnly: !modoEdicao,
                      ),

                      CampoFormulario(
                        controller: TextEditingController(
                          text: c.vencimento != null
                              ? "${c.vencimento!.day.toString().padLeft(2, '0')}/${c.vencimento!.month.toString().padLeft(2, '0')}/${c.vencimento!.year}"
                              : '',
                        ),
                        titulo: "Data do primeiro vencimento:",
                        label: "DD/MM/AA",
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

                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Padding(
                            padding: const EdgeInsets.symmetric(
                              horizontal: 12.0,
                            ),
                            child: Text(
                              "Frequência de pagamento:",
                              style: const TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                          const SizedBox(height: 4),
                          Container(
                            padding: EdgeInsets.symmetric(
                              horizontal: 20,
                              vertical: 4,
                            ),
                            margin: EdgeInsets.only(bottom: 12),
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(36),
                              border: Border.all(color: Colors.black),
                              color: Colors.white,
                            ),
                            child: DropdownButton(
                              value: c.frequenciaPagamento,
                              isExpanded: true,
                              underline: SizedBox.shrink(),
                              dropdownColor: Colors.white,
                              hint: Text(
                                "Mensal, semanal...",
                                style: TextStyle(
                                  color: Colors.grey[400],
                                  fontSize: 16,
                                ),
                              ),
                              items: ['Mensal', 'Semanal', 'Por aula'].map((
                                String valor,
                              ) {
                                return DropdownMenuItem(
                                  value: valor,
                                  child: Text(valor),
                                );
                              }).toList(),
                              onChanged: modoEdicao
                                  ? (String? valor) {
                                      setState(() {
                                        c.frequenciaPagamento = valor;
                                      });
                                    }
                                  : null,
                            ),
                          ),
                        ],
                      ),

                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Padding(
                            padding: const EdgeInsets.symmetric(
                              horizontal: 12.0,
                            ),
                            child: Text(
                              "Forma de pagamento:",
                              style: const TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                          const SizedBox(height: 4),
                          Container(
                            padding: EdgeInsets.symmetric(
                              horizontal: 20,
                              vertical: 4,
                            ),
                            margin: EdgeInsets.only(bottom: 12),
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(36),
                              border: Border.all(color: Colors.black),
                              color: Colors.white,
                            ),
                            child: DropdownButton(
                              value: c.formaPagamento,
                              isExpanded: true,
                              underline: SizedBox.shrink(),
                              dropdownColor: Colors.white,
                              hint: Text(
                                "Pix, Cartão de débito...",
                                style: TextStyle(
                                  color: Colors.grey[400],
                                  fontSize: 16,
                                ),
                              ),
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
                              onChanged: modoEdicao
                                  ? (String? valor) {
                                      setState(() {
                                        c.formaPagamento = valor;
                                      });
                                    }
                                  : null,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                  const SizedBox(height: 16),

                  Center(
                    child: ElevatedButton(
                      onPressed: () {
                        c.salvarAluno(context);
                      },
                      style: ElevatedButton.styleFrom(
                        elevation: 4,
                        padding: const EdgeInsets.symmetric(
                          horizontal: 48,
                          vertical: 12,
                        ),
                        backgroundColor: Colors.black,
                        foregroundColor: Colors.white,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(36),
                        ),
                      ),
                      child: Text("Salvar", style: TextStyle(fontSize: 18)),
                    ),
                  ),
                  const SizedBox(height: 16),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
