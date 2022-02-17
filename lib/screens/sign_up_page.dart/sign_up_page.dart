import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:provider/provider.dart';
import 'package:sign_up_page/auth_wrapper.dart';
import '../../service/sign_in_up_Service.dart';
import '../sign_in_page/sign_in_page.dart';

class SignUpPage extends StatelessWidget {
  SignUpPage({Key? key}) : super(key: key);
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _usernameController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [
            SizedBox(
              height: MediaQuery.of(context).size.height * 0.15,
              child: Container(
                height: double.infinity,
                width: double.infinity,
                padding: const EdgeInsets.symmetric(horizontal: 20),
                decoration: const BoxDecoration(
                  color: Color(0xff39A9CB),
                  borderRadius: BorderRadius.only(
                    bottomRight: Radius.circular(50),
                  ),
                ),
                alignment: const Alignment(0, 0.3),
                child: Row(
                  children: [
                    CircleAvatar(
                      radius: 25,
                      backgroundColor: Colors.yellowAccent,
                      child: IconButton(
                        onPressed: () => Navigator.pop(context),
                        icon: const Icon(
                          Icons.arrow_back,
                          color: Colors.black,
                        ),
                      ),
                    ),
                    const SizedBox(
                      width: 30,
                    ),
                    const Text(
                      "Create Account",
                      style: TextStyle(color: Colors.white, fontSize: 25),
                    )
                  ],
                ),
              ),
            ),
            Container(
              color: const Color(0xff39A9CB),
              height: MediaQuery.of(context).size.height * 0.85,
              child: Container(
                padding:
                    const EdgeInsets.symmetric(horizontal: 20, vertical: 15),
                height: double.infinity,
                width: double.infinity,
                decoration: const BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(50),
                  ),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    SizedBox(
                      height: MediaQuery.of(context).size.height * 0.2,
                      child: Image.asset(
                        "assets/images/sign_up.png",
                        fit: BoxFit.cover,
                      ),
                    ),
                    TextFormField(
                      controller: _usernameController,
                      decoration: const InputDecoration(
                        labelText: "Username",
                      ),
                    ),
                    TextFormField(
                      controller: _emailController,
                      decoration: const InputDecoration(
                        labelText: "Email",
                      ),
                    ),
                    TextFormField(
                      controller: _passwordController,
                      decoration: const InputDecoration(
                        labelText: "Password",
                      ),
                    ),
                    SizedBox(
                      height: MediaQuery.of(context).size.height * 0.07,
                      child: ElevatedButton(
                        onPressed: () {
                          context
                              .read<SignInUpService>()
                              .singUP(
                                email: _emailController.text,
                                password: _passwordController.text,
                                name: _usernameController.text,
                              )
                              .then(
                                (value) => value == 'sign up'
                                    ? Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                          builder: (_) => const AuthWrapper(),
                                        ),
                                      )
                                    : ScaffoldMessenger.of(context)
                                        .showSnackBar(
                                        SnackBar(
                                          content: Text(
                                            value.toString(),
                                          ),
                                        ),
                                      ),
                              );
                        },
                        child: const Text(
                          "Sign Up",
                          style: TextStyle(color: Colors.black),
                        ),
                        style: ElevatedButton.styleFrom(
                            primary: const Color(0xffFFE227),
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(20))),
                      ),
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        InkWell(
                          onTap: () {
                            context
                                .read<SignInUpService>()
                                .signInWithFacebook()
                                .then((value) => value == 'Successfully loged!'
                                    ? Navigator.pushReplacement(
                                        context,
                                        MaterialPageRoute(
                                          builder: (_) => const AuthWrapper(),
                                        ),
                                      )
                                    : ScaffoldMessenger.of(context)
                                        .showSnackBar(
                                        SnackBar(
                                          content: Text(
                                            value.toString(),
                                          ),
                                        ),
                                      ));
                          },
                          child: const CircleAvatar(
                            backgroundColor: Colors.black,
                            child: FaIcon(
                              FontAwesomeIcons.facebook,
                              color: Colors.white,
                            ),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 20),
                          child: InkWell(
                            onTap: () {},
                            child: const CircleAvatar(
                              backgroundColor: Colors.black,
                              child: FaIcon(
                                FontAwesomeIcons.twitter,
                                color: Colors.white,
                              ),
                            ),
                          ),
                        ),
                        InkWell(
                          onTap: () {
                            context
                                .read<SignInUpService>()
                                .signInWithGitHub(context)
                                .then((value) => value == 'Successfully loged!'
                                    ? Navigator.pushReplacement(
                                        context,
                                        MaterialPageRoute(
                                          builder: (_) => const AuthWrapper(),
                                        ),
                                      )
                                    : ScaffoldMessenger.of(context)
                                        .showSnackBar(
                                        SnackBar(
                                          content: Text(
                                            value.toString(),
                                          ),
                                        ),
                                      ));
                          },
                          child: const CircleAvatar(
                            backgroundColor: Colors.black,
                            child: FaIcon(
                              FontAwesomeIcons.github,
                              color: Colors.white,
                            ),
                          ),
                        ),
                      ],
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const Text("Joined us before? "),
                        TextButton(
                          onPressed: () => Navigator.pushAndRemoveUntil(
                            context,
                            MaterialPageRoute(
                              builder: (_) => SignInPage(),
                            ),
                            (route) => false,
                          ),
                          child: const Text("SIGN IN"),
                        ),
                      ],
                    )
                  ],
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
