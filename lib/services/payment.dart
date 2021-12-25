import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:giffy_dialog/giffy_dialog.dart';
import 'package:http/http.dart' as http;
import 'package:stripe_payment/stripe_payment.dart';

class StripeTransactionResponse {
  String message;
  bool success;

  StripeTransactionResponse({this.message, this.success});
}

class StripeService {
  static String apiBase = 'https://api.stripe.com/v1';
  static String paymentAPIURL = '${StripeService.apiBase}/payment_intents';
  static Uri paymentAPIUri = Uri.parse(paymentAPIURL);
  static String keySecret = env['STRIPE_SECRET_KEY'];

  static Map<String, String> headers = {
    'Authorization': 'Bearer ${StripeService.keySecret}',
    'Content-type': 'application/x-www-form-urlencoded'
  };

  static init() {
    StripePayment.setOptions(StripeOptions(
        publishableKey: env['STRIPE_PUBLIC_KEY'],
        merchantId: 'test',
        androidPayMode: 'test'));
  }

  static AssetGiffyDialog showDialogResponse(
      BuildContext context, String title, dynamic message, bool success) {
    return AssetGiffyDialog(
      image:
          Image.asset(success ? 'assets/gif/thanks.gif' : 'assets/gif/sad.gif'),
      buttonOkColor: Colors.amber,
      buttonOkText: Text('Continuar', style: TextStyle(color: Colors.white)),
      title: Text(
        title,
        style: TextStyle(fontSize: 20.0, fontWeight: FontWeight.w600),
      ),
      description: Text(
        message,
        textAlign: TextAlign.center,
        style: TextStyle(fontSize: 15.0, fontWeight: FontWeight.w400),
      ),
      entryAnimation: EntryAnimation.TOP,
      onlyOkButton: true,
      onOkButtonPressed: () {
        Navigator.canPop(context) ? Navigator.pop(context) : null;
      },
    );
  }

  static Future<Map<String, dynamic>> createPaymentIntent(
      String amount, String currency) async {
    try {
      Map<String, dynamic> body = {"amount": amount, "currency": currency};
      var response =
          await http.post(paymentAPIUri, headers: headers, body: body);
      return jsonDecode(response.body);
    } catch (error) {
      print('Ocurrió un error con el método de pago $error');
    }
    return null;
  }

  static Future<AssetGiffyDialog> payWithNewCard(BuildContext context,
      {String amount, String currency}) async {
    try {
      var paymentMethod = await StripePayment.paymentRequestWithCardForm(
          CardFormPaymentRequest());
      var paymentIntent =
          await StripeService.createPaymentIntent(amount, currency);
      var response = await StripePayment.confirmPaymentIntent(PaymentIntent(
          clientSecret: paymentIntent['client_secret'],
          paymentMethodId: paymentMethod.id));
      // return showDialogResponse(response, 'La transacción se realizo con éxito');
      if (response.status == 'succeeded') {
        // return StripeTransactionResponse(
        //     message: 'La transacción se realizo con éxito', success: true);
        return showDialogResponse(
            context, '¡Gracias!', 'La transacción se realizo con éxito', true);
      } else {
        // return StripeTransactionResponse(
        //     message: 'La transacción tuvo algún error', success: false);
        return showDialogResponse(
            context, '¡Error!', 'La transacción tuvo algún error', false);
      }
    } on PlatformException catch (error) {
      // return StripeService.getPlatformExceptionErrorResult(error);
      String message = 'Algo salió mal';
      if (error.code == 'cancelled') {
        message = 'Ha cancelado la transacción';
      }

      return showDialogResponse(
          context, '¡Transacción cancelada!', message, false);
    } catch (error) {
      // return StripeTransactionResponse(
      //     message: 'La transacción tuvo algún error : $error', success: false);
      return showDialogResponse(context, '¡Error!',
          'La transacción tuvo algún error : $error', false);
    }
  }

  // static getPlatformExceptionErrorResult(err) {
  //   String message = 'Algo salió mal';
  //   if (err.code == 'cancelled') {
  //     message = 'Transacción cancelada';
  //   }

  //   // return new StripeTransactionResponse(message: message, success: false);
  //   return showDialogResponse(message, false);
  // }
}
