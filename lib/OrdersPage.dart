import 'dart:convert';

import 'package:boutique/ShowDetailsOfProduct.dart';
import 'package:boutique/api.dart';
import 'package:boutique/bottom_nav_bar.dart'; // You should import the correct path for your BottomNavBar
import 'package:boutique/models/get_Product_info.dart';
import 'package:boutique/models/get_orders_info.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';

import 'package:shared_preferences/shared_preferences.dart';

class OrderPage extends StatefulWidget {
  const OrderPage({super.key});

  @override
  _OrderPageState createState() => _OrderPageState();
}

class _OrderPageState extends State<OrderPage> {
  var allorders = <OrdersInfo>[];
  int _page = 1;
  int _totalPages = 1;
  bool _isLoading = false;

  @override
  void initState() {
    _geOrders();
    super.initState();
  }

  _geOrders() async {
    await CallApi().getPublicData("ShowAllorders").then((response) {
      setState(() {
        Iterable list = json.decode(response.body);
        allorders = list.map((model) => OrdersInfo.fromJson(model)).toList();
        _totalPages = allorders.length ~/ 20 + 1;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Orders Page'),
        backgroundColor: Colors.black,
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [
            Expanded(
              child: ListView.builder(
                itemCount: allorders.length,
                itemBuilder: (context, index) {
                  if (index < (_page - 1) * 20 || index >= _page * 20) {
                    return Container();
                  }
                  return Card(
                    elevation: 3,
                    child: ListTile(
                      title: Text(
                        "${allorders[index].productName}  ",
                        style: TextStyle(
                          fontSize: 18.0,
                          color: Colors.black,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      subtitle: RichText(
                        text: TextSpan(
                          children: [
                            TextSpan(
                              text: "Price: \DH ${allorders[index].price}  ",
                              style: TextStyle(
                                fontSize: 16.0,
                                color: Colors.grey[600],
                              ),
                            ),
                            TextSpan(
                              text: "User Id: ${allorders[index].userId}  ",
                              style: TextStyle(
                                fontSize: 16.0,
                                color: Colors.grey[600],
                              ),
                            ),
                            TextSpan(
                              text: "Total: ${allorders[index].total} \DH",
                              style: TextStyle(
                                fontSize: 16.0,
                                color: Colors.grey[600],
                              ),
                            ),
                          ],
                        ),
                      ),
                      trailing: ElevatedButton.icon(
                        onPressed: () async {
                          var data = {
                            'id': allorders[index].id.toString(),
                          };
                          var res = await CallApi().postData(data, 'removeOrder');
                          // After deletion, you may want to update the UI to reflect the changes.
                          _geOrders();
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
