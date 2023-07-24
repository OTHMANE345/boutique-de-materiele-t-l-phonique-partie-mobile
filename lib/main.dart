import 'package:boutique/ShowDetailsOfProduct.dart';
import 'package:boutique/singin.dart';
import 'package:boutique/singinadmin.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'homepagefortheboutique.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'My App',
      home: LoginPage(),

    );
  }
}
