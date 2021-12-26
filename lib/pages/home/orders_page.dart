import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:cool_alert/cool_alert.dart';
import 'package:ecommerce_application/providers/orders_provider.dart';
import 'package:ecommerce_application/utilities/my_app_icons.dart';
import 'package:ecommerce_application/widgets/orders_page/orders_empty.dart';
import 'package:ecommerce_application/widgets/orders_page/order_products.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class OrdersPage extends StatelessWidget {
  static const routeName = '/OrdersPage';

  @override
  Widget build(BuildContext context) {
    final ordersProvider = Provider.of<OrdersProvider>(context);
    final FirebaseAuth _auth = FirebaseAuth.instance;
    User _user = _auth.currentUser;
    var _uidUser = _user.uid;
    return FutureBuilder(
        future: ordersProvider.fetchOrders(),
        builder: (context, snapshot) {
          return ordersProvider.getOrdersItems.isEmpty
              ? Scaffold(body: OrdersEmpty())
              : Scaffold(
                  appBar: AppBar(
                      backgroundColor: Theme.of(context).backgroundColor,
                      title: Text(
                          'Tus mandados (${ordersProvider.getOrdersItems.length})',
                          style: TextStyle(color: Theme.of(context).hintColor)),
                      actions: [
                        IconButton(
                            onPressed: () {
                              CoolAlert.show(
                                  context: context,
                                  title: 'Limpiar los mandados',
                                  type: CoolAlertType.confirm,
                                  confirmBtnText: 'Aceptar',
                                  cancelBtnText: 'Cancelar',
                                  confirmBtnColor: Colors.red[400],
                                  onConfirmBtnTap: () {
                                    FirebaseFirestore.instance
                                        .collection('orders')
                                        .where('userId', isEqualTo: _uidUser)
                                        .get()
                                        .then((QuerySnapshot ordersSnapshot) {
                                      ordersSnapshot.docs.forEach((orderItem) {
                                        FirebaseFirestore.instance
                                            .collection('orders')
                                            .doc(orderItem.get('orderId'))
                                            .delete();
                                      });
                                    });
                                    Navigator.pop(context);
                                  },
                                  text: '¿Deseas eliminar todos tus mandados?',
                                  animType: CoolAlertAnimType.slideInUp,
                                  backgroundColor:
                                      Theme.of(context).backgroundColor);
                            },
                            icon: Icon(MyAppIcons.trash))
                      ]),
                  body: Container(
                    child: ListView.builder(
                        itemCount: ordersProvider.getOrdersItems.length,
                        itemBuilder: (BuildContext context, int index) {
                          return ChangeNotifierProvider.value(
                              value: ordersProvider.getOrdersItems[index],
                              child: OrderProducts());
                        }),
                  ));
        });
  }
}
