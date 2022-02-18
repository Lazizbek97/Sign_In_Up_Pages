import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_facebook_auth/flutter_facebook_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';
// ignore: import_of_legacy_library_into_null_safe
import 'package:github_sign_in/github_sign_in.dart';
import 'package:twitter_login/twitter_login.dart';

class SignInUpService extends ChangeNotifier {
  late final FirebaseAuth fireBaseAuth;

  late UserCredential curUser;

  SignInUpService(this.fireBaseAuth);

  Stream<User?> get authChanges => fireBaseAuth.authStateChanges();

  Future signOutUser() async {
    notifyListeners();

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

  Future<String?> singUP({
    String? email,
    String? password,
    String? name,
  }) async {
    try {
      curUser = await fireBaseAuth.createUserWithEmailAndPassword(
        email: email!,
        password: password!,
      );
      User? user = curUser.user;
      await user!.updateDisplayName(name);

      notifyListeners();

      return "sign up";
    } on FirebaseAuthException catch (e) {
      notifyListeners();

      return e.message;
    }
  }

  // ? Google Sign in Credintials

  Future signInWithGoogle() async {
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
    await FirebaseAuth.instance.signInWithCredential(credential);

    notifyListeners();
  }
  // ? Facebook Sign In

  Future<String?> signInWithFacebook() async {
    try {
      // Trigger the sign-in flow
      final LoginResult loginResult = await FacebookAuth.instance.login();
      final userData = await FacebookAuth.instance.getUserData();

      // Create a credential from the access token
      final OAuthCredential facebookAuthCredential =
          FacebookAuthProvider.credential(loginResult.accessToken!.token);

      await FirebaseAuth.instance.signInWithCredential(facebookAuthCredential);

      await FirebaseFirestore.instance.collection("users").add({
        'email': userData['email'],
        'imageUrl': userData['picture']['data']['url'],
        'name': userData['name'],
      });

      return "Successfully loged!";
    } on FirebaseAuthException {
      var title =
          "You've used this email already, try with another social media or email";
      return title;
    } finally {
      notifyListeners();
    }
  }
  // ? GitHub Auth login

  Future signInWithGitHub(context) async {
    String clientId = 'client id';
    String clientSecret = 'client secret';
    try {
      // Create a GitHubSignIn instance
      final GitHubSignIn gitHubSignIn = GitHubSignIn(
          clientId: clientId,
          clientSecret: clientSecret,
          redirectUrl: 'redirect uri');

      // Trigger the sign-in flow
      final result = await gitHubSignIn.signIn(context);

      // Create a credential from the access token
      final githubAuthCredential = GithubAuthProvider.credential(result.token);

      // Once signed in, return the UserCredential
      await FirebaseAuth.instance.signInWithCredential(githubAuthCredential);
      return 'Successfully loged!';
    } catch (e) {
      return "This email has been already used";
    }
  }
  // ? Twitter Auth login

  Future signInWithTwitter() async {
    String apiKeyTwitter = 'api key';
    String apiSecretkeyTwitter = 'api secret key';
    String redirectURI = 'redirect uri';

    // Create a TwitterLogin instance
    final twitterLogin = TwitterLogin(
      apiKey: apiKeyTwitter,
      apiSecretKey: apiSecretkeyTwitter,
      redirectURI: redirectURI,
    );

    // Trigger the sign-in flow
    final authResult = await twitterLogin.login();

    // Create a credential from the access token
    final twitterAuthCredential = TwitterAuthProvider.credential(
      accessToken: authResult.authToken!,
      secret: authResult.authTokenSecret!,
    );

    // Once signed in, return the UserCredential
    await FirebaseAuth.instance.signInWithCredential(twitterAuthCredential);
    return "Successfully loged!";
  }
}
