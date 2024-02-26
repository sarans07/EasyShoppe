import 'package:carousel_slider/carousel_options.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:dots_indicator/dots_indicator.dart';
import 'package:flutter/material.dart';

class ItemDetailsDialog extends StatefulWidget {
  final List<String> items;

  ItemDetailsDialog({required this.items});

  @override
  _ItemDetailsDialogState createState() => _ItemDetailsDialogState();
}

class _ItemDetailsDialogState extends State<ItemDetailsDialog> {
  int currentIndex = 0;
  int selectedQuantity = 1;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: MediaQuery.of(context).size.height * 0.37,
      width: MediaQuery.of(context).size.width * 0.8,
      decoration: BoxDecoration(color: Colors.grey[300]),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          Container(
            height: MediaQuery.of(context).size.height * 0.35,
            width: MediaQuery.of(context).size.width * 0.8,
            child: Stack(
              children: [
                CarouselSlider.builder(
                  itemCount: widget.items.length,
                  options: CarouselOptions(
                    scrollDirection: Axis.horizontal,
                    autoPlay: false,
                    aspectRatio: 6 / 6,
                    enableInfiniteScroll: false,
                    viewportFraction: 1,
                    enlargeCenterPage: true,
                    onPageChanged: (index, reason) {
                      setState(() {
                        currentIndex = index;
                      });
                    },
                  ),
                  itemBuilder:
                      (BuildContext context, int index, int pageViewIndex) {
                    return Container(
                      height: MediaQuery.of(context).size.height * 0.3,
                      width: MediaQuery.of(context).size.width * 0.8,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(20),
                        image: DecorationImage(
                          image: NetworkImage(widget.items[index]),
                          fit: BoxFit.fill,
                        ),
                      ),
                    );
                  },
                ),
                Align(
                  alignment: Alignment.bottomCenter,
                  child: DotsIndicator(
                    dotsCount: widget.items.length,
                    position: currentIndex.toDouble().floor(),
                  ),
                ),
              ],
            ),
          ),
          SizedBox(height: 10),
        ],
      ),
    );
  }
}
