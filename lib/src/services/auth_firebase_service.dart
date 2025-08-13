import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:profmate/src/models/user_firebase_model.dart';

class AuthFirebaseService {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  Future<UserFirebaseModel?> registrarUsuario(
    String nome,
    String email,
    String senha,
    String cpf,
    DateTime dataNascimento
  ) async {
    try {
      UserCredential cred = await _auth.createUserWithEmailAndPassword(
        email: email,
        password: senha,
      );

      UserFirebaseModel usuario = UserFirebaseModel(
        uid: cred.user!.uid,
        nome: nome,
        email: email,
        cpf: cpf,
        dataNascimento: dataNascimento,
      );

      await _firestore
          .collection('users')
          .doc(cred.user!.uid)
          .set(usuario.toMap());

      return usuario;
    } on FirebaseAuthException catch (e) {
      print("Erro no cadastro: ${e.code}");
      return null;
    }
  }

  Future<UserFirebaseModel?> login(String email, String senha) async {
    try {
      UserCredential cred = await _auth.signInWithEmailAndPassword(
        email: email,
        password: senha,
      );
      DocumentSnapshot snapshot = await _firestore
          .collection('users')
          .doc(cred.user!.uid)
          .get();
      return UserFirebaseModel.fromMap(snapshot.data() as Map<String, dynamic>);
    } catch (e) {
      print('erro ao efetuar o login $e');
      return null;
    }
  }
}
