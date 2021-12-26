import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:ecommerce_application/models/order.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class OrdersProvider with ChangeNotifier {
  List<Order> _orders = [];
  List<Order> get getOrdersItems {
    return [..._orders];
  }

  Future<void> fetchOrders() async {
    final FirebaseAuth _auth = FirebaseAuth.instance;
    User _user = _auth.currentUser;
    var _uidUser = _user.uid;

    try {
      await FirebaseFirestore.instance
          .collection('orders')
          .where('userId', isEqualTo: _uidUser)
          .get()
          .then((QuerySnapshot ordersSnapshot) {
        _orders.clear();
        ordersSnapshot.docs.forEach((orderItem) {
          _orders.insert(
              0,
              Order(
                  orderId: orderItem.get('orderId'),
                  userId: orderItem.get('userId'),
                  productId: orderItem.get('productId'),
                  name: orderItem.get('name'),
                  price: orderItem.get('price').toString(),
                  imageUrl: orderItem.get('imageUrl'),
                  quantity: orderItem.get('quantity').toString(),
                  orderDate: orderItem.get('orderDate')));
        });
      });
    } catch (error) {
      print('Hubo el siguiente error en el provider: $error');
    }
    notifyListeners();
  }
}
