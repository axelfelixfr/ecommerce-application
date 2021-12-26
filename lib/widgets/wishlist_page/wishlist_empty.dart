import 'package:ecommerce_application/pages/home/market_page.dart';
import 'package:ecommerce_application/utilities/my_app_colors.dart';
import 'package:ecommerce_application/utilities/my_app_icons.dart';
import 'package:flutter/material.dart';
import 'package:ecommerce_application/providers/dark_theme_provider.dart';
import 'package:provider/provider.dart';

class WishlistEmpty extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final themeChange = Provider.of<DarkThemeProvider>(context);

    return Column(crossAxisAlignment: CrossAxisAlignment.center, children: [
      Container(
        margin: EdgeInsets.only(top: 50),
        width: 200,
        height: MediaQuery.of(context).size.height * 0.3,
        decoration: BoxDecoration(
            image: DecorationImage(
                fit: BoxFit.fill,
                image: AssetImage('assets/img/pages/wishlist.png'))),
      ),
      Padding(
        padding: const EdgeInsets.all(3.0),
        child: Text('Aún no haz agregado productos a tu lista',
            textAlign: TextAlign.center,
            style: TextStyle(
                color: Theme.of(context).textSelectionColor,
                fontSize: 30,
                fontWeight: FontWeight.w600)),
      ),
      SizedBox(height: 20),
      Padding(
        padding: const EdgeInsets.only(left: 5, right: 5),
        child: Text('Explora nuestro mercado y agrega productos',
            textAlign: TextAlign.center,
            style: TextStyle(
                color: themeChange.darkTheme
                    ? Theme.of(context).disabledColor
                    : MyAppColors.subTitle,
                fontSize: 19,
                fontWeight: FontWeight.w600)),
      ),
      SizedBox(height: 30),
      /*
      Container(
        width: MediaQuery.of(context).size.width * 0.7,
        height: MediaQuery.of(context).size.height * 0.06,
        child: RaisedButton(
            onPressed: () =>
                {Navigator.of(context).pushNamed(MarketPage.routeName)},
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(16),
              side: BorderSide(color: Colors.amberAccent),
            ),
            color: Colors.amber,
            child: Text('Agregar productos',
                textAlign: TextAlign.center,
                style: TextStyle(
                    color: Theme.of(context).textSelectionColor,
                    fontSize: 20,
                    fontWeight: FontWeight.w600))),
      )*/
      Container(
          width: MediaQuery.of(context).size.width * 0.7,
          height: MediaQuery.of(context).size.height * 0.06,
          child: ElevatedButton(
              style: ButtonStyle(
                  backgroundColor:
                      MaterialStateProperty.all(Colors.orange.shade400),
                  shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                      RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(7),
                          side:
                              BorderSide(color: MyAppColors.backgroundColor)))),
              onPressed: () =>
                  {Navigator.of(context).pushNamed(MarketPage.routeName)},
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text('Ver productos',
                      style:
                          TextStyle(fontWeight: FontWeight.w500, fontSize: 20)),
                  SizedBox(width: 5),
                  Icon(MyAppIcons.wishlist),
                ],
              ))),
    ]);
  }
}
