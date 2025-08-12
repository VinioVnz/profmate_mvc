import 'package:profmate/src/models/user_firebase_model.dart';
import 'package:profmate/src/services/auth_firebase_service.dart';

class UserFirebaseController {
  final AuthFirebaseService _authService = AuthFirebaseService();

  Future<UserFirebaseModel?> cadastrar(String nome, String email, String senha){
    return _authService.registrarUsuario(nome, email, senha);
  }

  Future<UserFirebaseModel?> autenticar(String email, String senha){
    return _authService.login(email, senha);
  }
}