import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:boutique/CartPage.dart';
import 'package:boutique/api.dart';
import 'package:boutique/models/get_Product_info.dart';

import 'bottom_nav_bar_for_users.dart';

class ShowDetailsOfProduct extends StatelessWidget {
  final ProductInfo product;

  ShowDetailsOfProduct({Key? key, required this.product}) : super(key: key);

  TextEditingController quantityController = TextEditingController();

  _addToCart(BuildContext context) async {
    // Check if the quantity is a valid positive integer
    if (int.tryParse(quantityController.text) != null) {
      int quantity = int.parse(quantityController.text);
      SharedPreferences localStorage = await SharedPreferences.getInstance();
      var userString = localStorage.getString('user');
      final user = json.decode(userString!);

      var data = {
        'product_id': product.id.toString(),
        'product_name': product.name.toString(),
        'price': product.price,
        'quantity': quantity.toString(),
        'image': product.image.toString(),
        'user_id': user['id'].toString(), // Access the 'id' property of the user object
      };

      var res = await CallApi().postDataforcart(data, 'addProductToCart');

      // TODO: Handle the response from the API if needed
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Show Details Of Product',
          style: TextStyle(color: Colors.black),
        ),
        backgroundColor: Colors.amber,
        centerTitle: true,
        elevation: 0,
      ),
      body: Container(
        color: Colors.white, // Add a background color
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Hero(
                tag: 'productImage${product.id}',
                child: Container(
                  height: 300,
                  width: double.infinity,
                  decoration: BoxDecoration(
                    image: DecorationImage(
                      image: NetworkImage(
                          "https://pageofcode99.000webhostapp.com/public/" +
                              product.image),
                      fit: BoxFit.cover,
                    ),
                    borderRadius: BorderRadius.only(
                      bottomLeft: Radius.circular(30.0),
                      bottomRight: Radius.circular(30.0),
                    ),
                  ),
                ),
              ),
              SizedBox(height: 24.0),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16.0),
                child: Text(
                  product.name,
                  style: TextStyle(
                    fontSize: 32.0,
                    fontWeight: FontWeight.bold,
                    color: Colors.black,
                  ),
                ),
              ),
              SizedBox(height: 8.0),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16.0),
                child: Text(
                  "Price: \DH ${product.price}",
                  style: TextStyle(fontSize: 24.0, color: Colors.grey),
                ),
              ),
              SizedBox(height: 24.0),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16.0),
                child: Text(
                  "Description:",
                  style: TextStyle(
                    fontSize: 26.0,
                    fontWeight: FontWeight.bold,
                    color: Colors.black,
                  ),
                ),
              ),
              SizedBox(height: 8.0),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16.0),
                child: Text(
                  product.description,
                  style: TextStyle(fontSize: 20.0),
                ),
              ),
              TextFormField(
                controller: quantityController,
                decoration: const InputDecoration(
                  labelText: 'Quantity',
                ),
                keyboardType: TextInputType.number,
              ),
              SizedBox(height: 40.0),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    ElevatedButton.icon(
                      onPressed: () => _addToCart(context),
                      icon: Icon(Icons.shopping_cart),
                      label: Text("Add to Cart"),
                    ),
                    ElevatedButton.icon(
                      onPressed: () async {
                        SharedPreferences localStorage =
                        await SharedPreferences.getInstance();
                        var userString = localStorage.getString('user');
                        final user = json.decode(userString!);
                        // Navigates to CartPage
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => CartPage(userid: user['id']),
                          ),
                        );
                      },
                      icon: Icon(Icons.shopping_cart),
                      label: Text("View Cart"),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
      bottomNavigationBar: BottomNavBar(),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
    );
  }
}
