import 'dart:convert';

import 'package:boutique/Dashboard.dart';
import 'package:boutique/ProductPage.dart';
import 'package:boutique/api.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SignInAdminPage extends StatefulWidget {
  const SignInAdminPage({Key? key}) : super(key: key);

  @override
  State<SignInAdminPage> createState() => _SignInAdminPageState();
}

class _SignInAdminPageState extends State<SignInAdminPage> {
  TextEditingController usernameController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  _register() async {
    var data = {
      'email': usernameController.text,
      'password': passwordController.text,
    };

    var res = await CallApi().postData(data, 'auth/admin/token');
    print(res);

    SharedPreferences localStorage = await SharedPreferences.getInstance();
    localStorage.setString('token', res['token']);
    Navigator.push(
        context, MaterialPageRoute(builder: (context) => DashboardPage()));


  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Sign In for Admin'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            // Wrap the Image widget with Expanded
            Expanded(
              child: Image.asset('images/pexels-adam-dubec-1595483.jpg'),
            ),
            SizedBox(height: 20),
            // Form for email and password
            Form(
              child: Column(
                children: <Widget>[
                  TextFormField(
                    controller: usernameController,
                    decoration: InputDecoration(
                      labelText: 'Email',
                    ),
                  ),
                  TextFormField(
                    controller: passwordController,
                    decoration: InputDecoration(
                      labelText: 'Password',
                    ),
                    obscureText: true,
                  ),
                ],
              ),
            ),
            SizedBox(height: 20),
            // Button to sign in
            ElevatedButton(
              onPressed: _register,
              child: Text('Sign In'),
            ),
          ],
        ),
      ),
    );
  }
}
