import 'dart:convert';

import 'package:boutique/ProductPage.dart';
import 'package:boutique/api.dart';
import 'package:boutique/register.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SignInPage extends StatefulWidget {
  const SignInPage({super.key});

  @override
  State<SignInPage> createState() => _SignInPageState();
}

class _SignInPageState extends State<SignInPage> {
  TextEditingController usernameController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  _register() async {
    var data = {
      'email': usernameController.text,
      'password': passwordController.text,
    };

    var res = await CallApi().postData(data, 'auth/token');
    print(res);

    if (res['success']) {
      SharedPreferences localStorage = await SharedPreferences.getInstance();
      localStorage.setString('token', res['token']);
      localStorage.setString('user', json.encode(res['user']));
      Navigator.push(
          context, MaterialPageRoute(builder: (context) => ProductPage()));
    }

    //////
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Sign In'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            TextFormField(
              controller: usernameController,
              decoration: const InputDecoration(
                labelText: 'Username',
              ),
            ),
            TextFormField(
              controller: passwordController,
              decoration: const InputDecoration(
                labelText: 'Password',
              ),
              obscureText: true,
            ),
            ElevatedButton(
              onPressed: () {
                _register();
              },
              child: const Text('Sign In'),
            ),
            const SizedBox(height: 10), // Add some spacing
            TextButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => RegisterPage(),
                  ),
                );              },
              style: TextButton.styleFrom(
                primary: Colors.white,
                backgroundColor: Colors.blue, // Change the background color as desired
                padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 15),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(30),
                ),
              ),
              child: const Text(
                'Register',
                style: TextStyle(fontSize: 16),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
