import 'package:flutter/material.dart';

class CartModel extends ChangeNotifier {
  final List _shopItems = const [
    [
      "Apple watch series 8",
      "25467.00",
      "https://cdn0.vox-cdn.com/hermano/verge/product/image/9967/226266_APPLE_WATCH_8_SE_PHO_akrales_0615.jpg",
      "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcRrvLEkEBkcm3ZRf4_a839wxfEesyySbYzlEj74xrh7kL_DEvVJYDgHNVbRPUjV5YYlKqQ&usqp=CAU",
      "https://dailysale.com/cdn/shop/products/apple-watch-series-8-gps-45mm-midnight-aluminum-case-with-midnight-sport-band-refurbished-smart-watches-dailysale-951532_800x.jpg?v=1694185418",
      "35"
    ],
    [
      "Dell inspiron 15 3000 series",
      "78000.50",
      "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcSZk5xRBiBns76l2_pDZHaByQG8CpAWhcpHDw&usqp=CAU",
      "https://m.media-amazon.com/images/I/61vmV9uKLOL.jpg",
      "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcQ51XiVqb8M58ovddqj7-gwv4ZlrZQhntXK2Dsh4ovousOno0VZ05WT83Q8jV_rjpjqfcQ&usqp=CAU",
      "50",
    ],
    [
      "Samsung s23 ultra",
      "99000.00",
      "https://akm-img-a-in.tosshub.com/indiatoday/images/story/202301/samsung_s22-one_one.jpg?VersionId=bKtfxb5HwfPD7VhxQ0SRs2vLFJ54RF2F",
      "https://promart.vteximg.com.br/arquivos/ids/6881439-1000-1000/image-85e7258d621047d2b90c0547d9c4db93.jpg?v=638152064972200000",
      "https://promart.vteximg.com.br/arquivos/ids/6881439-1000-1000/image-85e7258d621047d2b90c0547d9c4db93.jpg?v=638152064972200000",
      "40",
    ],
    [
      "IFB washing machine top load 7kg price",
      "43000.00",
      "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcTotCQ90FNmi5T6d7n5nmuUjAdGEpyOBV7KZA&usqp=CAU",
      "https://rukminim2.flixcart.com/image/850/1000/xif0q/washing-machine-new/f/7/v/-original-imagt5qhv9kmvevz.jpeg?q=20&crop=false",
      "https://5.imimg.com/data5/TH/SW/ZO/GLADMIN-3061/ifb-7-kg-fully-automatic-front-load-washing-machine-senator-smart-silver-500x500.jpg",
      "27",
    ],
    [
      "Boat rockerz 550",
      "5500.00",
      "https://m.media-amazon.com/images/S/aplus-media/vc/950283ef-91bc-41a8-9eb4-602af67c5c95.__CR0,0,970,600_PT0_SX970_V1___.jpg",
      "https://i0.wp.com/suraajinfocomm.com/wp-content/uploads/2021/06/boat-rockerz-550-buy-online-best-price-in-kerala.png?fit=540%2C540&ssl=1",
      "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcSOa-58pklgmK8jD2aGfXjtsqVPkZFsXpy4lkvF8M2UuZb1ZctwqMg1RIXN2C8h3zaFggo&usqp=CAU",
      "67",
    ],
    [
      "Whirlpool 1.5 Ton 5 Star Split AC",
      "44000.00",
      "https://velanstore.com/wp-content/uploads/2023/05/Screenshot-2023-08-05-at-6.25.18%E2%80%AFPM.png",
      "https://5.imimg.com/data5/SELLER/Default/2020/10/AC/FS/KI/2340900/magicool-pro-2-ton-3-star-inverter-split-ac-500x500.PNG",
      "https://m.media-amazon.com/images/I/413Hn3T22sL._AC_UF1000,1000_QL80_.jpg",
      "30",
    ],
  ];

  List _cartItems = [];

  get cartItems => _cartItems;

  get shopItems => _shopItems;

  void addItemToCart(int index) {
    _cartItems.add(_shopItems[index]);
    notifyListeners();
  }

  void removeItemFromCart(int index) {
    _cartItems.removeAt(index);
    notifyListeners();
  }

  double calculateTotal() {
    double totalPrice = 0;
    for (int i = 0; i < cartItems.length; i++) {
      double itemPrice = double.parse(cartItems[i][1]);
      int itemQuantity = int.parse(cartItems[i][3]);

      totalPrice += (itemPrice * itemQuantity);
    }
    return totalPrice;
  }

  void addItemToCartDetails(int index, int quantity) {
    List<String> item = [
      shopItems[index][0],
      shopItems[index][1],
      shopItems[index][2],
    ];

    item.add(quantity.toString());

    cartItems.add(item);
    notifyListeners();
  }

  void updateCartItemQuantity(int index, int newQuantity) {
    cartItems[index][3] = newQuantity.toString();
    notifyListeners();
  }

  void updateTotal() {
    notifyListeners();
  }

  void incrementCartItemQuantity(int index) {
    int currentQuantity = int.parse(cartItems[index][3]);
    currentQuantity++;
    cartItems[index][3] = currentQuantity.toString();
    notifyListeners();
    updateTotal();
  }

  void decrementCartItemQuantity(int index) {
    int currentQuantity = int.parse(cartItems[index][3]);
    if (currentQuantity > 1) {
      currentQuantity--;
      cartItems[index][3] = currentQuantity.toString();
      notifyListeners();
      updateTotal();
    }
  }
}
