import 'package:ecommerce_application/models/cart.dart';
import 'package:flutter/material.dart';

class CartProvider with ChangeNotifier {
  Map<String, Cart> _cartItems = {};

  Map<String, Cart> get getCartItems {
    return {..._cartItems};
  }

  double get totalAmount {
    var total = 0.0;
    _cartItems.forEach((key, value) {
      total += value.price * value.quantity;
    });
    return total;
  }

  void addProductToCart(
      String productId, double price, String name, String imageUrl) {
    if (_cartItems.containsKey(productId)) {
      _cartItems.update(
          productId,
          (exitingCartItem) => Cart(
              id: exitingCartItem.id,
              name: exitingCartItem.name,
              productId: exitingCartItem.productId,
              price: exitingCartItem.price,
              quantity: exitingCartItem.quantity + 1,
              imageUrl: exitingCartItem.imageUrl));
    } else {
      _cartItems.putIfAbsent(
          productId,
          () => Cart(
              id: DateTime.now().toString(),
              name: name,
              productId: productId,
              price: price,
              quantity: 1,
              imageUrl: imageUrl));
    }
    notifyListeners();
  }

  void reduceItemByOne(String productId) {
    if (_cartItems.containsKey(productId)) {
      _cartItems.update(
          productId,
          (exitingCartItem) => Cart(
              id: exitingCartItem.id,
              name: exitingCartItem.name,
              productId: exitingCartItem.productId,
              price: exitingCartItem.price,
              quantity: exitingCartItem.quantity - 1,
              imageUrl: exitingCartItem.imageUrl));
    }
    notifyListeners();
  }

  void removeItem(String productId) {
    _cartItems.remove(productId);
    notifyListeners();
  }

  void clearCart() {
    _cartItems.clear();
    notifyListeners();
  }
}
