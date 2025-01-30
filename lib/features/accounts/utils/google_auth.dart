import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';

class GoogleAuthSparkApp {
  final FirebaseAuth _auth = FirebaseAuth.instance;

  // Metodo para autenticar con Google (iniciar sesion)
  Future<MyReturnSignIn> signInWithGoogle() async {
    final GoogleAuthProvider googleAuthProvider = GoogleAuthProvider();
    googleAuthProvider.addScope('email');
    googleAuthProvider.addScope('profile');

    try {
      final GoogleSignInAccount? googleSignInAccount =
          await GoogleSignIn().signIn();

      if (googleSignInAccount != null) {
        final GoogleSignInAuthentication googleSignInAuthentication =
            await googleSignInAccount.authentication;

        final AuthCredential credential = GoogleAuthProvider.credential(
          accessToken: googleSignInAuthentication.accessToken,
          idToken: googleSignInAuthentication.idToken,
        );

        final UserCredential userCredential =
            await _auth.signInWithCredential(credential);
        final User? user = userCredential.user;
        return MyReturnSignIn(
          fullName: user?.displayName ?? '',
          email: user?.email ?? '',
          phoneNumber: user?.phoneNumber ?? '',
          uid: user?.uid ?? '',
        );
      } else {
        return MyReturnSignIn(fullName: '', email: '', phoneNumber: '', uid: '', );
      }
    } catch (e) {
      throw Exception('Error al iniciar sesion con Google: $e');
    }
  }

  // Metodo para cerrar sesion con Google
  Future<void> signOutWithGoogle() async {
    final GoogleSignIn _googleSignIn = GoogleSignIn();
    try {
      await _auth.signOut(); // Cerrar sesion con Firebase
      await _googleSignIn.signOut(); // Eliminar el token de Google
    } catch (e) {
      throw Exception('Error al cerrar sesion con Google: $e');
    }
  }
}

class MyReturnSignIn {
  final String fullName;
  final String email;
  final String phoneNumber;
  final String uid;

  MyReturnSignIn({
    required this.fullName,
    required this.email,
    required this.phoneNumber,
    required this.uid,
  });
}
