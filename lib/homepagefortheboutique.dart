import 'package:boutique/singin.dart';
import 'package:boutique/singinadmin.dart';
import 'package:flutter/material.dart';

class LoginPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Login'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // User button
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                primary: Colors.blue, // Set your desired color
              ),
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => SignInPage()),
                );
              },
              child: Text('Sign in as User'),
            ),
            SizedBox(height: 16), // Add some spacing between buttons
            // Admin button
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                primary: Colors.red, // Set your desired color
              ),
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => SignInAdminPage()),
                );
              },
              child: Text('Sign in as Admin'),
            ),
          ],
        ),
      ),
    );
  }
}
