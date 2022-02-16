import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sign_up_page/service/sign_in_up_Service.dart';

class HomePage extends StatelessWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        foregroundColor: Colors.black,
        backgroundColor: Colors.transparent,
        elevation: 0,
        centerTitle: true,
        title: const Text("Welcome"),
        actions: [
          IconButton(
              onPressed: () {
                context.read<SignInUpService>().signOut();
              },
              icon: const Icon(Icons.logout))
        ],
      ),
      body: const Center(
        child: Text("Home Page"),
      ),
    );
  }
}
