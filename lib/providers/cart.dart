import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;

class CartItem {
  final String id;
  final String title;
  final int quantity;
  final int price;
  final String imageUrl;
  final String productId;

  CartItem(
      {@required this.id,
      @required this.title,
      @required this.quantity,
      @required this.price,
      @required this.imageUrl,
      @required this.productId});
}

class Cart with ChangeNotifier {
  Map<String, CartItem> _items = {};

  Map<String, CartItem> get items {
    return {..._items};
  }

  int get itemCount {
    return _items.length;
  }

  double get totalAmount {
    var total = 0.0;
    _items.forEach((key, cartItem) {
      total += cartItem.price * cartItem.quantity;
    });
    return total;
  }

  int get totalItemCount {
    var totalItemAmount = 0;
    _items.forEach((key, cartItem) {
      totalItemAmount += cartItem.quantity;
    });
    return totalItemAmount;
  }

  void addItem(
    String productId,
    int price,
    String title,
    String imageUrl,
  ) {
    if (_items.containsKey(productId)) {
      // change quantity...
      _items.update(
        productId,
        (existingCartItem) => CartItem(
          id: existingCartItem.id,
          title: existingCartItem.title,
          price: existingCartItem.price,
          quantity: existingCartItem.quantity + 1,
          imageUrl: existingCartItem.imageUrl,
          productId: productId,
        ),
      );
    } else {
      _items.putIfAbsent(
        productId,
        () => CartItem(
          id: DateTime.now().toString(),
          title: title,
          price: price,
          quantity: 1,
          imageUrl: imageUrl,
          productId: productId,
        ),
      );
    }
    notifyListeners();
  }

  void removeItem(String productId) {
    _items.remove(productId);
    notifyListeners();
  }

  void removeSingleItem(String productId) {
    if (!_items.containsKey(productId)) {
      return;
    }
    if (_items[productId].quantity > 1) {
      _items.update(
          productId,
          (existingCartItem) => CartItem(
                id: existingCartItem.id,
                title: existingCartItem.title,
                price: existingCartItem.price,
                quantity: existingCartItem.quantity - 1,
                imageUrl: existingCartItem.imageUrl,
                productId: productId,
              ));
    } else {
      _items.remove(productId);
    }
    notifyListeners();
  }

  // void sendOrder(Product product) {
  //   const url =
  //       'https://parma-pizza-a83bd-default-rtdb.europe-west1.firebasedatabase.app/orders.json';
  //   http.post(url, body: json.encode({
  //     'items':
  //   }));
  // }

  void clear() {
    _items = {};
    notifyListeners();
  }

  Future<void> sendOrder(
    String platform,
    String items,
    String name,
    String street,
    String build,
    String appart,
    String phone,
    String delivery,
    String payment,
  ) async {
    const url = 'https://parmapizza.ru/ireg.php';

    try {
      await http.post(
        Uri.parse(url),
        body: {
          "platform": platform,
          "items": items,
          "name": name,
          "street": street,
          "build": build,
          "appart": appart,
          "phone": phone,
          "delivery": delivery,
          "payment": payment,
        },
      );
      print("Заказ успешно отправлен");
      print(items);
    } catch (e) {
      print(e);
    }

    notifyListeners();
  }
}
