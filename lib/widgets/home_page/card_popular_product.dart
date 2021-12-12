import 'package:ecommerce_application/utilities/my_app_icons.dart';
import 'package:flutter/material.dart';

class CardPopularProduct extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
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
              onTap: () {},
              child: Column(children: [
                Stack(children: [
                  Container(
                    height: 160,
                    decoration: BoxDecoration(
                        image: DecorationImage(
                            image: NetworkImage(
                                'https://s1.qwant.com/thumbr/474x474/3/d/8ba8797bd23743207bcc11d77f13a4565520210c95bc1904d75ecfd33c7b94/th.jpg?u=https%3A%2F%2Ftse4.mm.bing.net%2Fth%3Fid%3DOIP.aLe3QbdQKcyWxjvfUvxQQgHaHa%26pid%3DApi&q=0&b=1&p=0&a=0'),
                            fit: BoxFit.fill)),
                  ),
                  Positioned(
                      child:
                          Icon(Icons.star_outline, color: Colors.grey.shade800),
                      right: 12,
                      top: 10),
                  Positioned(
                      child: Icon(Icons.star, color: Colors.pink),
                      right: 12,
                      top: 10),
                  Positioned(
                      child: Container(
                          padding: EdgeInsets.all(10),
                          color: Theme.of(context).backgroundColor,
                          child: Text('\$ 55',
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
                          Text('Title',
                              maxLines: 1,
                              style: TextStyle(
                                  fontSize: 18.0, fontWeight: FontWeight.bold)),
                          Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text('Description',
                                    maxLines: 2,
                                    overflow: TextOverflow.ellipsis,
                                    style: TextStyle(
                                        fontSize: 15.0,
                                        fontWeight: FontWeight.w500)),
                                Spacer(),
                                Material(
                                    color: Colors.transparent,
                                    child: InkWell(
                                        onTap: () {},
                                        borderRadius:
                                            BorderRadius.circular(30.0),
                                        child: Padding(
                                          padding: const EdgeInsets.all(2.0),
                                          child: Icon(MyAppIcons.addProduct,
                                              size: 30, color: Colors.amber),
                                        )))
                              ])
                        ]))
              ]),
            ),
          )),
    );
  }
}
