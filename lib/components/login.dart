import 'dart:convert';

import 'package:exercise/components/register.dart';
import 'package:exercise/service/auth-service.dart';
import 'package:flutter/material.dart';
import 'package:localstorage/localstorage.dart';

import '../consts/constant.dart';
import 'main.dart';

class Login extends StatefulWidget {
  const Login({super.key});

  @override
  State<StatefulWidget> createState() {
    return LoginState();
  }
}

class LoginState extends State<Login> {
  final AuthService authService = AuthService();
  final LocalStorage storage = LocalStorage(Constant.localStorageKey);
  final email = TextEditingController();
  final password = TextEditingController();

  void login() {
    if (email.text.isNotEmpty && password.text.isNotEmpty) {
      authService
          .login(email.text, password.text)
          .then((value) => storage.setItem('token', json.decode(value.body)['jwt'])
      .then((value) {
        return Navigator.of(context).push(
          MaterialPageRoute(
              builder: (context) => const MyApp()),
        );
      }))
          .onError((error, stackTrace) => print('ERROR: $error'));
    } else {
      print('Email or Password field is empty!');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(title: const Text('Login')),
        body: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
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
                  onPressed: () => login(),
                  child: const Text(
                    "Login",
                    style: TextStyle(fontSize: 20),
                  ),
                )),
            Padding(
              padding: const EdgeInsets.only(top: 10.0),
              child: TextButton(
                  onPressed: () {
                    Navigator.of(context).push(
                      MaterialPageRoute(
                          builder: (context) => const Register()),
                    );
                  },
                  child: const Text('You don\'t have an account?')),
            )
          ],
        ));
  }
}
