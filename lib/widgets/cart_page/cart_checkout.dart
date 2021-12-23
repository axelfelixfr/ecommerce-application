import 'package:ecommerce_application/providers/cart_provider.dart';
import 'package:ecommerce_application/providers/dark_theme_provider.dart';
import 'package:ecommerce_application/utilities/my_app_colors.dart';
import 'package:flutter/material.dart';
import 'package:line_icons/line_icons.dart';
import 'package:provider/provider.dart';

class CartCheckout extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final themeChange = Provider.of<DarkThemeProvider>(context);
    final cartProvider = Provider.of<CartProvider>(context);

    return Container(
        decoration: BoxDecoration(
            border: Border(top: BorderSide(color: Colors.amber, width: 0.5))),
        child: Padding(
          padding: const EdgeInsets.all(6.0),
          child: Row(
              // mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Expanded(
                    flex: 2,
                    child: ElevatedButton(
                        style: ButtonStyle(
                            backgroundColor: MaterialStateProperty.all(
                                Colors.orange.shade400),
                            shape: MaterialStateProperty.all<
                                    RoundedRectangleBorder>(
                                RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(7),
                                    side: BorderSide(
                                        color: MyAppColors.backgroundColor)))),
                        onPressed: () {},
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text('Comprar',
                                style: TextStyle(
                                    fontWeight: FontWeight.w500, fontSize: 16)),
                            SizedBox(width: 5),
                            Icon(LineIcons.creditCard),
                          ],
                        ))),
                /*
                Expanded(
                    flex: 2,
                    child: Container(
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(30),
                          gradient: LinearGradient(
                              colors: [
                                MyAppColors.gradiendYStart,
                                MyAppColors.gradiendYEnd
                              ],
                              begin: const FractionalOffset(0.0, 0.0),
                              end: const FractionalOffset(5.0, 9.0),
                              stops: [0.0, 0.1],
                              tileMode: TileMode.mirror)),
                      child: Material(
                          color: Colors.transparent,
                          child: InkWell(
                            borderRadius: BorderRadius.circular(30),
                            onTap: () {},
                            child: Padding(
                                padding: const EdgeInsets.all(6.0),
                                child: Text('Comprar',
                                    textAlign: TextAlign.center,
                                    style: TextStyle(
                                        color: Theme.of(context)
                                            .textSelectionColor,
                                        fontSize: 17,
                                        fontWeight: FontWeight.w600))),
                          )),
                    ))*/
                Spacer(),
                Text('Total:',
                    style: TextStyle(
                        color: Theme.of(context).textSelectionColor,
                        fontSize: 17,
                        fontWeight: FontWeight.w600)),
                Padding(
                  padding: const EdgeInsets.only(left: 10.0),
                  child: Text(
                      '\$ ${cartProvider.totalAmount.toStringAsFixed(2)}',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                          color: themeChange.darkTheme
                              ? Colors.white70
                              : Colors.black45,
                          fontSize: 17,
                          fontWeight: FontWeight.w500)),
                )
              ]),
        ));
  }
}
