import 'package:ecommerce_application/widgets/wishlist_page/wishlist_empty.dart';
import 'package:ecommerce_application/widgets/wishlist_page/wishlist_products.dart';
import 'package:flutter/material.dart';

class WishlistPage extends StatelessWidget {
  static const routeName = '/WishlistPage';

  @override
  Widget build(BuildContext context) {
    List wishlist = [];
    return wishlist.isNotEmpty
        ? Scaffold(body: WishlistEmpty())
        : Scaffold(
            appBar: AppBar(title: Text('Mi lista')),
            body: ListView.builder(
                itemCount: 1,
                itemBuilder: (BuildContext context, int index) {
                  return WishlistProducts();
                }));
  }
}
