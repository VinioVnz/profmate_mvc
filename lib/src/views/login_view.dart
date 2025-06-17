import 'package:flutter/material.dart';
import 'package:profmate/src/controller/login_controller.dart';
import 'package:profmate/src/services/auth_service.dart';

class LoginView extends StatefulWidget {
  const LoginView({super.key});

  @override
  State<LoginView> createState() => _LoginviewState();
}

class _LoginviewState extends State<LoginView> {
  final _controller = LoginController();
  final _usernameController = TextEditingController();
  final _passwordController = TextEditingController();
  String _message = "";
  bool _carregando = false;
  @override
  void initState() {
    super.initState();
  }

  void _handleLogin() async {
    FocusScope.of(context).unfocus();
    setState(() {
      _carregando = true;
    });
    
    final sucess = await _controller.autenticar(
      _usernameController.text,
      _passwordController.text,
    );

    if (sucess) {
      AuthService.login();
      Navigator.pushReplacementNamed(context, '/home');
    } else {
      setState(() {
        _message = 'Usuário ou senha incorretos';
        _carregando = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children:[ 
          SafeArea(
          child: SingleChildScrollView(
            child: Center(
              child: ConstrainedBox(
                constraints: BoxConstraints(
                  minHeight: MediaQuery.of(context).size.height,
                ),
                child: Padding(
                  padding: EdgeInsets.all(24),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(bottom: 8.0),
                        child: Image.asset('assets/images/logo.png'),
                      ),
                      Text(
                        'PROFMATE',
                        style: TextStyle(
                          fontSize: 22,
                          fontWeight: FontWeight.w900,
                        ),
                      ),
                      Padding(padding: const EdgeInsets.only(bottom: 56.0)),
                      Text(
                        'LOGIN',
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.w900,
                        ),
                      ),
                      SizedBox(height: 24),
                      //campo user
                      TextField(
                        controller: _usernameController,
                        decoration: InputDecoration(
                          filled: true,
                          fillColor:Color.fromARGB(138, 230, 225, 225),
                          labelStyle: TextStyle(color: const Color.fromARGB(255, 70, 70, 70)),
                          labelText: 'E-MAIL',
                          focusedBorder: OutlineInputBorder(
                            borderSide: const BorderSide(color: Colors.black),
                            borderRadius: BorderRadius.circular(12),
                          ),
                          hintText: 'Digite seu email',
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(12),
                            borderSide: BorderSide.none
                          ),
                        ),
                      ),
                      SizedBox(height: 8),
                      TextField(
                        obscureText: true,
                        controller: _passwordController,
                        decoration: InputDecoration(
                          filled: true,
                          fillColor:Color.fromARGB(138, 230, 225, 225),
                          labelStyle: TextStyle(color: const Color.fromARGB(255, 70, 70, 70)),
                          labelText: 'SENHA',
                          focusedBorder: OutlineInputBorder(
                            borderSide: const BorderSide(color: Colors.black),
                            borderRadius: BorderRadius.circular(12),
                          ),
                          hintText: 'Digite sua senha',
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(12),
                            borderSide: BorderSide.none
                          ),
                        ),
                      ),
                      SizedBox(height: 24),
                      Container(
                        width: 140,
                        height: 50,
                        child: ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.black,
                            foregroundColor: Colors.white,
                          ),
                          onPressed: _handleLogin,
                          child: Text('ENTRAR', style: TextStyle(fontSize: 18)),
                        ),
                      ),
                      SizedBox(height: 16),
                      Text(
                        _message,
                        style: TextStyle(color: Colors.red, fontSize: 16),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ),
        if (_carregando)
        Container(
          color: Colors.black.withOpacity(0.5),
          child: Center(
            child: CircularProgressIndicator(color: Color(0xff1E3A5E)),
          ),
        ),
      ]
      ),
    );
  }
}
