import 'package:ecommerce_application/providers/cart_provider.dart';
import 'package:ecommerce_application/providers/dark_theme_provider.dart';
import 'package:ecommerce_application/services/payment.dart';
import 'package:ecommerce_application/utilities/my_app_colors.dart';
import 'package:flutter/material.dart';
import 'package:giffy_dialog/giffy_dialog.dart';
import 'package:line_icons/line_icons.dart';
import 'package:loading_hud/loading_hud.dart';
import 'package:provider/provider.dart';

class CartCheckout extends StatefulWidget {
  @override
  _CartCheckoutState createState() => _CartCheckoutState();
}

class _CartCheckoutState extends State<CartCheckout> {
  @override
  void initState() {
    super.initState();
    StripeService.init();
  }

  void _payWithCard(BuildContext context, int amount) async {
    print('El total es $amount');
    if (amount < 1000) {
      return showDialog(
          context: context,
          builder: (_) => AssetGiffyDialog(
                image: Image.asset('assets/gif/wait.gif', fit: BoxFit.fill),
                buttonOkColor: Colors.amber,
                buttonOkText: Text('Ok', style: TextStyle(color: Colors.white)),
                title: Text(
                  '¡Un momento!',
                  style: TextStyle(fontSize: 22.0, fontWeight: FontWeight.w600),
                ),
                description: Text(
                  'La compra mínima debe ser de 10 pesos MXN, por favor compra más en el mercado, ¡Te esperamos!',
                  textAlign: TextAlign.center,
                  style: TextStyle(),
                ),
                entryAnimation: EntryAnimation.TOP,
                onlyOkButton: true,
                onOkButtonPressed: () {
                  Navigator.canPop(context) ? Navigator.pop(context) : null;
                },
              ));
    } else {
      var progressHud = _buildUnCancelableHud(context);
      progressHud.show();
      await Future.delayed(Duration(seconds: 2), () async {
        progressHud.dismiss();
        // var response = await StripeService.payWithNewCard(currency: 'MXN', amount: '50000');
        var responseGiffyDialog = await StripeService.payWithNewCard(context,
            currency: 'MXN', amount: amount.toString());
        print('La respuesta es $responseGiffyDialog');
        showDialog(context: context, builder: (_) => responseGiffyDialog);
        // Scaffold.of(context).showSnackBar(SnackBar(
        //     content: Text(response.message),
        //     duration:
        //         Duration(milliseconds: response.success == true ? 1500 : 3000)));
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final themeChange = Provider.of<DarkThemeProvider>(context);
    final cartProvider = Provider.of<CartProvider>(context);
    final subtotal = cartProvider.totalAmount;

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
                        onPressed: () {
                          double amountInCents = subtotal * 1000;
                          int integerAmount = (amountInCents / 10).ceil();
                          _payWithCard(context, integerAmount);
                        },
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

  // Progress dialog
  LoadingHud _buildUnCancelableHud(BuildContext context) {
    return LoadingHud(
      context,
      cancelable: false,
      canceledOnTouchOutside: false,
    );
  }
}
