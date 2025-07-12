import 'package:flutter/material.dart';
import 'package:profmate/src/controller/cadastrar_aluno_controller.dart';
import 'package:profmate/src/widgets/base_layout.dart';
import 'package:profmate/src/widgets/campo_formul%C3%A1rio.dart';

class CadastrarAlunoView extends StatefulWidget {
  final CadastrarAlunoController cadastrarAlunoController;
  const CadastrarAlunoView({required this.cadastrarAlunoController, super.key});

  @override
  State<CadastrarAlunoView> createState() => _CadastrarAlunoViewState();
}

class _CadastrarAlunoViewState extends State<CadastrarAlunoView> {
  final GlobalKey<FormState> _chaveFormulario = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    final c = widget.cadastrarAlunoController;

    return BaseLayout(
      title: 'Cadastrar Aluno',
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Center(
          child: SingleChildScrollView(
            child: Form(
              key: _chaveFormulario,
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
                          controller: c.cpfController,
                          label: "CPF",
                        ),

                        CampoFormulario(
                          controller: c.emailController,
                          label: "E-mail",
                        ),
                        CampoFormulario(
                          controller: c.enderecoController,
                          label: "Endereço",
                        ),
                      ],
                    ),
                  ),

                  const SizedBox(height: 24),

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
                        
                        //campos do formulário de informações de pagamento
                        CampoFormulario(
                          controller: c.valorController,
                          label: "Valor da aula/mensalidade",
                        ),
                        
                        CampoFormulario(
                          controller: c.formaPagamentoController,
                          label: "Forma de pagamento",
                        ),
                        
                        // adicionar outros campos de pagamento
                      ],
                    ),
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
