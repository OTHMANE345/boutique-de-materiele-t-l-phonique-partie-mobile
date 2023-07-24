import 'dart:convert';

import 'package:boutique/ShowDetailsOfProduct.dart';
import 'package:boutique/api.dart';
import 'package:boutique/bottom_nav_bar.dart'; // You should import the correct path for your BottomNavBar
import 'package:boutique/models/get_Product_info.dart';
import 'package:boutique/models/get_categries_info.dart';
import 'package:boutique/models/get_orders_info.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';

import 'package:shared_preferences/shared_preferences.dart';

class CategoriePage extends StatefulWidget {
  const CategoriePage({super.key});

  @override
  _CategoriePageState createState() => _CategoriePageState();
}

class _CategoriePageState extends State<CategoriePage> {
  var allcategories = <CategoryInfo>[];
  int _page = 1;
  int _totalPages = 1;
  bool _isLoading = false;

  @override
  void initState() {
    _geCategories();
    super.initState();
  }

  _geCategories() async {
    await CallApi().getPublicData("ShowAllcategories").then((response) {
      setState(() {
        Iterable list = json.decode(response.body);
        allcategories = list.map((model) => CategoryInfo.fromJson(model)).toList();
        _totalPages = allcategories.length ~/ 20 + 1;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Categories Page'),
        backgroundColor: Colors.black,
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [
            Expanded(
              child: ListView.builder(
                itemCount: allcategories.length,
                itemBuilder: (context, index) {
                  if (index < (_page - 1) * 20 || index >= _page * 20) {
                    return Container();
                  }
                  return Card(
                    elevation: 3,
                    child: ListTile(
                      title: Text(
                        "${allcategories[index].title} ",
                        style: TextStyle(
                          fontSize: 18.0,
                          color: Colors.black,
                          fontWeight: FontWeight.bold,
                        ),
                      ),

                      trailing: ElevatedButton.icon(
                        onPressed: () async {
                          var data = {
                            'id': allcategories[index].id.toString(),
                          };
                          var res = await CallApi().postData(data, 'removeCategory');
                          // After deletion, you may want to update the UI to reflect the changes.
                          _geCategories();
                        },
                        icon: Icon(Icons.delete),
                        label: Text("Delete"),
                        style: ElevatedButton.styleFrom(
                          primary: Colors.deepOrangeAccent,
                        ),
                      ),
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
      bottomNavigationBar: BottomNavBar(), // Replace with your BottomNavBar widget
    );
  }
}
