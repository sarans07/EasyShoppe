import 'package:e_commerce/model/cart_model.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:sqflite/sqflite.dart';

import 'bottom.dart';

class CartPage extends StatefulWidget {
  const CartPage({Key? key}) : super(key: key);

  @override
  State<CartPage> createState() => _CartPageState();
}

class _CartPageState extends State<CartPage> {
  late Database _database;
  int quantity = 1;

  @override
  void initState() {
    super.initState();
    _initDatabase();
  }

  Future<void> _initDatabase() async {
    _database = await openDatabase(
      'cart_database.db',
      version: 1,
      onCreate: (db, version) {
        return db.execute(
          '''
          CREATE TABLE IF NOT EXISTS cart_items (
            id INTEGER PRIMARY KEY AUTOINCREMENT,
            name TEXT,
            price TEXT,
            imageUrl TEXT
          )
          ''',
        );
      },
    );
  }

  void incrementQuantity(int index) {
    setState(() {
      quantity++;
      updateTotal();
    });
  }

  void decrementQuantity() {
    if (quantity > 1) {
      setState(() {
        quantity--;
        updateTotal();
      });
    }
  }

  void updateTotal() {
    Provider.of<CartModel>(context, listen: false).updateTotal();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        iconTheme: const IconThemeData(
          color: Colors.grey,
        ),
      ),
      body: SafeArea(
        child: Consumer<CartModel>(
          builder: (context, value, child) {
            return Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 24.0),
                  child: Text(
                    "My Cart",
                    style: GoogleFonts.notoSerif(
                      fontSize: 36,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                SizedBox(height: 10),
                Padding(
                  padding: const EdgeInsets.all(36.0),
                  child: Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(8),
                      gradient: LinearGradient(
                        colors: [Colors.blue, Colors.black],
                        begin: Alignment.topLeft,
                        end: Alignment.topRight,
                      ),
                    ),
                    padding: const EdgeInsets.all(24),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'Total Price',
                              style: TextStyle(color: Colors.green[200]),
                            ),
                            const SizedBox(height: 8),
                            Text(
                              '\$${value.calculateTotal().toStringAsFixed(2)}',
                              style: const TextStyle(
                                fontSize: 18,
                                fontWeight: FontWeight.bold,
                                color: Colors.white,
                              ),
                            ),
                          ],
                        ),
                        Container(
                          decoration: BoxDecoration(
                            border: Border.all(color: Colors.green.shade200),
                            borderRadius: BorderRadius.circular(28),
                          ),
                          padding: const EdgeInsets.all(12),
                          child: Row(
                            children: const [
                              Text(
                                'Pay Now',
                                style: TextStyle(color: Colors.white),
                              ),
                              Icon(
                                Icons.arrow_forward_ios,
                                size: 16,
                                color: Colors.white,
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                SizedBox(height: 10),
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.all(12.0),
                    child: ListView.builder(
                      itemCount: value.cartItems.length,
                      padding: EdgeInsets.all(12),
                      itemBuilder: (context, index) {
                        return Padding(
                          padding: const EdgeInsets.all(12.0),
                          child: Container(
                            decoration: BoxDecoration(
                                color: Colors.grey[200],
                                borderRadius: BorderRadius.circular(8)),
                            child: ListTile(
                              leading: Container(
                                height: 150,
                                width: 60,
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(15),
                                  image: DecorationImage(
                                    image:
                                        NetworkImage(value.cartItems[index][2]),
                                    fit: BoxFit.fill,
                                  ),
                                ),
                              ),
                              title: Text(
                                value.cartItems[index][0],
                                style: const TextStyle(fontSize: 18),
                              ),
                              subtitle: Column(
                                children: [
                                  Align(
                                    alignment: Alignment.topLeft,
                                    child: Text(
                                      '\$' + value.cartItems[index][1],
                                      style: const TextStyle(
                                        fontSize: 12,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                  ),
                                  Row(
                                    children: [
                                      Text(
                                        "Qty:",
                                        style: TextStyle(
                                          fontWeight: FontWeight.bold,
                                          fontSize: 15,
                                        ),
                                      ),
                                      SizedBox(width: 10),
                                      InkWell(
                                        onTap: decrementQuantity,
                                        child: CircleAvatar(
                                          radius: 10,
                                          child: Text("-"),
                                        ),
                                      ),
                                      SizedBox(width: 10),
                                      Text(
                                        '$quantity',
                                        style: TextStyle(fontSize: 14),
                                      ),
                                      SizedBox(width: 10),
                                      InkWell(
                                        onTap: () {
                                          incrementQuantity(index);
                                        },
                                        child: CircleAvatar(
                                          radius: 10,
                                          backgroundColor: Colors.black,
                                          child: Icon(
                                            Icons.add,
                                            color: Colors.white,
                                            size: 12,
                                          ),
                                        ),
                                      ),
                                      SizedBox(width: 10),
                                      MaterialButton(
                                        minWidth: 60,
                                        height: 20,
                                        shape: RoundedRectangleBorder(
                                          borderRadius: BorderRadius.all(
                                            Radius.circular(20.0),
                                          ),
                                        ),
                                        onPressed: () =>
                                            _showDeleteConfirmationDialog(
                                                context, index),
                                        color: Colors.grey[400],
                                        child: Text(
                                          'Delete',
                                          style: TextStyle(
                                            color: Colors.black,
                                            fontSize: 15,
                                          ),
                                        ),
                                      )
                                    ],
                                  ),
                                ],
                              ),
                            ),
                          ),
                        );
                      },
                    ),
                  ),
                ),
                Center(
                  child: MaterialButton(
                    minWidth: 200,
                    height: 50,
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.all(Radius.circular(20.0))),
                    onPressed: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => BottomNavigation()));
                    },
                    color: Colors.yellow[800],
                    child: Text(
                      'See more like this',
                      style: TextStyle(
                        color: Colors.black,
                        fontSize: 15,
                      ),
                    ),
                  ),
                ),
                SizedBox(height: 20),
              ],
            );
          },
        ),
      ),
    );
  }
}

void _showDeleteConfirmationDialog(BuildContext context, int index) {
  showDialog(
    context: context,
    builder: (BuildContext context) {
      return AlertDialog(
        title: Text('Confirm Delete'),
        content: Text('Are you sure you want to delete this item?'),
        actions: [
          TextButton(
            onPressed: () {
              Navigator.of(context).pop(); // Close the dialog
            },
            child: Text('Cancel'),
          ),
          TextButton(
            onPressed: () {
              // Delete the item and close the dialog
              Provider.of<CartModel>(context, listen: false)
                  .removeItemFromCart(index);
              // You may also delete the item from the sqflite database here
              // Example: _database.rawDelete('DELETE FROM cart_items WHERE id = ?', [index]);
              Navigator.of(context).pop();
            },
            child: Text('Delete'),
          ),
        ],
      );
    },
  );
}
