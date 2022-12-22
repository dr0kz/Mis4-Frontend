import 'package:exercise/components/login.dart';
import 'package:exercise/service/auth-service.dart';
import 'package:flutter/material.dart';
import 'package:localstorage/localstorage.dart';

import '../consts/constant.dart';

class Register extends StatefulWidget {
  const Register({super.key});

  @override
  State<StatefulWidget> createState() {
    return RegisterState();
  }
}

class RegisterState extends State<Register> {
  final AuthService authService = AuthService();
  final LocalStorage storage = LocalStorage(Constant.localStorageKey);

  final name = TextEditingController();
  final surname = TextEditingController();
  final email = TextEditingController();
  final password = TextEditingController();

  void register() {
    if (name.text.isNotEmpty &&
        surname.text.isNotEmpty &&
        email.text.isNotEmpty &&
        password.text.isNotEmpty) {
      authService
          .register(name.text, surname.text, email.text, password.text)
          .then((value) => Navigator.of(context).push(
                MaterialPageRoute(builder: (context) => const Login()),
              ))
          .onError((error, stackTrace) => print('ERROR: $error'));
    } else {
      print('Name or Surname or Email or Password field is empty!');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(title: const Text('Register')),
        body: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 16),
              child: TextFormField(
                controller: name,
                decoration: const InputDecoration(
                  border: UnderlineInputBorder(),
                  labelText: 'Name',
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 16),
              child: TextFormField(
                controller: surname,
                decoration: const InputDecoration(
                  border: UnderlineInputBorder(),
                  labelText: 'Surname',
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 16),
              child: TextFormField(
                controller: email,
                decoration: const InputDecoration(
                  border: UnderlineInputBorder(),
                  labelText: 'Email',
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 16),
              child: TextFormField(
                controller: password,
                decoration: const InputDecoration(
                  border: UnderlineInputBorder(),
                  labelText: 'Password',
                ),
              ),
            ),
            SizedBox(
                width: 120, // <-- match_parent
                height: 35, // <-- match-parent
                child: ElevatedButton(
                  onPressed: () => register(),
                  child: const Text(
                    "Register",
                    style: TextStyle(fontSize: 20),
                  ),
                )),
            Padding(
              padding: const EdgeInsets.only(top: 10.0),
              child: TextButton(
                  onPressed: () {
                    Navigator.of(context).push(
                      MaterialPageRoute(builder: (context) => const Login()),
                    );
                  },
                  child: const Text('You already have an account?')),
            )
          ],
        ));
  }
}
