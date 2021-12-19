import 'package:ecommerce_application/providers/cart_provider.dart';
import 'package:ecommerce_application/providers/dark_theme_provider.dart';
import 'package:ecommerce_application/providers/products_provider.dart';
import 'package:ecommerce_application/providers/wishlist_provider.dart';
import 'package:ecommerce_application/utilities/my_app_colors.dart';
import 'package:ecommerce_application/utilities/my_app_icons.dart';
import 'package:flutter/material.dart';
import 'package:line_icons/line_icons.dart';
import 'package:provider/provider.dart';

import 'product_details.dart';

class ProductModal extends StatelessWidget {
  final String productId;

  const ProductModal({@required this.productId});

  @override
  Widget build(BuildContext context) {
    final productsProvider =
        Provider.of<ProductsProvider>(context, listen: false);
    final informationProduct = productsProvider.findByID(productId);
    // Provider del carrito de compras
    final cartProvider = Provider.of<CartProvider>(context);
    // Provider para wishlist
    final wishlistProvider = Provider.of<WishlistProvider>(context);

    return Dialog(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
        elevation: 0.0,
        backgroundColor: Colors.transparent,
        child: SingleChildScrollView(
            child: Column(children: [
          Container(
              constraints: BoxConstraints(
                  minHeight: 100,
                  maxHeight: MediaQuery.of(context).size.height * 0.5),
              width: double.infinity,
              decoration: BoxDecoration(
                  color: Theme.of(context).scaffoldBackgroundColor),
              child: Padding(
                  padding: const EdgeInsets.all(5.0),
                  child: Image.network(informationProduct.imageUrl))),
          Container(
              color: Theme.of(context).scaffoldBackgroundColor,
              child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Flexible(
                        child: dialogContent(
                            context,
                            0,
                            () => {
                                  wishlistProvider.addAndRemoveFromWishlist(
                                      productId,
                                      informationProduct.price,
                                      informationProduct.name,
                                      informationProduct.imageUrl),
                                  Navigator.canPop(context)
                                      ? Navigator.pop(context)
                                      : null
                                })),
                    Flexible(
                        child: dialogContent(
                            context,
                            1,
                            () => {
                                  Navigator.pushNamed(
                                          context, ProductDetails.routeName,
                                          arguments: informationProduct.id)
                                      .then((value) => Navigator.canPop(context)
                                          ? Navigator.pop(context)
                                          : null)
                                })),
                    Flexible(
                        child: dialogContent(
                            context,
                            2,
                            cartProvider.getCartItems.containsKey(productId)
                                ? () {}
                                : () {
                                    cartProvider.addProductToCart(
                                        productId,
                                        informationProduct.price,
                                        informationProduct.name,
                                        informationProduct.imageUrl);
                                    Navigator.canPop(context)
                                        ? Navigator.pop(context)
                                        : null;
                                  })),
                  ])),
          Container(
              margin: EdgeInsets.all(8),
              decoration: BoxDecoration(
                  border: Border.all(color: Colors.white, width: 1.3),
                  shape: BoxShape.circle),
              child: Material(
                  color: Colors.transparent,
                  child: InkWell(
                      borderRadius: BorderRadius.circular(30),
                      splashColor: Colors.grey,
                      onTap: () => Navigator.canPop(context)
                          ? Navigator.pop(context)
                          : null,
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Icon(LineIcons.times,
                            size: 28, color: Colors.white),
                      ))))
        ])));
  }

  Widget dialogContent(BuildContext context, int index, Function func) {
    final cart = Provider.of<CartProvider>(context);
    final wishlist = Provider.of<WishlistProvider>(context);

    List<IconData> _dialogIcons = [
      wishlist.getWishlistItems.containsKey(productId)
          ? Icons.favorite
          : Icons.favorite_border,
      LineIcons.eye,
      cart.getCartItems.containsKey(productId)
          ? LineIcons.shoppingCartArrowDown
          : MyAppIcons.addProduct,
    ];

    List<String> _texts = [
      wishlist.getWishlistItems.containsKey(productId)
          ? 'En su lista'
          : 'Me gusta',
      'Ver',
      cart.getCartItems.containsKey(productId) ? 'En su carrito' : 'Comprar'
    ];

    List<Color> _colors = [
      wishlist.getWishlistItems.containsKey(productId)
          ? Colors.pink
          : Theme.of(context).textSelectionColor,
      Theme.of(context).textSelectionColor,
      Theme.of(context).textSelectionColor
    ];

    final themeChange = Provider.of<DarkThemeProvider>(context);

    return FittedBox(
        child: Material(
            color: Colors.transparent,
            child: InkWell(
                onTap: func,
                splashColor: Colors.grey,
                child: Container(
                    width: MediaQuery.of(context).size.width * 0.25,
                    padding: EdgeInsets.all(4),
                    child: Column(children: [
                      Container(
                          decoration: BoxDecoration(
                              color: Theme.of(context).backgroundColor,
                              shape: BoxShape.circle,
                              boxShadow: [
                                BoxShadow(
                                    color: Colors.black26,
                                    blurRadius: 10.0,
                                    offset: const Offset(0.0, 10.0))
                              ]),
                          child: ClipOval(
                              child: SizedBox(
                                  width: 50,
                                  height: 50,
                                  child: Icon(_dialogIcons[index],
                                      color: _colors[index], size: 25)))),
                      Padding(
                        padding: const EdgeInsets.all(5.0),
                        child: FittedBox(
                            child: Text(_texts[index],
                                maxLines: 1,
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                    // fontSize: 15,
                                    color: themeChange.darkTheme
                                        ? Theme.of(context).disabledColor
                                        : MyAppColors.subTitle))),
                      )
                    ])))));
  }
}
