import 'package:badges/badges.dart';
import 'package:ecommerce_application/widgets/market_page/inner_page/product_modal.dart';
import 'package:flutter/material.dart';
import 'package:ecommerce_application/models/product.dart';
import 'inner_page/product_details.dart';
import 'package:provider/provider.dart';

class MarketProducts extends StatefulWidget {
  @override
  _MarketProductsState createState() => _MarketProductsState();
}

class _MarketProductsState extends State<MarketProducts> {
  @override
  Widget build(BuildContext context) {
    final productAttributes = Provider.of<Product>(context);

    return Padding(
      padding: const EdgeInsets.all(5.0),
      child: InkWell(
        onTap: () => Navigator.pushNamed(context, ProductDetails.routeName,
            arguments: productAttributes.id),
        child: Container(
            width: 250,
            height: 290,
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(6),
                color: Theme.of(context).backgroundColor),
            child: Column(children: [
              Column(
                children: [
                  Stack(
                    children: [
                      ClipRRect(
                          borderRadius: BorderRadius.circular(2),
                          child: Container(
                            width: double.infinity,
                            height: MediaQuery.of(context).size.height * 0.3,
                            // constraints: BoxConstraints(
                            // maxHeight: 110,
                            // maxHeight: MediaQuery.of(context).size.height * 0.3),
                            // ),
                            child: Image.network(
                                // 'https://s1.qwant.com/thumbr/474x474/3/d/8ba8797bd23743207bcc11d77f13a4565520210c95bc1904d75ecfd33c7b94/th.jpg?u=https%3A%2F%2Ftse4.mm.bing.net%2Fth%3Fid%3DOIP.aLe3QbdQKcyWxjvfUvxQQgHaHa%26pid%3DApi&q=0&b=1&p=0&a=0',
                                // fit: BoxFit.fitWidth
                                productAttributes.imageUrl),
                          )),
                      Badge(
                        toAnimate: true,
                        animationType: BadgeAnimationType.scale,
                        shape: BadgeShape.square,
                        badgeColor: Colors.pink,
                        borderRadius:
                            BorderRadius.only(bottomRight: Radius.circular(8)),
                        badgeContent: Text('Nuevo',
                            style: TextStyle(color: Colors.white)),
                      )
                    ],
                  ),
                ],
              ),
              Container(
                  padding: EdgeInsets.only(left: 5),
                  margin: EdgeInsets.only(bottom: 0, left: 5, right: 3),
                  child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        SizedBox(height: 1),
                        Text(
                          productAttributes.description,
                          overflow: TextOverflow.ellipsis,
                          maxLines: 1,
                          style: TextStyle(
                              fontSize: 14, fontWeight: FontWeight.w600),
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(vertical: 5.0),
                          child: Text('\$ ${productAttributes.price}',
                              overflow: TextOverflow.ellipsis,
                              maxLines: 2,
                              style: TextStyle(
                                  fontSize: 17,
                                  color: Theme.of(context).accentColor,
                                  fontWeight: FontWeight.w800)),
                        ),
                        Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text('Cantidad: ${productAttributes.quantity}',
                                  style: TextStyle(
                                      fontSize: 12,
                                      fontWeight: FontWeight.w600)),
                              Material(
                                  color: Colors.transparent,
                                  child: InkWell(
                                      onTap: () async {
                                        showDialog(
                                            context: context,
                                            builder: (BuildContext context) =>
                                                ProductModal(
                                                    productId:
                                                        productAttributes.id));
                                      },
                                      borderRadius: BorderRadius.circular(18.0),
                                      child: Icon(
                                        Icons.more_horiz,
                                        color: Colors.grey,
                                      )))
                            ])
                      ]))
            ])),
      ),
    );
  }
}
