/* import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';

Future<UserCredential?> signInWithGoogle() async{
  try {
    final GoogleSignIn googleSignIn = GoogleSignIn(scopes: ['email']);
    
    final GoogleSignInAccount? googleUser = await googleSignIn.signIn();
    if(googleUser == null) return null;

    final GoogleSignInAuthentication googleAuth = await googleUser.authentication;

    final credential = GoogleAuthProvider.credential(
      accessToken: googleAuth.accessToken,
      idToken: googleAuth.idToken
    );

    return await FirebaseAuth.instance.signInWithCredential(credential);
      } catch (e) {
        print('Erro ao fazer o login: $e');
        return null;
  }

} */