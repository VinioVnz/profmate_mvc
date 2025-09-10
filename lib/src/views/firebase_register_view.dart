import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:profmate/src/controller/user_api_controller.dart';
import 'package:profmate/src/controller/user_firebase_controller.dart';
import 'package:profmate/src/models/user_api_model.dart';
import 'package:profmate/src/utils/date_converter_util.dart';
import 'package:profmate/src/widgets/campo_formulario.dart';
import 'package:profmate/src/widgets/custom_app_bar.dart';
import 'package:profmate/src/widgets/custom_elevated_button.dart';
import 'package:mask_text_input_formatter/mask_text_input_formatter.dart';
import 'package:shared_preferences/shared_preferences.dart';

class FirebaseRegisterView extends StatefulWidget {
  const FirebaseRegisterView({super.key});

  @override
  State<FirebaseRegisterView> createState() => _FirebaseRegisterViewState();
}

class _FirebaseRegisterViewState extends State<FirebaseRegisterView> {
  bool oculto = true;
  bool _loading = false;
  String? _erro;
  final _formKey = GlobalKey<FormState>();

  final DateConverterUtil dateConverter = DateConverterUtil();
  final UserFirebaseController _controller = UserFirebaseController();
  final UserApiController _apiController = UserApiController();

  final _nomeController = TextEditingController();
  final _emailController = TextEditingController();
  final _senhaController = TextEditingController();
  final _telefoneController = TextEditingController();
  final _cpfController = TextEditingController();

  final formatarCPF = MaskTextInputFormatter(
    mask: "###.###.###-##",
    filter: {"#": RegExp(r'[0-9]')},
  );

  final formatarTelefone = MaskTextInputFormatter(
    mask: "(##) #####-####",
    filter: {"#": RegExp(r'[0-9]')},
  );

  void _cadastrar() async {
    if (!_formKey.currentState!.validate()) {
      setState(() {
        _erro = "Por favor, preencha todos os campos corretamente.";
      });
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text(_erro!), backgroundColor: Colors.red),
      );
      return;
    }
    setState(() {
      _loading = true;
      _erro = null;
    });

    try {
      final user = UserApiModel(
        uid: '',
        nome: _nomeController.text,
        cpf: _cpfController.text,
        email: _emailController.text,
        telefone: _telefoneController.text,
        password: _senhaController.text,
      );

      final createdUser = await _apiController.criarUsuario(user);
      print('ID DO USUARIO: ${createdUser.id}');

      final usuario = await _controller.cadastrar(
        createdUser.id!,
        _nomeController.text,
        _emailController.text,
        _senhaController.text,
        _cpfController.text,
        _telefoneController.text,
      );

      SharedPreferences prefs = await SharedPreferences.getInstance();
      await prefs.setInt('user_id', usuario!.id!);

      ScaffoldMessenger.of(
        context,
      ).showSnackBar(SnackBar(content: Text('Bem-vindo ${usuario.nome}')));

      Navigator.pushReplacementNamed(context, '/home');
    } on FirebaseAuthException catch (e) {
      final mensagem = _mensagemErroFirebase(e.code);

      setState(() {
        _erro = mensagem;
      });

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text(mensagem), backgroundColor: Colors.red),
      );
    } catch (e) {
      final mensagem = "Ocorreu um erro inesperado. Tente novamente.";
      setState(() {
        _erro = mensagem;
      });

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text(mensagem), backgroundColor: Colors.red),
      );
    } finally {
      setState(() {
        _loading = false;
      });
    }
  }

  // Função utilitária para traduzir erros do Firebase
  String _mensagemErroFirebase(String code) {
    switch (code) {
      case 'invalid-email':
        return 'O e-mail informado é inválido.';
      case 'email-already-in-use':
        return 'Este e-mail já está cadastrado.';
      case 'weak-password':
        return 'A senha é muito fraca. Use ao menos 6 caracteres.';
      case 'operation-not-allowed':
        return 'Operação não permitida. Contate o suporte.';
      default:
        return 'Ocorreu um erro. Tente novamente.';
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
              Padding(
                padding: const EdgeInsets.only(bottom: 8.0),
                child: Image.asset('assets/images/logo.png'),
              ),
              Text(
                'PROFMATE',
                style: TextStyle(fontSize: 22, fontWeight: FontWeight.w900),
              ),
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
                validator: (value) =>
                    value == null || value.isEmpty ? 'Campo obrigatório' : null,
                keyboardType: TextInputType.emailAddress,
              ),
              CampoFormulario(
                suffixIcon: IconButton(
                  color: Colors.black,
                  onPressed: () {
                    setState(() {
                      oculto = !oculto;
                    });
                  },
                  icon: oculto
                      ? Icon(Icons.visibility)
                      : Icon(Icons.visibility_off),
                ),
                obscureText: oculto,
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
                      onPressed: () {
                        _cadastrar();
                      },
                    ),
            ],
          ),
        ),
      ),
    );
  }
}
