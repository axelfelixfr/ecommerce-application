import 'package:cool_alert/cool_alert.dart';
import 'package:ecommerce_application/providers/wishlist_provider.dart';
import 'package:ecommerce_application/utilities/my_app_icons.dart';
import 'package:ecommerce_application/widgets/wishlist_page/wishlist_empty.dart';
import 'package:ecommerce_application/widgets/wishlist_page/wishlist_products.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class WishlistPage extends StatelessWidget {
  static const routeName = '/WishlistPage';

  @override
  Widget build(BuildContext context) {
    final wishlistProvider = Provider.of<WishlistProvider>(context);

    return wishlistProvider.getWishlistItems.isEmpty
        ? Scaffold(body: WishlistEmpty())
        : Scaffold(
            appBar: AppBar(
                title: Text(
                    'Mi lista (${wishlistProvider.getWishlistItems.length})',
                    style: TextStyle(color: Theme.of(context).hintColor)),
                actions: [
                  IconButton(
                      onPressed: () {
                        CoolAlert.show(
                            context: context,
                            title: 'Limpiar lista',
                            type: CoolAlertType.confirm,
                            confirmBtnText: 'Aceptar',
                            cancelBtnText: 'Cancelar',
                            confirmBtnColor: Colors.red[400],
                            onConfirmBtnTap: () {
                              wishlistProvider.clearWishlist();
                              Navigator.pop(context);
                            },
                            text: '¿Deseas limpiar tu lista de favoritos?',
                            animType: CoolAlertAnimType.slideInUp,
                            backgroundColor: Theme.of(context).backgroundColor);
                      },
                      icon: Icon(MyAppIcons.trash))
                ]),
            body: ListView.builder(
                itemCount: wishlistProvider.getWishlistItems.length,
                itemBuilder: (BuildContext context, int index) {
                  return ChangeNotifierProvider.value(
                      value: wishlistProvider.getWishlistItems.values
                          .toList()[index],
                      child: WishlistProducts(
                          productId: wishlistProvider.getWishlistItems.keys
                              .toList()[index]));
                }));
  }
}
