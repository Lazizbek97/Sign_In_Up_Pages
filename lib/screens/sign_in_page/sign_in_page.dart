import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:sign_up_page/screens/sign_up_page.dart/sign_up_page.dart';
import 'package:provider/provider.dart';
import 'package:sign_up_page/service/sign_in_up_Service.dart';

class SignInPage extends StatelessWidget {
  SignInPage({Key? key}) : super(key: key);
  bool isChecked = false;
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [
            Container(
              color: Colors.white,
              height: MediaQuery.of(context).size.height * 0.4,
              child: SizedBox(
                child: Container(
                  height: double.infinity,
                  width: double.infinity,
                  decoration: const BoxDecoration(
                    color: Color(0xff39A9CB),
                    borderRadius: BorderRadius.only(
                      bottomRight: Radius.circular(80),
                    ),
                  ),
                  alignment: Alignment.center,
                  child: Padding(
                    padding: const EdgeInsets.fromLTRB(20, 40, 20, 10),
                    child: SizedBox(
                      height: MediaQuery.of(context).size.height * 0.3,
                      child: Column(
                        children: [
                          const CircleAvatar(
                            radius: 80,
                            backgroundColor: Colors.yellow,
                            backgroundImage:
                                AssetImage("assets/images/login.png"),
                          ),
                          SizedBox(
                            height: MediaQuery.of(context).size.height * 0.05,
                          ),
                          const Text(
                            "Welcome Back",
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 33,
                            ),
                          )
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            ),
            SizedBox(
              height: MediaQuery.of(context).size.height * 0.6,
              child: Container(
                decoration: const BoxDecoration(
                  color: Color(0xff39A9CB),
                ),
                child: Container(
                  padding: EdgeInsets.symmetric(
                      horizontal: 20,
                      vertical: MediaQuery.of(context).size.height * 0.05),
                  decoration: const BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(80),
                    ),
                  ),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      TextFormField(
                        controller: _emailController,
                        decoration:
                            const InputDecoration(labelText: "Email address"),
                      ),
                      TextFormField(
                        controller: _passwordController,
                        decoration: const InputDecoration(
                          labelText: "Password",
                        ),
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Row(
                            children: [
                              Checkbox(
                                value: isChecked,
                                onChanged: (v) {},
                              ),
                              const Text("Remember me")
                            ],
                          ),
                          TextButton(
                            onPressed: () {},
                            child: const Text("Forgot Password?"),
                          ),
                        ],
                      ),
                      SizedBox(
                        height: MediaQuery.of(context).size.height * 0.07,
                        child: ElevatedButton(
                          onPressed: () {
                            context
                                .read<SignInUpService>()
                                .signIn(
                                  email: _emailController.text,
                                  password: _passwordController.text,
                                )
                                .then(
                                  (value) => ScaffoldMessenger.of(context)
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
                            "Login In",
                          ),
                          style: ElevatedButton.styleFrom(
                              primary: const Color(0xffFFE227),
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(20))),
                        ),
                      ),
                      Row(
                        children: const [
                          Expanded(
                              child: Divider(
                            color: Colors.grey,
                          )),
                          Padding(
                            padding: EdgeInsets.symmetric(horizontal: 15),
                            child: Text(
                              "OR",
                              style:
                                  TextStyle(fontSize: 17, color: Colors.grey),
                            ),
                          ),
                          Expanded(
                              child: Divider(
                            color: Colors.grey,
                          ))
                        ],
                      ),
                      SizedBox(
                        height: MediaQuery.of(context).size.height * 0.07,
                        child: ElevatedButton.icon(
                          onPressed: () {},
                          icon: const FaIcon(
                            FontAwesomeIcons.google,
                          ),
                          label: const Text("Login In with Google"),
                          style: ElevatedButton.styleFrom(
                              primary: const Color(0xffEB596E),
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(20))),
                        ),
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          const Text("Don't have an account? "),
                          TextButton(
                            onPressed: () => Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (_) => SignUpPage(),
                              ),
                            ),
                            child: const Text("SIGN UP"),
                          ),
                        ],
                      )
                    ],
                  ),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
