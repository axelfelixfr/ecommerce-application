import 'package:flutter/material.dart';

class Product with ChangeNotifier {
  final String id;
  final String name;
  final String description;
  final double price;
  final String imageUrl;
  final String productCategoryName;
  final String brand;
  final int quantity;
  final bool isFavorite;
  final bool isPopular;

  Product(
      {this.id,
      this.name,
      this.description,
      this.price,
      this.imageUrl,
      this.productCategoryName,
      this.brand,
      this.quantity,
      this.isFavorite,
      this.isPopular});
}
