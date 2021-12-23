import 'package:cool_alert/cool_alert.dart';
import 'package:ecommerce_application/providers/cart_provider.dart';
import 'package:ecommerce_application/utilities/my_app_icons.dart';
import 'package:ecommerce_application/widgets/cart_page/cart_checkout.dart';
import 'package:ecommerce_application/widgets/cart_page/cart_empty.dart';
import 'package:ecommerce_application/widgets/cart_page/cart_products.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class CartPage extends StatelessWidget {
  static const routeName = '/CartPage';

  @override
  Widget build(BuildContext context) {
    final cartProvider = Provider.of<CartProvider>(context);

    return cartProvider.getCartItems.isEmpty
        ? Scaffold(body: CartEmpty())
        : Scaffold(
            appBar: AppBar(
                backgroundColor: Theme.of(context).backgroundColor,
                title: Text(
                    'Productos en tu carrito (${cartProvider.getCartItems.length})',
                    style: TextStyle(color: Theme.of(context).hintColor)),
                actions: [
                  IconButton(
                      onPressed: () {
                        CoolAlert.show(
                            context: context,
                            title: 'Limpiar carrito',
                            type: CoolAlertType.confirm,
                            confirmBtnText: 'Aceptar',
                            cancelBtnText: 'Cancelar',
                            confirmBtnColor: Colors.red[400],
                            onConfirmBtnTap: () {
                              cartProvider.clearCart();
                              Navigator.pop(context);
                            },
                            text: '¿Deseas limpiar tu carrito de compras?',
                            animType: CoolAlertAnimType.slideInUp,
                            backgroundColor: Theme.of(context).backgroundColor);
                      },
                      icon: Icon(MyAppIcons.trash))
                ]),
            body: Container(
              margin: EdgeInsets.only(bottom: 60),
              child: ListView.builder(
                  itemCount: cartProvider.getCartItems.length,
                  itemBuilder: (BuildContext context, int index) {
                    return ChangeNotifierProvider.value(
                        // Convertimos map en list para poder acceder con el index
                        value: cartProvider.getCartItems.values.toList()[index],
                        child: CartProducts(
                            productId: cartProvider.getCartItems.keys
                                .toList()[index]));
                    /*
                    CartProducts(
                      // Convertimos map en list para poder acceder con el index
                      id: cartProvider.getCartItems.values.toList()[index].id,
                      productId: cartProvider.getCartItems.keys.toList()[index],
                      name:
                          cartProvider.getCartItems.values.toList()[index].name,
                      price: cartProvider.getCartItems.values
                          .toList()[index]
                          .price,
                      imageUrl: cartProvider.getCartItems.values
                          .toList()[index]
                          .imageUrl,
                      quantity: cartProvider.getCartItems.values
                          .toList()[index]
                          .quantity,
                    );
                    */
                  }),
            ),
            bottomSheet: Container(
                child: CartCheckout(), margin: EdgeInsets.only(bottom: 20)),
          );
  }
}
