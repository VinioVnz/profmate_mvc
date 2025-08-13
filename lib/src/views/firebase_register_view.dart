import 'package:flutter/material.dart';
import 'package:profmate/src/controller/user_api_controller.dart';
import 'package:profmate/src/controller/user_firebase_controller.dart';
import 'package:profmate/src/models/user_api_model.dart';
import 'package:profmate/src/models/user_firebase_model.dart';

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
  final UserApiController _apiController = UserApiController();
  final _nomeController = TextEditingController();
  final _emailController = TextEditingController();
  final _senhaController = TextEditingController();
  final _cpfController = TextEditingController();
  final _dataNascimentoController = TextEditingController();

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
        _cpfController.text,
        DateTime.tryParse(_dataNascimentoController.text) ??
            DateTime(0000, 1, 1),
      );
      setState(() {
        _loading = false;
      });

      if (usuario != null) {
        final user = UserApiModel(
          uid: usuario.uid,
          nome: usuario.nome,
          cpf: usuario.cpf,
          email: usuario.email,
          dataNascimento: usuario.dataNascimento, //ta tendo que usar o padrao americano: YYYY-MM-DD
          password: _senhaController.text,
        );

        await _apiController.criarAluno(user);
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
      appBar: AppBar(title: Text('Cadastro firebase')),
      body: Padding(
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
              TextFormField(
                controller: _nomeController,
                decoration: InputDecoration(
                  labelText: 'Nome',
                  border: OutlineInputBorder(),
                ),
                validator: (value) =>
                    value == null || value.isEmpty ? 'Informe seu nome' : null,
              ),
              SizedBox(height: 12),
              TextFormField(
                controller: _emailController,
                decoration: InputDecoration(
                  labelText: 'E-mail',
                  border: OutlineInputBorder(),
                ),
                validator: (value) => value == null || value.isEmpty
                    ? 'Informe seu e-mail'
                    : null,
              ),
              SizedBox(height: 12),
              TextFormField(
                obscureText: true,
                controller: _senhaController,
                decoration: InputDecoration(
                  labelText: 'Senha',
                  border: OutlineInputBorder(),
                ),
                validator: (value) =>
                    value == null || value.length < 6 ? 'Senha' : null,
              ),
              SizedBox(height: 12),
              TextFormField(
                controller: _cpfController,
                decoration: InputDecoration(
                  labelText: 'Cpf',
                  border: OutlineInputBorder(),
                ),
                validator: (value) =>
                    value == null || value.isEmpty ? 'Informe seu cpf' : null,
              ),
              SizedBox(height: 12),
              TextFormField(
                controller: _dataNascimentoController,
                decoration: InputDecoration(
                  labelText: 'Data de Nascimento',
                  border: OutlineInputBorder(),
                ),
                validator: (value) => value == null || value.isEmpty
                    ? 'Informe sua Data de Nascimento'
                    : null,
              ),
              SizedBox(height: 16),
              //botao de loading
              _loading
                  ? const CircularProgressIndicator()
                  : ElevatedButton(
                      onPressed: _cadastrar,
                      child: Text('Cadastrar'),
                    ),
            ],
          ),
        ),
      ),
    );
  }
}
