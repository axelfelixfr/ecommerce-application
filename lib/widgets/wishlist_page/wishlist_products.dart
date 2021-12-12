import 'package:ecommerce_application/utilities/my_app_colors.dart';
import 'package:flutter/material.dart';
import 'package:line_icons/line_icons.dart';

class WishlistProducts extends StatefulWidget {
  @override
  _WishlistProductsState createState() => _WishlistProductsState();
}

class _WishlistProductsState extends State<WishlistProducts> {
  @override
  Widget build(BuildContext context) {
    return Stack(children: <Widget>[
      Container(
          width: double.infinity,
          margin: EdgeInsets.only(right: 30.0, bottom: 10.0),
          child: Material(
              color: Theme.of(context).backgroundColor,
              borderRadius: BorderRadius.circular(5.0),
              elevation: 3.0,
              child: InkWell(
                  onTap: () {},
                  child: Container(
                      padding: EdgeInsets.all(16.0),
                      child: Row(children: <Widget>[
                        Container(
                            height: 80,
                            child: Image.network(
                                'https://s1.qwant.com/thumbr/474x474/3/d/8ba8797bd23743207bcc11d77f13a4565520210c95bc1904d75ecfd33c7b94/th.jpg?u=https%3A%2F%2Ftse4.mm.bing.net%2Fth%3Fid%3DOIP.aLe3QbdQKcyWxjvfUvxQQgHaHa%26pid%3DApi&q=0&b=1&p=0&a=0')),
                        SizedBox(width: 10),
                        Expanded(
                            child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            Text('title',
                                style: TextStyle(
                                    fontSize: 16.0,
                                    fontWeight: FontWeight.bold)),
                            SizedBox(height: 20.0),
                            Text('\$ 16',
                                style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontSize: 18.0))
                          ],
                        ))
                      ]))))),
      positionedRemove(),
    ]);
  }

  Widget positionedRemove() {
    return Positioned(
        top: 20,
        right: 15,
        child: Container(
          height: 30,
          width: 30,
          child: MaterialButton(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(5.0),
            ),
            padding: EdgeInsets.all(0.0),
            color: MyAppColors.favColor,
            child: Icon(LineIcons.times, color: Colors.white),
            onPressed: () {},
          ),
        ));
  }
}
