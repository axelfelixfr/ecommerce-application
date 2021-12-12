import 'package:ecommerce_application/pages/cart_page.dart';
import 'package:ecommerce_application/pages/feeds_page.dart';
import 'package:ecommerce_application/utilities/my_app_colors.dart';
import 'package:ecommerce_application/utilities/my_app_icons.dart';
import 'package:flutter/material.dart';

class BackLayerMenu extends StatefulWidget {
  @override
  _BackLayerMenuState createState() => _BackLayerMenuState();
}

class _BackLayerMenuState extends State<BackLayerMenu> {
  @override
  Widget build(BuildContext context) {
    return Stack(fit: StackFit.expand, children: [
      Ink(
          decoration: BoxDecoration(
              gradient: LinearGradient(
                  colors: [
                    MyAppColors.gradiendYStart,
                    MyAppColors.gradiendYEnd
                  ],
                  begin: const FractionalOffset(0.0, 0.0),
                  end: const FractionalOffset(7.0, 0.0),
                  stops: [0.0, 0.1],
                  tileMode: TileMode.mirror))),
      Positioned(
          top: -100.0,
          left: 140.0,
          child: Transform.rotate(
              angle: -0.5,
              child: Container(
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(20.0),
                      color: Colors.white.withOpacity(0.3)),
                  width: 150,
                  height: 250))),
      Positioned(
          bottom: 0.0,
          right: 100.0,
          child: Transform.rotate(
              angle: -0.8,
              child: Container(
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(20.0),
                      color: Colors.white.withOpacity(0.3)),
                  width: 150,
                  height: 300))),
      Positioned(
        top: -50.0,
        left: 60.0,
        child: Transform.rotate(
          angle: -0.5,
          child: Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(20.0),
              color: Colors.white.withOpacity(0.3),
            ),
            width: 150,
            height: 200,
          ),
        ),
      ),
      Positioned(
        bottom: 10.0,
        right: 0.0,
        child: Transform.rotate(
          angle: -0.8,
          child: Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(20.0),
              color: Colors.white.withOpacity(0.3),
            ),
            width: 150,
            height: 200,
          ),
        ),
      ),
      SingleChildScrollView(
          child: Container(
              margin: EdgeInsets.all(50),
              child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    Center(
                        child: Container(
                            padding: const EdgeInsets.all(6.0),
                            height: 100,
                            width: 100,
                            decoration: BoxDecoration(
                                color: Theme.of(context).backgroundColor,
                                borderRadius: BorderRadius.circular(10.0)),
                            child: Container(
                                // clipBehavior: Clip.antiAlias,
                                decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(20.0),
                                    image: DecorationImage(
                                        image: NetworkImage(
                                            'https://t3.ftcdn.net/jpg/01/83/55/76/240_F_183557656_DRcvOesmfDl5BIyhPKrcWANFKy2964i9.jpg'),
                                        fit: BoxFit.fill))))),
                    contentBackLayer(() {
                      navigateTo(context, FeedsPage.routeName);
                    }, "Mercado", 0),
                    contentBackLayer(() {
                      navigateTo(context, CartPage.routeName);
                    }, "Carrito", 1),
                    contentBackLayer(() {
                      navigateTo(context, FeedsPage.routeName);
                    }, "Favoritos", 2),
                    contentBackLayer(() {
                      navigateTo(context, FeedsPage.routeName);
                    }, "Subir nuevo producto", 3)
                  ])))
    ]);
  }

  List _contentIcons = [
    MyAppIcons.rss,
    MyAppIcons.shopping,
    MyAppIcons.wishlist,
    MyAppIcons.uploadProduct
  ];

  void navigateTo(BuildContext context, String routeName) {
    Navigator.of(context).pushNamed(routeName);
  }

  Widget contentBackLayer(Function func, String text, int index) {
    return Column(
      children: [
        const SizedBox(height: 8.0),
        InkWell(
            onTap: func,
            // () {
            //    Navigator.of(context).pushNamed(FeedsPage.routeName);
            // },
            child: Row(mainAxisAlignment: MainAxisAlignment.center, children: [
              Padding(
                padding: const EdgeInsets.all(16.0),
                child: Text(text,
                    style: TextStyle(fontWeight: FontWeight.w700),
                    textAlign: TextAlign.center),
              ),
              Icon(_contentIcons[index])
            ])),
      ],
    );
  }
}
