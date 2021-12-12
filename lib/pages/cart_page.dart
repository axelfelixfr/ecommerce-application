import 'package:ecommerce_application/utilities/my_app_icons.dart';
import 'package:ecommerce_application/widgets/cart_page/cart_checkout.dart';
import 'package:ecommerce_application/widgets/cart_page/cart_empty.dart';
import 'package:ecommerce_application/widgets/cart_page/cart_products.dart';
import 'package:flutter/material.dart';

class CartPage extends StatelessWidget {
  static const routeName = '/CartPage';

  @override
  Widget build(BuildContext context) {
    List products = [];
    return !products.isEmpty
        ? Scaffold(body: CartEmpty())
        : Scaffold(
            appBar: AppBar(title: Text('Productos en tu carrito'), actions: [
              IconButton(onPressed: () {}, icon: Icon(MyAppIcons.trash))
            ]),
            body: Container(
              margin: EdgeInsets.only(bottom: 60),
              child: ListView.builder(
                  itemCount: 5,
                  itemBuilder: (BuildContext context, int index) {
                    return CartProducts();
                  }),
            ),
            bottomSheet: Container(
                child: CartCheckout(), margin: EdgeInsets.only(bottom: 20)),
          );
  }
}
