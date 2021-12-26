import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:cool_alert/cool_alert.dart';
import 'package:ecommerce_application/models/order.dart';
import 'package:ecommerce_application/widgets/market_page/inner_page/product_details.dart';
import 'package:flutter/material.dart';
import 'package:line_icons/line_icons.dart';
import 'package:provider/provider.dart';

class OrderProducts extends StatefulWidget {
  @override
  _OrderProductsState createState() => _OrderProductsState();
}

class _OrderProductsState extends State<OrderProducts> {
  @override
  Widget build(BuildContext context) {
    final informationOrder = Provider.of<Order>(context, listen: false);

    return InkWell(
      onTap: () => Navigator.pushNamed(context, ProductDetails.routeName,
          arguments: informationOrder.productId),
      child: Container(
          height: 150,
          margin: const EdgeInsets.only(top: 5, bottom: 12, left: 8, right: 8),
          decoration: BoxDecoration(
              borderRadius: BorderRadius.all(const Radius.circular(16.0)),
              color: Theme.of(context).backgroundColor),
          child: Row(children: [
            Padding(
              padding: const EdgeInsets.all(5.0),
              child: Container(
                width: 135,
                decoration: BoxDecoration(
                    image: DecorationImage(
                  image: NetworkImage(informationOrder.imageUrl),
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
                        child: Text(informationOrder.name,
                            maxLines: 2,
                            overflow: TextOverflow.ellipsis,
                            style: TextStyle(
                                fontWeight: FontWeight.w600, fontSize: 15)),
                      ),
                      Material(
                        color: Colors.transparent,
                        child: InkWell(
                            borderRadius: BorderRadius.circular(32.0),
                            onTap: () => {
                                  CoolAlert.show(
                                      context: context,
                                      title: 'Quitar mandado',
                                      type: CoolAlertType.confirm,
                                      confirmBtnText: 'Aceptar',
                                      cancelBtnText: 'Cancelar',
                                      confirmBtnColor: Colors.red[400],
                                      onConfirmBtnTap: () async {
                                        FirebaseFirestore.instance
                                            .collection('orders')
                                            .doc(informationOrder.orderId)
                                            .delete();
                                        Navigator.pop(context);
                                      },
                                      text:
                                          '¿Deseas eliminar este producto de tus mandados?',
                                      animType: CoolAlertAnimType.slideInUp,
                                      backgroundColor:
                                          Theme.of(context).backgroundColor)
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
                    Text('\$ ${informationOrder.price}',
                        style: TextStyle(
                            fontSize: 15,
                            fontWeight: FontWeight.w600,
                            color: Theme.of(context).accentColor))
                  ]),
                  Row(children: [
                    Text('Cantidad:'),
                    SizedBox(width: 5),
                    Text(informationOrder.quantity,
                        style: TextStyle(
                            fontSize: 15,
                            fontWeight: FontWeight.w600,
                            color: Theme.of(context).accentColor))
                  ]),
                  Row(children: [
                    Flexible(
                        child:
                            Text('Orden ID:', style: TextStyle(fontSize: 12))),
                    SizedBox(width: 5),
                    Flexible(
                      child: Text(informationOrder.orderId,
                          style: TextStyle(
                              fontSize: 8,
                              fontWeight: FontWeight.w600,
                              color: Theme.of(context).accentColor)),
                    )
                  ])
                ]),
              ),
            )
          ])),
    );
  }
}
