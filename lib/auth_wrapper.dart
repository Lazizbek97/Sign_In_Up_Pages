import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sign_up_page/screens/home_page.dart/home_page.dart';
import 'package:sign_up_page/screens/sign_in_page/sign_in_page.dart';
import 'package:sign_up_page/service/sign_in_up_Service.dart';

class AuthWrapper extends StatelessWidget {
  const AuthWrapper({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final fireBaseUser = context.watch<SignInUpService>();
    print(fireBaseUser.fireBaseAuth.currentUser);
    if (fireBaseUser.fireBaseAuth.currentUser != null) {
      return const HomePage();
    } else {
      return SignInPage();
    }
  }
}
