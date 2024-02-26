import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

import '../components/dialogbox_tile.dart';
import '../components/items_tile.dart';
import '../model/cart_model.dart';
import 'Cart_page.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  bool isFavorite = false;
  late int cartItemCount;

  void _showItemDetailsDialog(BuildContext context, int index) {
    CartModel cartModel = Provider.of<CartModel>(context, listen: false);
    int selectedQuantity = 1;

    final List<String> items = [
      cartModel.shopItems[index][2],
      cartModel.shopItems[index][3],
      cartModel.shopItems[index][4],
    ];

    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Padding(
                padding: const EdgeInsets.all(6.0),
                child: Text(
                  'Item Details',
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              GestureDetector(
                onTap: () {
                  Navigator.of(context).pop();
                },
                child: Container(
                  decoration:
                      BoxDecoration(shape: BoxShape.circle, color: Colors.grey),
                  child: Icon(
                    Icons.close,
                    size: 30,
                  ),
                ),
              )
            ],
          ),
          content: Container(
            height: MediaQuery.of(context).size.height * 0.55,
            width: MediaQuery.of(context).size.width * 0.8,
            child: Column(
              children: [
                Stack(
                  children: [
                    ItemDetailsDialog(items: items),
                    Positioned(
                      top: 10,
                      right: 10,
                      child: GestureDetector(
                        onTap: () {
                          setState(() {
                            isFavorite = !isFavorite;
                          });
                        },
                        child: Icon(
                          Icons.favorite,
                          color: isFavorite ? Colors.red : Colors.grey[300],
                          size: 35,
                        ),
                      ),
                    ),
                  ],
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 3.0),
                  child: Text(
                    cartModel.shopItems[index][0],
                    style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                        color: Colors.black87),
                  ),
                ),
                Text(
                  '₹ ${cartModel.shopItems[index][1]}',
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 30),
                ),
                SizedBox(
                  height: 10,
                ),
                MaterialButton(
                  minWidth: double.infinity,
                  height: 50,
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.all(Radius.circular(20.0))),
                  onPressed: () {
                    Provider.of<CartModel>(context, listen: false)
                        .addItemToCartDetails(index, selectedQuantity);
                    Navigator.of(context).pop();
                  },
                  color: Colors.orange,
                  child: Text(
                    'Add to Cart',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 25,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                )
              ],
            ),
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    cartItemCount = Provider.of<CartModel>(context).cartItems.length;

    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Container(
            height: MediaQuery.of(context).size.height * 1,
            width: MediaQuery.of(context).size.width * 1,
            decoration: BoxDecoration(color: Colors.grey[200]),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  height: MediaQuery.of(context).size.height * 0.1,
                  width: MediaQuery.of(context).size.width * 1,
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      colors: [Colors.blue, Colors.greenAccent],
                      begin: Alignment.topLeft,
                      end: Alignment.topRight,
                    ),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.only(left: 10.0),
                    child: Row(
                      children: [
                        Expanded(
                          child: TextField(
                            decoration: InputDecoration(
                              prefixIcon: Container(
                                padding: EdgeInsets.all(8.0),
                                child: CircleAvatar(
                                  backgroundColor: Colors.white,
                                  child: Icon(Icons.search, color: Colors.blue),
                                ),
                              ),
                              suffixIcon:
                                  Icon(Icons.more_vert, color: Colors.white),
                              hintText: 'Search...',
                              hintStyle: TextStyle(color: Colors.white),
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(30.0),
                                borderSide: BorderSide.none,
                              ),
                              filled: true,
                              fillColor: Colors.white.withOpacity(0.3),
                            ),
                            style: TextStyle(color: Colors.white),
                          ),
                        ),
                        SizedBox(width: 16.0),
                        Stack(
                          children: [
                            InkWell(
                              onTap: () => Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) {
                                    return CartPage();
                                  },
                                ),
                              ),
                              child: Icon(
                                Icons.shopping_cart,
                                color: Colors.white,
                                size: 30,
                              ),
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
                                child: Text(
                                  cartItemCount.toString(),
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                        SizedBox(
                          width: 5,
                        )
                      ],
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(12.0),
                  child: Text(
                    "Top Deals",
                    style: GoogleFonts.notoSerif(
                      fontWeight: FontWeight.bold,
                      fontSize: 28,
                    ),
                  ),
                ),
                Expanded(
                  child: Consumer<CartModel>(
                    builder: (context, value, child) {
                      return GridView.builder(
                        padding: const EdgeInsets.all(12),
                        //physics: const NeverScrollableScrollPhysics(),
                        itemCount: value.shopItems.length,
                        gridDelegate:
                            const SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 2,
                          childAspectRatio: 1 / 1.6,
                        ),
                        itemBuilder: (context, index) {
                          return GestureDetector(
                            onTap: () => _showItemDetailsDialog(context, index),
                            child: ItemTile(
                              itemName: value.shopItems[index][0],
                              itemPrice: value.shopItems[index][1],
                              image: value.shopItems[index][2],
                              image1: value.shopItems[index][3],
                              image2: value.shopItems[index][4],
                              itemDiscount: value.shopItems[index][5],
                              onPressed: () =>
                                  Provider.of<CartModel>(context, listen: false)
                                      .addItemToCart(index),
                              onTap: () {},
                            ),
                          );
                        },
                      );
                    },
                  ),
                ),
                SizedBox(height: 100,)
              ],
            ),
          ),
        ),
      ),
    );
  }
}
