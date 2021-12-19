import 'package:ecommerce_application/pages/market_page.dart';
import 'package:ecommerce_application/utilities/my_app_colors.dart';
import 'package:flutter/material.dart';
import 'package:ecommerce_application/providers/dark_theme_provider.dart';
import 'package:provider/provider.dart';

class CartEmpty extends StatelessWidget {
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
                image: AssetImage('assets/img/shoppingbag.png'))),
      ),
      Text('Aún no haz hecho compras',
          textAlign: TextAlign.center,
          style: TextStyle(
              color: Theme.of(context).textSelectionColor,
              fontSize: 36,
              fontWeight: FontWeight.w600)),
      SizedBox(height: 30),
      Padding(
        padding: const EdgeInsets.only(left: 5, right: 5),
        child: Text(
            'Parece que no haz añadido ningún producto, recuerda que hoy toca hacer la despensa',
            textAlign: TextAlign.center,
            style: TextStyle(
                color: themeChange.darkTheme
                    ? Theme.of(context).disabledColor
                    : MyAppColors.subTitle,
                fontSize: 23,
                fontWeight: FontWeight.w600)),
      ),
      SizedBox(height: 30),
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
            child: Text('Comprar ahora',
                textAlign: TextAlign.center,
                style: TextStyle(
                    color: Theme.of(context).textSelectionColor,
                    fontSize: 23,
                    fontWeight: FontWeight.w600))),
      )
    ]);
  }
}
