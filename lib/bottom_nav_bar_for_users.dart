import 'package:boutique/AddCategory.dart';
import 'package:boutique/AddProduct.dart';
import 'package:boutique/Categories.dart';
import 'package:boutique/Dashboard.dart';
import 'package:boutique/OrdersPage.dart';
import 'package:boutique/ProductPage.dart';
import 'package:boutique/api.dart';
import 'package:boutique/homepagefortheboutique.dart';
import 'package:boutique/singin.dart';
import 'package:boutique/singinadmin.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class BottomNavBar extends StatefulWidget {
  const BottomNavBar({Key? key}) : super(key: key);

  @override
  State<BottomNavBar> createState() => _BottomNavBarState();
}

class _BottomNavBarState extends State<BottomNavBar> {
  int _selectedIndex = 0;

  Future<void> _onItemTapped(int index) async {
    setState(() {
      _selectedIndex = index;
    });


    if (index == 0) {

      // Go to the Dashboard page.
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => ProductPage()),
      );
    }
    if (index == 1) {
      var res = await CallApi().getPublicData('logout');

      // Go to the Dashboard page.

        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => LoginPage()),
        );

    }

  }

  @override
  Widget build(BuildContext context) {
    return BottomNavigationBar(
      items: const [

        BottomNavigationBarItem(
          icon: FaIcon(FontAwesomeIcons.shoppingBag),
          label: 'Products',
          backgroundColor: Colors.yellow,
        ),
        BottomNavigationBarItem(
          icon: FaIcon(FontAwesomeIcons.home),
          label: 'Logout',
          backgroundColor: Colors.red,
        ),

      ],
      currentIndex: _selectedIndex,
      onTap: _onItemTapped,
    );
  }
}
