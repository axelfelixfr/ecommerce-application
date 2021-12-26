import 'package:flutter/material.dart';

class Cart with ChangeNotifier {
  final String id;
  final String name;
  final String productId;
  final int quantity;
  final double price;
  final String imageUrl;

  Cart(
      {this.id,
      this.name,
      this.productId,
      this.quantity,
      this.price,
      this.imageUrl});
}
