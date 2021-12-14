import 'package:ecommerce_application/models/product.dart';
import 'package:ecommerce_application/utilities/my_app_icons.dart';
import 'package:ecommerce_application/widgets/market_page/inner_page/product_details.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class CardPopularProduct extends StatelessWidget {
  // final String imageUrl;
  // final String name;
  // final String description;
  // final double price;

  // const CardPopularProduct(
  //     {Key key, this.imageUrl, this.name, this.description, this.price})
  //     : super(key: key);

  @override
  Widget build(BuildContext context) {
    final productAttributes = Provider.of<Product>(context);

    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Container(
          width: 200,
          decoration: BoxDecoration(
            color: Theme.of(context).backgroundColor,
            borderRadius: BorderRadius.only(
                bottomLeft: Radius.circular(10.0),
                bottomRight: Radius.circular(10.0)),
          ),
          child: Material(
            color: Colors.transparent,
            child: InkWell(
              borderRadius: BorderRadius.only(
                  bottomLeft: Radius.circular(10.0),
                  bottomRight: Radius.circular(10.0)),
              onTap: () => Navigator.pushNamed(
                  context, ProductDetails.routeName,
                  arguments: productAttributes.id),
              child: Column(children: [
                Stack(children: [
                  Container(
                    height: 160,
                    decoration: BoxDecoration(
                        image: DecorationImage(
                            image: NetworkImage(productAttributes.imageUrl),
                            fit: BoxFit.contain)),
                  ),
                  Positioned(
                      child:
                          Icon(Icons.star_outline, color: Colors.grey.shade800),
                      right: 12,
                      top: 10),
                  Positioned(
                      child: Icon(Icons.star, color: Colors.white),
                      right: 12,
                      top: 10),
                  Positioned(
                      child: Container(
                          padding: EdgeInsets.all(10),
                          color: Theme.of(context).backgroundColor,
                          child: Text('\$ ${productAttributes.price}',
                              style: TextStyle(
                                  color:
                                      Theme.of(context).textSelectionColor))),
                      right: 12,
                      bottom: 32),
                ]),
                Container(
                    padding: EdgeInsets.all(8.0),
                    child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(productAttributes.name,
                              maxLines: 1,
                              style: TextStyle(
                                  fontSize: 18.0, fontWeight: FontWeight.bold)),
                          Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Expanded(
                                  flex: 5,
                                  child: Text(productAttributes.description,
                                      maxLines: 2,
                                      overflow: TextOverflow.ellipsis,
                                      style: TextStyle(
                                          fontSize: 15.0,
                                          fontWeight: FontWeight.w500)),
                                ),
                                Spacer(),
                                Expanded(
                                  flex: 1,
                                  child: Material(
                                      color: Colors.transparent,
                                      child: InkWell(
                                          onTap: () {},
                                          borderRadius:
                                              BorderRadius.circular(30.0),
                                          child: Padding(
                                            padding: const EdgeInsets.all(2.0),
                                            child: Icon(MyAppIcons.addProduct,
                                                size: 30, color: Colors.amber),
                                          ))),
                                )
                              ])
                        ]))
              ]),
            ),
          )),
    );
  }
}
