import 'package:cool_alert/cool_alert.dart';
import 'package:ecommerce_application/models/wishlist.dart';
import 'package:ecommerce_application/providers/wishlist_provider.dart';
import 'package:ecommerce_application/utilities/my_app_colors.dart';
import 'package:flutter/material.dart';
import 'package:line_icons/line_icons.dart';
import 'package:provider/provider.dart';

class WishlistProducts extends StatefulWidget {
  final String productId;

  const WishlistProducts({this.productId});

  @override
  _WishlistProductsState createState() => _WishlistProductsState();
}

class _WishlistProductsState extends State<WishlistProducts> {
  @override
  Widget build(BuildContext context) {
    final informationWishlist = Provider.of<Wishlist>(context);

    return Stack(children: <Widget>[
      Container(
          width: double.infinity,
          margin: EdgeInsets.only(right: 30.0, bottom: 10.0),
          child: Material(
              color: Theme.of(context).backgroundColor,
              borderRadius: BorderRadius.circular(5.0),
              elevation: 3.0,
              child: InkWell(
                  onTap: () {},
                  child: Container(
                      padding: EdgeInsets.all(16.0),
                      child: Row(children: <Widget>[
                        Container(
                            height: 80,
                            child: Image.network(informationWishlist.imageUrl)),
                        SizedBox(width: 10),
                        Expanded(
                            child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            Text(informationWishlist.name,
                                style: TextStyle(
                                    fontSize: 16.0,
                                    fontWeight: FontWeight.bold)),
                            SizedBox(height: 20.0),
                            Text('\$ ${informationWishlist.price}',
                                style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontSize: 18.0))
                          ],
                        ))
                      ]))))),
      positionedRemove(widget.productId),
    ]);
  }

  Widget positionedRemove(String productId) {
    final wishlistProvider = Provider.of<WishlistProvider>(context);

    return Positioned(
        top: 20,
        right: 15,
        child: Container(
          height: 30,
          width: 30,
          child: MaterialButton(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(5.0),
            ),
            padding: EdgeInsets.all(0.0),
            color: MyAppColors.favColor,
            child: Icon(LineIcons.times, color: Colors.white),
            onPressed: () => {
              CoolAlert.show(
                  context: context,
                  title: 'Quitar producto',
                  type: CoolAlertType.confirm,
                  confirmBtnText: 'Aceptar',
                  cancelBtnText: 'Cancelar',
                  confirmBtnColor: Colors.red[400],
                  onConfirmBtnTap: () {
                    wishlistProvider.removeItem(productId);
                    Navigator.pop(context);
                  },
                  text:
                      '¿Deseas quitar este producto de tu lista de favoritos?',
                  animType: CoolAlertAnimType.slideInUp,
                  backgroundColor: Theme.of(context).backgroundColor)
            },
          ),
        ));
  }
}
