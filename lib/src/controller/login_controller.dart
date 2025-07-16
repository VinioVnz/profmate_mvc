import 'package:profmate/src/models/login_model.dart';
import 'package:profmate/src/services/api_service.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LoginController {
  /* Future<bool> autenticar(String user, String password) async{
    LoginModel usuario = LoginModel(user: user, password: password);

    await Future.delayed(Duration(seconds: 2));
    return usuario.user == "admin" && usuario.password == "12345"; 
  } */

  final _ApiService = ApiService();

  Future<bool> login(LoginModel user) async{
    final token = await _ApiService.login(user.ToJson());

    if(token != null){
      final prefs = await SharedPreferences.getInstance();
      await prefs.setString('jwt_token', token);
      return true;
    } else {
      return false;
    }
  }
}
