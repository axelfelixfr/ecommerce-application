import 'package:flutter/material.dart';

class CartCheckout extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
        decoration: BoxDecoration(
            border: Border(top: BorderSide(color: Colors.grey, width: 0.5))),
        child: Padding(
          padding: const EdgeInsets.all(8.0),
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
                              padding: const EdgeInsets.all(8.0),
                              child: Text('Checkout',
                                  textAlign: TextAlign.center,
                                  style: TextStyle(
                                      color:
                                          Theme.of(context).textSelectionColor,
                                      fontSize: 18,
                                      fontWeight: FontWeight.w600))),
                        ))),
                Text('Total',
                    style: TextStyle(
                        color: Theme.of(context).textSelectionColor,
                        fontSize: 18,
                        fontWeight: FontWeight.w600)),
                Spacer(),
                Text('\$170.00',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                        color: Colors.blueAccent,
                        fontSize: 18,
                        fontWeight: FontWeight.w500))
              ]),
        ));
  }
}
