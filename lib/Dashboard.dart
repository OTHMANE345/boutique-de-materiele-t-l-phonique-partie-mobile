import 'dart:convert';

import 'package:boutique/ShowDetailsOfProduct.dart';
import 'package:boutique/api.dart';
import 'package:boutique/bottom_nav_bar.dart';
import 'package:boutique/models/get_Product_info.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class DashboardPage extends StatefulWidget {
  const DashboardPage({super.key});

  @override
  _DashboardPageState createState() => _DashboardPageState();
}

class _DashboardPageState extends State<DashboardPage> {
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

/*if(user!=null){
      var userInfo=jsonDecode(user);
      debugPrint(userInfo);
    }else{
      debugPrint("no info");
    }*/

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
        title: Text('Products Page'),
        backgroundColor: Colors.black,
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
                    text: "${allproducts[index].name} - ${allproducts[index].price}"+"\DH",
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
                  onPressed: () async {
//showdetails
                    var data = {
                      'id': allproducts[index].id.toString(),

                    };
                    var res = await CallApi().postData(data, 'removeproduct');

                    // Get the product information from the list of products.
                    var product = allproducts[index];

                    // Pass the product information to the showDetailsOfProduct page.

                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => DashboardPage(),
                      ),
                    );


                  },
                  child: Text("delete"),
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
// Add a button to each product to view more information
    );
  }
}
