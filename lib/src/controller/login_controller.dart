import 'package:profmate/src/models/login_model.dart';

class LoginController {
  Future<bool> autenticar(String user, String password) async{
    LoginModel usuario = LoginModel(user: user, password: password);

    await Future.delayed(Duration(seconds: 2));
    return usuario.user == "admin" && usuario.password == "12345"; 
  }
}