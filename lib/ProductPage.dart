import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'ShowDetailsOfProduct.dart';
import 'api.dart';
import 'models/get_Product_info.dart';
import 'bottom_nav_bar_for_users.dart';

class ProductPage extends StatefulWidget {
  const ProductPage({super.key});

  @override
  _ProductPageState createState() => _ProductPageState();
}

class _ProductPageState extends State<ProductPage> {
  var allproducts = <ProductInfo>[];
  int _page = 1;
  int _totalPages = 1;
  bool _isLoading = false;

  @override
  void initState() {
    _getProducts();
    super.initState();
  }

  _getProducts() async {
    SharedPreferences localStorage = await SharedPreferences.getInstance();
    var user = localStorage.getString("user");

    await CallApi().getPublicData("ShowAllProducts").then((response) {
      setState(() {
        Iterable list = json.decode(response.body);
        allproducts = list.map((model) => ProductInfo.fromJson(model)).toList();
        _totalPages = allproducts.length ~/ 20 + 1;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Product Page'),
        backgroundColor: Colors.blue,
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: ListView.builder(
          itemCount: allproducts.length,
          itemBuilder: (context, index) {
            if (index < (_page - 1) * 20 || index >= _page * 20) {
              return Container();
            }
            return Card(
              child: ListTile(
                leading: Image.network(
                  "https://pageofcode99.000webhostapp.com/public/" +
                      allproducts[index].image,
                  width: 100,
                  height: 100,
                  fit: BoxFit.cover,
                ),
                title: RichText(
                  text: TextSpan(
                    text: "${allproducts[index].name} - ${allproducts[index].price}" + "\DH",
                    style: TextStyle(
                      fontSize: 16.0,
                      color: Colors.black,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                subtitle: RichText(
                  text: TextSpan(
                    text: allproducts[index].description,
                    style: TextStyle(
                      fontSize: 14.0,
                      color: Colors.grey,
                    ),
                  ),
                ),
                trailing: ElevatedButton(
                  onPressed: () {
                    // Show details of the product.
                    var product = allproducts[index];

                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => ShowDetailsOfProduct(product: product),
                      ),
                    );
                  },
                  child: Text("View More"),
                  style: ElevatedButton.styleFrom(
                    primary: Colors.deepOrangeAccent,
                  ),
                ),
              ),
            );
          },
        ),
      ),
      bottomNavigationBar: BottomNavBar(),
    );
  }
}
