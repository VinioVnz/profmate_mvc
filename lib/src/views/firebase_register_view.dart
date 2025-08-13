import 'package:flutter/material.dart';
import 'package:profmate/src/controller/user_firebase_controller.dart';
import 'package:profmate/src/widgets/campo_formulario.dart';
import 'package:profmate/src/widgets/custom_app_bar.dart';
import 'package:profmate/src/widgets/custom_elevated_button.dart';

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
  final _dataNascimento = TextEditingController();
  final _cpf = TextEditingController();

  void _cadastrar() async {
    if (_formKey.currentState!.validate()) {
      setState(() {
        _loading = true;
        _erro = null;
      });

      final usuario = await _controller.cadastrar(
        _nomeController.text,
        _emailController.text,
        _senhaController.text,
        _dataNascimento.text,
      );

      setState(() {
        _loading = false;
      });
      print("USUARIO:    $usuario");
      if (usuario != null) {
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
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Campo obrigatório';
                  }
                  // Validação básica de e-mail
                  if (!RegExp(
                    r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$',
                  ).hasMatch(value)) {
                    return 'Digite um e-mail válido';
                  }
                  return null;
                },
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
                controller: _dataNascimento,
                hintText: 'Campo obrigatório',
                titulo: 'Data de nascimento',
              ),
              CampoFormulario(
                controller: _cpf,
                hintText: 'Campo obrigatório',
                titulo: 'CPF',
              ),
              SizedBox(height: 16),
              //botao de loading
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
