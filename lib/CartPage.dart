import 'dart:convert';
import 'package:boutique/ProductPage.dart';
import 'package:boutique/ShowDetailsOfProduct.dart';
import 'package:boutique/api.dart';
import 'package:boutique/models/get_Product_info.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'bottom_nav_bar_for_users.dart';
import 'models/get_Cart_info.dart';

class CartPage extends StatefulWidget {
  final int userid;
  const CartPage({Key? key, required this.userid}) : super(key: key);

  @override
  _CartPageState createState() => _CartPageState();
}

class _CartPageState extends State<CartPage> {
  var allCart = <CartInfo>[];

  @override
  void initState() {
    _getCart();
    super.initState();
  }

  _getCart() async {
    var data = {
      'user_id': widget.userid.toString(), // Access the 'userid' from the widget
    };
    await CallApi().postDataforgettingcarts(data, "cart").then((response) {
      setState(() {
        Iterable list = json.decode(response.body);
        allCart = list.map((model) => CartInfo.fromJson(model)).toList();
      });
    });
  }
  _orderall(BuildContext context) async {


      var data = {
        'user_id': widget.userid.toString(), // Access the 'userid' from the widget
      };



      var res = await CallApi().postDataforcart(data, 'addOrder');

      // TODO: Handle the response from the API if needed



  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Cart Page'),
        backgroundColor: Colors.white,
      ),
      body: ListView.builder(
        itemCount: allCart.length,
        itemBuilder: (context, index) {
          return Card(
            elevation: 2,
            margin: EdgeInsets.symmetric(horizontal: 10, vertical: 5),
            child: ListTile(
              leading: Image.network(
                  "https://pageofcode99.000webhostapp.com/public/" +
                      allCart[index].image),
              title: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    allCart[index].productName,
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 16,
                    ),
                  ),
                  SizedBox(height: 5),
                  Text('Price: ${allCart[index].price}'),
                  Text('Quantity: ${allCart[index].quantity}'),
                  Text('User ID: ${allCart[index].userId}'),
                ],
              ),
              trailing: ElevatedButton(
                onPressed: () async {
                  var data = {
                    'id': allCart[index].id.toString(),
                  };
                  var res = await CallApi().postData(data, 'removecart');

                  var product = allCart[index];

                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => ProductPage(),
                    ),
                  );
                 
                },
                child: Text('Delete'),
              ),
            ),
          );
        },
      ),
      floatingActionButton: ElevatedButton(
        onPressed: () {
          _orderall(context);
        },
        child: Text('Order All'),
      ),
      bottomNavigationBar: BottomNavBar(),

    );
  }
}
