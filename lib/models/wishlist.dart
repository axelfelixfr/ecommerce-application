import 'package:flutter/material.dart';

class Wishlist with ChangeNotifier {
  final String id;
  final String name;
  final double price;
  final String imageUrl;

  Wishlist({this.id, this.name, this.price, this.imageUrl});
}
