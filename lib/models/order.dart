import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class Order with ChangeNotifier {
  final String orderId;
  final String userId;
  final String productId;
  final String name;
  final String price;
  final String imageUrl;
  final String quantity;
  final Timestamp orderDate;

  Order(
      {this.orderId,
      this.userId,
      this.productId,
      this.name,
      this.price,
      this.imageUrl,
      this.quantity,
      this.orderDate});
}
