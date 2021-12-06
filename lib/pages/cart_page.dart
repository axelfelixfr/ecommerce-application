import 'package:ecommerce_application/widgets/cart_page/cart_empty.dart';
import 'package:ecommerce_application/widgets/cart_page/cart_products.dart';
import 'package:flutter/material.dart';

class CartPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    List products = [];
    return Scaffold(body: products.isEmpty ? CartEmpty() : CartProducts());
  }
}
