import 'package:ecommerce_application/providers/dark_theme_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class CartCheckout extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final themeChange = Provider.of<DarkThemeProvider>(context);

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
                    child: Material(
                        borderRadius: BorderRadius.circular(30),
                        color: Colors.redAccent,
                        child: InkWell(
                          borderRadius: BorderRadius.circular(30),
                          onTap: () {},
                          child: Padding(
                              padding: const EdgeInsets.all(6.0),
                              child: Text('Checkout',
                                  textAlign: TextAlign.center,
                                  style: TextStyle(
                                      color:
                                          Theme.of(context).textSelectionColor,
                                      fontSize: 17,
                                      fontWeight: FontWeight.w600))),
                        ))),
                Spacer(),
                Text('Total:',
                    style: TextStyle(
                        color: Theme.of(context).textSelectionColor,
                        fontSize: 17,
                        fontWeight: FontWeight.w600)),
                Padding(
                  padding: const EdgeInsets.only(left: 10.0),
                  child: Text('\$170.00',
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
