import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:profmate/src/controller/cadastro_aluno_controller.dart';
import 'package:profmate/src/models/aluno_api_model.dart';
import 'package:profmate/src/widgets/base_layout.dart';
import 'package:profmate/src/widgets/campo_formulario.dart';
import 'package:profmate/src/widgets/custom_elevated_button.dart';

class CadastroAlunoView extends StatefulWidget {
  

  const CadastroAlunoView({
    super.key
  });

  @override
  State<CadastroAlunoView> createState() => _CadastroAlunoViewState();
}

class _CadastroAlunoViewState extends State<CadastroAlunoView> {
  final _chaveDoFormulario = GlobalKey<FormState>();
  final CadastroAlunoController controller = CadastroAlunoController();
   void _salvarAluno()async{
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

      try{
        await controller.criarAluno(aluno);
        Navigator.pop(context, true);
      }catch(e){
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text("Erro ao salvar o aluno, Erro: $e"))
        );
      }
  }

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
                  const Text("Dados pessoais", style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),),

                  SizedBox(height: 8),

                  CampoFormulario(
                  controller: controller.nomeController,
                  titulo: "Nome completo:",
                  hintText: "Ex: Maria Silva"),

                  CampoFormulario(
                  controller: controller.cpfController,
                  titulo: "CPF:",
                  hintText: "Ex: 000.000.000-00"),

                  //Acresentar campo da data de nascimento aqui
                  
                  CampoFormulario(
                  controller: controller.dataNascimentoController,
                  titulo: "Data de Nascimento:",
                  hintText: "Ex: 00/00/0000"),

                  CampoFormulario(
                  controller: controller.enderecoController,
                  titulo: "Endereço:",
                  hintText: "Ex: Rua das flores, 140"),

                  CampoFormulario(
                  controller: controller.telefoneController,
                  titulo: "Telefone:",
                  hintText: "Ex: (99) 99999-9999"),
                  
                  CampoFormulario(
                  controller: controller.emailController,
                  titulo: "E-mail:",
                  hintText: "Ex: meuEmail@email.com"),

                  //Dados do Responsável (caso menor de idade):
                  const Text("Dados do responsável", style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),),

                  SizedBox(height: 8),
                  
                  CampoFormulario(
                  controller: controller.nomeResponsavelController,                  
                  titulo: "Nome do Responsável:",
                  hintText: "Ex: Osvaldo Silva"),

                  CampoFormulario(
                  controller: controller.cpfResponsavelController,                  
                  titulo: "CPF do responsável:",
                  hintText: "Ex: 000.000.000-00"),

                  SizedBox(height: 8),

                  CustomElevatedButton(
                    tituloBotao: "Salvar", 
                    onPressed: (){
                      _salvarAluno();
                    }),
                ],
              ),
            ),
          )
        ),
    )
  );
}
}