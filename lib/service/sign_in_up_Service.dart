import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';

class SignInUpService extends ChangeNotifier {
  late final FirebaseAuth fireBaseAuth;

  late UserCredential _curUser;

  SignInUpService(this.fireBaseAuth);

  Stream<User?> get authChanges => fireBaseAuth.authStateChanges();

  Future signOut() async {
    await fireBaseAuth.signOut();
    notifyListeners();
  }

  Future<String?> signIn({String? email, String? password}) async {
    try {
      await fireBaseAuth.signInWithEmailAndPassword(
          email: email!, password: password!);
      notifyListeners();
      return "sign in";
    } on FirebaseAuthException catch (e) {
      notifyListeners();

      return e.message;
    }
  }

  Future<String?> singUP({String? email, String? password}) async {
    try {
      notifyListeners();

      _curUser = await fireBaseAuth.createUserWithEmailAndPassword(
        email: email!,
        password: password!,
      );
      notifyListeners();

      return "sign up";
    } on FirebaseAuthException catch (e) {
      notifyListeners();

      return e.message;
    }
  }
}
