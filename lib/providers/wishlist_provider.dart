import 'package:ecommerce_application/models/wishlist.dart';
import 'package:flutter/material.dart';

class WishlistProvider with ChangeNotifier {
  Map<String, Wishlist> _wishlistItems = {};

  Map<String, Wishlist> get getWishlistItems {
    return {..._wishlistItems};
  }

  void addAndRemoveFromWishlist(
      String productId, double price, String name, String imageUrl) {
    if (_wishlistItems.containsKey(productId)) {
      removeItem(productId);
    } else {
      _wishlistItems.putIfAbsent(
          productId,
          () => Wishlist(
              id: DateTime.now().toString(),
              name: name,
              price: price,
              imageUrl: imageUrl));
    }
    notifyListeners();
  }

  void removeItem(String productId) {
    _wishlistItems.remove(productId);
    notifyListeners();
  }

  void clearWishlist() {
    _wishlistItems.clear();
    notifyListeners();
  }
}
