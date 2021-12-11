import 'package:badges/badges.dart';
import 'package:flutter/material.dart';

class FeedsProducts extends StatefulWidget {
  @override
  _FeedsProductsState createState() => _FeedsProductsState();
}

class _FeedsProductsState extends State<FeedsProducts> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(5.0),
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
                          constraints: BoxConstraints(
                            maxHeight: 110,
                            // maxHeight: MediaQuery.of(context).size.height * 0.3),
                          ),
                          child: Image.network(
                              'https://s1.qwant.com/thumbr/474x474/3/d/8ba8797bd23743207bcc11d77f13a4565520210c95bc1904d75ecfd33c7b94/th.jpg?u=https%3A%2F%2Ftse4.mm.bing.net%2Fth%3Fid%3DOIP.aLe3QbdQKcyWxjvfUvxQQgHaHa%26pid%3DApi&q=0&b=1&p=0&a=0',
                              fit: BoxFit.fitWidth),
                        )),
                    Badge(
                      toAnimate: true,
                      animationType: BadgeAnimationType.scale,
                      shape: BadgeShape.square,
                      badgeColor: Colors.pink,
                      borderRadius:
                          BorderRadius.only(bottomRight: Radius.circular(8)),
                      badgeContent:
                          Text('New', style: TextStyle(color: Colors.white)),
                    )
                  ],
                ),
              ],
            ),
            Container(
                padding: EdgeInsets.only(left: 5),
                margin: EdgeInsets.only(bottom: 2, left: 5, right: 3),
                child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SizedBox(height: 5),
                      Text(
                        'Descripción',
                        overflow: TextOverflow.ellipsis,
                        maxLines: 2,
                        style: TextStyle(
                            fontSize: 14, fontWeight: FontWeight.w600),
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(vertical: 5.0),
                        child: Text('\$ 152.23',
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
                            Text('Cantidad: 12',
                                style: TextStyle(
                                    fontSize: 12, fontWeight: FontWeight.w600)),
                            Material(
                                color: Colors.transparent,
                                child: InkWell(
                                    onTap: () {},
                                    borderRadius: BorderRadius.circular(18.0),
                                    child: Icon(
                                      Icons.more_horiz,
                                      color: Colors.grey,
                                    )))
                          ])
                    ]))
          ])),
    );
  }
}