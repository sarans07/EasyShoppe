import 'package:e_commerce/pages/Cart_page.dart';
import 'package:e_commerce/pages/Home_page.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../model/cart_model.dart';

class BottomNavigation extends StatefulWidget {
  const BottomNavigation({Key? key}) : super(key: key);

  @override
  State<BottomNavigation> createState() => _BottomNavigationState();
}

class _BottomNavigationState extends State<BottomNavigation> {
  int _selectedIndex = 0;

  List pages = [
    HomePage(),
    CartPage(),
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: pages[_selectedIndex],
      bottomNavigationBar: BottomNavigationBar(
        unselectedItemColor: Colors.grey,
        backgroundColor: Colors.white,
        currentIndex: _selectedIndex,
        onTap: _onItemTapped,
        items: [
          BottomNavigationBarItem(
            icon: Icon(Icons.home_filled),
            label: "Home",
          ),
          BottomNavigationBarItem(
            icon: Stack(
              children: [
                Icon(
                  Icons.shopping_cart_outlined,
                  size: 30,
                ),
                Positioned(
                  top: -6,
                  right: 0,
                  child: Container(
                    padding: EdgeInsets.all(4.0),
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: Colors.red,
                    ),
                    child: Consumer<CartModel>(
                      builder: (context, cart, child) {
                        return Text(
                          cart.cartItems.length.toString(),
                          style: TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                          ),
                        );
                      },
                    ),
                  ),
                ),
              ],
            ),
            label: "Cart",
          ),
        ],
      ),
    );
  }
}
