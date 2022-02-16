import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_facebook_auth/flutter_facebook_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:github_sign_in/github_sign_in.dart';


class SignInUpService extends ChangeNotifier {
  late final FirebaseAuth fireBaseAuth;

  late UserCredential curUser;

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

      curUser = await fireBaseAuth.createUserWithEmailAndPassword(
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

  // ? Google Sign in Credintials

  Future<UserCredential> signInWithGoogle() async {
    // Trigger the authentication flow
    final GoogleSignInAccount? googleUser = await GoogleSignIn().signIn();

    // Obtain the auth details from the request
    final GoogleSignInAuthentication? googleAuth =
        await googleUser?.authentication;

    // Create a new credential
    final credential = GoogleAuthProvider.credential(
      accessToken: googleAuth?.accessToken,
      idToken: googleAuth?.idToken,
    );

    notifyListeners();
    print("shu yerdan pasta");

    return await FirebaseAuth.instance.signInWithCredential(credential);
  }
  // ? Facebook Sign In

  // Future<UserCredential> signInWithFacebook() async {
  //   // Trigger the sign-in flow
  //   final LoginResult loginResult = await FacebookAuth.instance.login();

  //   // Create a credential from the access token
  //   final OAuthCredential facebookAuthCredential =
  //       FacebookAuthProvider.credential(loginResult.accessToken!.token);

  //   // Once signed in, return the UserCredential
  //   // FirebaseAuth.instance.signInWithCredential(facebookAuthCredential).then(
  //   //       (value) => print(value),
  //       // );
  //   return FirebaseAuth.instance.signInWithCredential(facebookAuthCredential);
  // }

  Future<String?> facebookSignin() async {
    try {
      final _instance = FacebookAuth.instance;
      final result = await _instance.login(permissions: ['email']);
      if (result.status == LoginStatus.success) {
        final OAuthCredential credential =
            FacebookAuthProvider.credential(result.accessToken!.token);
        final a = await fireBaseAuth.signInWithCredential(credential);
        await _instance.getUserData().then((userData) async {
          await fireBaseAuth.currentUser!.updateEmail(userData['email']);
        });
        print("if 1 qismi");
        return null;
      } else if (result.status == LoginStatus.cancelled) {
        print("if 2 qismi");

        return 'Login cancelled';
      } else {
        print("if 3 qismi");

        return 'Error';
      }
    } catch (e) {
      print("if 4 qismi");

      return e.toString();
    }
  }
// ?---------------------------


}
