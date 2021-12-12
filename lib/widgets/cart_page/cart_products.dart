import 'package:ecommerce_application/providers/dark_theme_provider.dart';
import 'package:ecommerce_application/utilities/my_app_colors.dart';
import 'package:flutter/material.dart';
import 'package:line_icons/line_icons.dart';
import 'package:provider/provider.dart';

class CartProducts extends StatefulWidget {
  @override
  _CartProductsState createState() => _CartProductsState();
}

class _CartProductsState extends State<CartProducts> {
  @override
  Widget build(BuildContext context) {
    final themeChange = Provider.of<DarkThemeProvider>(context);

    return Container(
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
                      image: NetworkImage(
                          'https://s1.qwant.com/thumbr/474x474/3/d/8ba8797bd23743207bcc11d77f13a4565520210c95bc1904d75ecfd33c7b94/th.jpg?u=https%3A%2F%2Ftse4.mm.bing.net%2Fth%3Fid%3DOIP.aLe3QbdQKcyWxjvfUvxQQgHaHa%26pid%3DApi&q=0&b=1&p=0&a=0'),
                      fit: BoxFit.contain)),
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
                      child: Text('Title',
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
                          onTap: () {},
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
                  Text('\$450',
                      style: TextStyle(
                          fontSize: 15,
                          fontWeight: FontWeight.w600,
                          color: Theme.of(context).accentColor))
                ]),
                Row(children: [
                  Text('Subtotal:'),
                  SizedBox(width: 5),
                  Text('\$450',
                      style: TextStyle(
                          fontSize: 15,
                          fontWeight: FontWeight.w600,
                          color: Theme.of(context).accentColor))
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
                          onTap: () {},
                          child: Container(
                              child: Icon(LineIcons.minus,
                                  color: Colors.redAccent, size: 22))),
                    ),
                    Card(
                        elevation: 12,
                        child: Container(
                            width: MediaQuery.of(context).size.width * 0.12,
                            padding: const EdgeInsets.all(8.0),
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
                            child: Text('1', textAlign: TextAlign.center))),
                    Material(
                      color: Colors.transparent,
                      child: InkWell(
                          borderRadius: BorderRadius.circular(4.0),
                          // splashColor: ,
                          onTap: () {},
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
        ]));
  }
}
