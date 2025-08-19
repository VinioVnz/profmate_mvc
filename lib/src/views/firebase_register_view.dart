import 'package:flutter/material.dart';
import 'package:profmate/src/controller/user_firebase_controller.dart';
import 'package:profmate/src/widgets/campo_formulario.dart';
import 'package:profmate/src/widgets/custom_app_bar.dart';
import 'package:profmate/src/widgets/custom_elevated_button.dart';
import 'package:mask_text_input_formatter/mask_text_input_formatter.dart';

class FirebaseRegisterView extends StatefulWidget {
  const FirebaseRegisterView({super.key});

  @override
  State<FirebaseRegisterView> createState() => _FirebaseRegisterViewState();
}

class _FirebaseRegisterViewState extends State<FirebaseRegisterView> {
  bool _loading = false;
  String? _erro;
  final _formKey = GlobalKey<FormState>();
  final UserFirebaseController _controller = UserFirebaseController();
  final _nomeController = TextEditingController();
  final _emailController = TextEditingController();
  final _senhaController = TextEditingController();
  final _telefoneController = TextEditingController();
  final _dtNascimentoController = TextEditingController();
  final _cpfController = TextEditingController();

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

  void _cadastrar() async {
    if (_formKey.currentState!.validate()) {
      setState(() {
        _loading = true;
        _erro = null;
      });

      // ajustar a classe user_firebase_controller
      final professor = await _controller.cadastrar(
        _nomeController.text,
        _emailController.text,
        _senhaController.text,
        _dtNascimentoController.text,
        _telefoneController.text,
        _cpfController.text,
      );

      setState(() {
        _loading = false;
      });
      print("USUARIO:    $professor");
      if (professor != null) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Usuário cadastrado com sucesso')),
        );
        Navigator.pop(context);
      } else {
        setState(() {
          _erro = "Erro ao cadastrar Usuario";
        });
        ScaffoldMessenger.of(
          context,
        ).showSnackBar(SnackBar(content: Text('Erro ao cadastrar usuario')));
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(title: 'Cadastro'),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(16),
        child: Form(
          key: _formKey,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              if (_erro != null) ...[
                Text(_erro!, style: const TextStyle(color: Colors.red)),
                SizedBox(height: 20),
              ],
              CampoFormulario(
                controller: _nomeController,
                titulo: 'Nome',
                hintText: 'Digite seu nome completo',
                validator: (value) =>
                    value == null || value.isEmpty ? 'Campo obrigatório' : null,
                keyboardType: TextInputType.name,
              ),
              CampoFormulario(
                controller: _emailController,
                titulo: 'E-mail',
                hintText: 'Digite seu e-mail',
                keyboardType: TextInputType.emailAddress,
              ),
              CampoFormulario(
                controller: _senhaController,
                titulo: 'Senha',
                hintText: 'Digite sua senha (mín. 6 caracteres)',
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Campo obrigatório';
                  }
                  if (value.length < 6) {
                    return 'A senha deve ter pelo menos 6 caracteres';
                  }
                  return null;
                },
                keyboardType: TextInputType.visiblePassword,
              ),
              CampoFormulario(
                controller: _telefoneController,
                hintText: 'Campo obrigatório',
                titulo: 'Telefone',
                validator: (value) =>
                    value == null || value.isEmpty ? 'Campo obrigatório' : null,
                formatar: [formatarTelefone],
              ),
              CampoFormulario(
                controller: _dtNascimentoController,
                hintText: 'Ex: 12/08/1990',
                titulo: 'Data de nascimento',
                validator: (value) =>
                    value == null || value.isEmpty ? 'Campo obrigatório' : null,
                formatar: [formatarData],
              ),
              CampoFormulario(
                controller: _cpfController,
                hintText: 'Campo obrigatório',
                titulo: 'CPF',
                validator: (value) =>
                    value == null || value.isEmpty ? 'Campo obrigatório' : null,
                formatar: [formatarCPF],
              ),
              SizedBox(height: 16),
              _loading
                  ? const CircularProgressIndicator()
                  : CustomElevatedButton(
                      tituloBotao: 'Criar conta',
                      onPressed: _cadastrar,
                    ),
            ],
          ),
        ),
      ),
    );
  }
}
