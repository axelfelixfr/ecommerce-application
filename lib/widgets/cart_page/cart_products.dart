import 'package:cool_alert/cool_alert.dart';
import 'package:ecommerce_application/models/cart.dart';
import 'package:ecommerce_application/providers/cart_provider.dart';
import 'package:ecommerce_application/providers/dark_theme_provider.dart';
import 'package:ecommerce_application/utilities/my_app_colors.dart';
import 'package:ecommerce_application/widgets/market_page/inner_page/product_details.dart';
import 'package:flutter/material.dart';
import 'package:line_icons/line_icons.dart';
import 'package:provider/provider.dart';

class CartProducts extends StatefulWidget {
  final String productId;

  const CartProducts({this.productId});

  /*
  final String id;
  final String productId;
  final double price;
  final int quantity;
  final String name;
  final String imageUrl;

  const CartProducts(
      {@required this.id,
      @required this.productId,
      @required this.price,
      @required this.quantity,
      @required this.name,
      @required this.imageUrl});
  */
  @override
  _CartProductsState createState() => _CartProductsState();
}

class _CartProductsState extends State<CartProducts> {
  @override
  Widget build(BuildContext context) {
    final themeChange = Provider.of<DarkThemeProvider>(context);
    // Información del carrito tomando el modelo
    final informationCart = Provider.of<Cart>(context);
    double subtotal = informationCart.price * informationCart.quantity;
    // Provider del carrito de compras
    final cartProvider = Provider.of<CartProvider>(context);

    return InkWell(
      onTap: () => Navigator.pushNamed(context, ProductDetails.routeName,
          arguments: widget.productId),
      child: Container(
          height: 140,
          margin: const EdgeInsets.only(top: 5, bottom: 12, left: 8, right: 8),
          decoration: BoxDecoration(
              borderRadius: BorderRadius.all(const Radius.circular(16.0))
              // BorderRadius.only(
              // bottomRight: const Radius.circular(16.0),
              // topRight: const Radius.circular(16.0)
              ,
              color: Theme.of(context).backgroundColor),
          child: Row(children: [
            Padding(
              padding: const EdgeInsets.all(5.0),
              child: Container(
                width: 135,
                decoration: BoxDecoration(
                    image: DecorationImage(
                  image: NetworkImage(informationCart.imageUrl),
                  // fit: BoxFit.contain
                )),
              ),
            ),
            Flexible(
              child: Padding(
                padding: const EdgeInsets.all(2.0),
                child: Column(children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Flexible(
                        child: Text(informationCart.name,
                            maxLines: 2,
                            overflow: TextOverflow.ellipsis,
                            style: TextStyle(
                                fontWeight: FontWeight.w600, fontSize: 15)),
                      ),
                      Material(
                        color: Colors.transparent,
                        child: InkWell(
                            borderRadius: BorderRadius.circular(32.0),
                            // splashColor: ,
                            onTap: () {
                              CoolAlert.show(
                                  context: context,
                                  title: 'Quitar producto',
                                  type: CoolAlertType.confirm,
                                  confirmBtnText: 'Aceptar',
                                  cancelBtnText: 'Cancelar',
                                  confirmBtnColor: Colors.red[400],
                                  onConfirmBtnTap: () {
                                    cartProvider.removeItem(widget.productId);
                                    Navigator.pop(context);
                                  },
                                  text:
                                      '¿Deseas quitar este producto de tu carrito?',
                                  animType: CoolAlertAnimType.slideInUp,
                                  backgroundColor:
                                      Theme.of(context).backgroundColor);
                            },
                            child: Container(
                                height: 50,
                                width: 50,
                                child: Icon(LineIcons.timesCircle,
                                    color: Colors.redAccent, size: 22))),
                      )
                    ],
                  ),
                  Row(children: [
                    Text('Precio:'),
                    SizedBox(width: 5),
                    Text('\$ ${informationCart.price}',
                        style: TextStyle(
                            fontSize: 15,
                            fontWeight: FontWeight.w600,
                            color: Theme.of(context).accentColor))
                  ]),
                  Row(children: [
                    Text('Subtotal:'),
                    SizedBox(width: 5),
                    FittedBox(
                      child: Text('\$ ${subtotal.toStringAsFixed(2)}',
                          style: TextStyle(
                              fontSize: 15,
                              fontWeight: FontWeight.w600,
                              color: Theme.of(context).accentColor)),
                    )
                  ]),
                  Row(
                    children: [
                      Text('Envio gratis',
                          style: TextStyle(
                              fontSize: 15, fontWeight: FontWeight.w600)),
                      Spacer(),
                      Material(
                        color: Colors.transparent,
                        child: InkWell(
                            borderRadius: BorderRadius.circular(5.0),
                            // splashColor: ,
                            onTap: informationCart.quantity < 2
                                ? null
                                : () {
                                    cartProvider.reduceItemByOne(
                                      widget.productId,
                                      // informationCart.price,
                                      // informationCart.name,
                                      // informationCart.imageUrl
                                    );
                                  },
                            child: Container(
                                child: Icon(LineIcons.minus,
                                    color: informationCart.quantity < 2
                                        ? Colors.grey
                                        : Colors.redAccent,
                                    size: 22))),
                      ),
                      Card(
                          elevation: 12,
                          child: Container(
                              width: MediaQuery.of(context).size.width * 0.12,
                              padding: const EdgeInsets.all(5.0),
                              decoration: BoxDecoration(
                                  gradient: LinearGradient(
                                      colors: [
                                        MyAppColors.gradiendYStart,
                                        MyAppColors.gradiendYEnd
                                      ],
                                      begin: const FractionalOffset(0.0, 0.0),
                                      end: const FractionalOffset(5.0, 9.0),
                                      stops: [0.0, 0.1],
                                      tileMode: TileMode.mirror)),
                              child: Text(informationCart.quantity.toString(),
                                  textAlign: TextAlign.center))),
                      Material(
                        color: Colors.transparent,
                        child: InkWell(
                            borderRadius: BorderRadius.circular(4.0),
                            // splashColor: ,
                            onTap: () {
                              cartProvider.addProductToCart(
                                  widget.productId,
                                  informationCart.price,
                                  informationCart.name,
                                  informationCart.imageUrl);
                            },
                            child: Container(
                                child: Padding(
                              padding: const EdgeInsets.all(5.0),
                              child: Icon(LineIcons.plus,
                                  color: Colors.greenAccent, size: 22),
                            ))),
                      ),
                    ],
                  )
                ]),
              ),
            )
          ])),
    );
  }
}
