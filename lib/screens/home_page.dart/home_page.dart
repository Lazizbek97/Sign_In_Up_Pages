import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sign_up_page/service/sign_in_up_Service.dart';

class HomePage extends StatelessWidget {
  HomePage({Key? key}) : super(key: key);

  String defaultName = 'No User Name';

  String defaultImgUrl =
      'https://galaxy.esn.org/sites/default/files/cards/font-awesome_4-7-0_user_1024_0_00aeef_none.png';

  @override
  Widget build(BuildContext context) {
    final fireBaseUser = context.watch<SignInUpService>();
    final user = fireBaseUser.fireBaseAuth.currentUser;
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        foregroundColor: Colors.black,
        backgroundColor: Colors.transparent,
        elevation: 0,
        centerTitle: true,
        title: const Text("Welcome"),
        actions: [
          IconButton(
              onPressed: () {
                context.read<SignInUpService>().signOutUser();
              },
              icon: const Icon(Icons.logout))
        ],
      ),
      body: Center(
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 25, vertical: 15),
          height: MediaQuery.of(context).size.height * 0.4,
          width: MediaQuery.of(context).size.height * 0.4,
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(20),
              border: Border.all(color: Colors.black, width: 1.2)),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              CircleAvatar(
                radius: 70,
                backgroundColor: Colors.white,
                backgroundImage: NetworkImage(user!.photoURL ?? defaultImgUrl),
              ),
              Align(
                alignment: Alignment.centerLeft,
                child: Text(
                  "Name: ${user.displayName ?? defaultName}",
                  style: const TextStyle(
                    fontSize: 18.0,
                  ),
                ),
              ),
              Align(
                alignment: Alignment.centerLeft,
                child: Text(
                  "Email: ${user.email}",
                  style: const TextStyle(
                    fontSize: 18.0,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
