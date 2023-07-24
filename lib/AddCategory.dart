import 'dart:convert';

import 'package:boutique/Categories.dart';
import 'package:boutique/ProductPage.dart';
import 'package:boutique/api.dart';
import 'package:boutique/bottom_nav_bar.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AddCategoryPage extends StatefulWidget {
  const AddCategoryPage({super.key});

  @override
  State<AddCategoryPage> createState() => _AddCategoryPageState();
}

class _AddCategoryPageState extends State<AddCategoryPage> {
  TextEditingController title = TextEditingController();

  _register() async {
    var data = {
      'title': title.text,
    };

    var res = await CallApi().postData(data, 'addCategory');
    print(res);


      Navigator.push(
          context, MaterialPageRoute(builder: (context) => CategoriePage()));


/////
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('add Category'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            TextFormField(
              controller: title,
              decoration: const InputDecoration(
                labelText: 'title',
              ),
            ),

            ElevatedButton(
              onPressed: () {
                _register();
              },
              child: const Text('Add Category'),
            ),
          ],
        ),
      ),
      bottomNavigationBar: BottomNavBar(),
    );
  }
}
