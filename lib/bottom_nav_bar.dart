import 'package:boutique/AddCategory.dart';
import 'package:boutique/AddProduct.dart';
import 'package:boutique/Categories.dart';
import 'package:boutique/Dashboard.dart';
import 'package:boutique/OrdersPage.dart';
import 'package:boutique/ProductPage.dart';
import 'package:boutique/api.dart';
import 'package:boutique/homepagefortheboutique.dart';
import 'package:boutique/singin.dart';
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
    if (index == 2) {
      // Go to the Orders page.
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => OrderPage()),
      );
    }
    if (index == 0) {
      var res = await CallApi().getPublicData('logout');

      // Go to the Orders page.
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => LoginPage()),
      );
    }
    if (index == 3) {
      // Go to the Dashboard page.
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => DashboardPage()),
      );
    }
    if (index == 1) {
      // Go to the Add Product page.
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => AddProductPage()),
      );
    }
    if (index == 4) {
      // Go to the Add Category page.
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => AddCategoryPage()),
      );
    }
    if (index == 5) {
      // Go to the Show Category page.
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => CategoriePage()),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return BottomNavigationBar(
      items: const [
        BottomNavigationBarItem(
          icon: FaIcon(FontAwesomeIcons.home),
          label: 'Logout',
          backgroundColor: Colors.red,
        ),
        BottomNavigationBarItem(
          icon: FaIcon(FontAwesomeIcons.plus),
          label: 'Add Product',
          backgroundColor: Colors.green,
        ),
        BottomNavigationBarItem(
          icon: FaIcon(FontAwesomeIcons.shoppingCart),
          label: 'Orders',
          backgroundColor: Colors.blue,
        ),
        BottomNavigationBarItem(
          icon: FaIcon(FontAwesomeIcons.shoppingBag),
          label: 'Products',
          backgroundColor: Colors.yellow,
        ),
        BottomNavigationBarItem(
          icon: FaIcon(FontAwesomeIcons.folderPlus),
          label: 'Add Category',
          backgroundColor: Colors.purple,
        ),
        BottomNavigationBarItem(
          icon: FaIcon(FontAwesomeIcons.list),
          label: 'Show Category',
          backgroundColor: Colors.orange,
        ),
      ],
      currentIndex: _selectedIndex,
      onTap: _onItemTapped,
    );
  }
}
