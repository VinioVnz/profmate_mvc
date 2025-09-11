import 'package:firebase_auth/firebase_auth.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class AuthService {
  final _auth = FirebaseAuth.instance;
  //final String baseUrl = 'https://api-profmate.onrender.com';
   final String baseUrl = 'http://10.0.2.2:3000'; 

  /// Faz login com Firebase e pega JWT do backend
  Future<User?> login(String email, String senha) async {
    try {
      // 1️⃣ Login no Firebase
      final cred = await _auth.signInWithEmailAndPassword(
        email: email,
        password: senha,
      );
      final user = cred.user;
      if (user == null) return null;

      // 2️⃣ Pega idToken do Firebase
      final idToken = await user.getIdToken();

      // 3️⃣ Solicita JWT do backend
      final response = await http.post(
        Uri.parse('$baseUrl/auth/login'),
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode({'token': idToken}),
      );

      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);

        // 4️⃣ Salva JWT e user_id no SharedPreferences
        final prefs = await SharedPreferences.getInstance();
        await prefs.setString('jwt_token', data['jwt_token']);
        await prefs.setInt('user_id', data['user_id']);

        return user;
      } else {
        throw Exception("Erro ao autenticar no backend");
      }
    } catch (e) {
      rethrow;
    }
  }

  /// Logout completo
  Future<void> logout() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.remove('jwt_token');
    await prefs.remove('user_id');
    await _auth.signOut();
  }

  /// Verifica se o usuário está logado
  Future<bool> checkLogin() async {
    final user = _auth.currentUser; // Firebase mantém login automaticamente
    final prefs = await SharedPreferences.getInstance();
    final token = prefs.getString('jwt_token');
    final userId = prefs.getInt('user_id');

    // Se tiver usuário e token válido, retorna true
    return user != null;
  }

  /// Pega UID do Firebase
  Future<String?> getUid() async {
    return _auth.currentUser?.uid;
  }

  /// Pega JWT salvo
  Future<String?> getToken() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getString('jwt_token');
  }

  /// Pega user_id salvo
  Future<int?> getUserId() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getInt('user_id');
  }
}
