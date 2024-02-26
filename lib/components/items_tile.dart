import 'package:flutter/material.dart';

class ItemTile extends StatefulWidget {
  final String itemName;
  final String itemPrice;
  final String image;
  final String image1;
  final String image2;
  final String itemDiscount;
  void Function()? onPressed;
  final Function()? onTap;

  ItemTile({
    super.key,
    required this.itemName,
    required this.itemPrice,
    required this.image,
    required this.image1,
    required this.image2,
    required this.itemDiscount,
    required this.onPressed,
    required this.onTap,
  });

  @override
  State<ItemTile> createState() => _ItemTileState();
}

class _ItemTileState extends State<ItemTile> {
  bool isFavorite = false;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(6),
      child: Stack(
        children: [
          Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(12),
              color: Colors.white,
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                // item image
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 10.0),
                  child: Container(
                    height: MediaQuery.of(context).size.height * 0.15,
                    width: MediaQuery.of(context).size.width * 1,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(20),
                        image: DecorationImage(
                            image: NetworkImage(widget.image),
                            fit: BoxFit.fill)),
                  ),
                ),

                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Container(
                      padding: EdgeInsets.all(5),
                      height: MediaQuery.of(context).size.height * 0.04,
                      width: MediaQuery.of(context).size.width * 0.2,
                      decoration: BoxDecoration(
                          color: Colors.red,
                          borderRadius: BorderRadius.circular(2)),
                      child: Text(
                        "${widget.itemDiscount}% Off",
                        style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                            color: Colors.white),
                      ),
                    ),
                    SizedBox(
                      width: 4,
                    ),
                    Expanded(
                        child: Text(
                      "Deal of the Day",
                      style: TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.bold,
                          color: Colors.red),
                    ))
                  ],
                ),

                // item name
                Padding(
                  padding: const EdgeInsets.only(left: 4.0),
                  child: Text(
                    widget.itemName,
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                  ),
                ),
              ],
            ),
          ),
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
    );
  }
}
