import 'package:carousel_pro/carousel_pro.dart';
import 'package:flutter/material.dart';

class CarouselPromos extends StatefulWidget {
  @override
  _CarouselPromosState createState() => _CarouselPromosState();
}

class _CarouselPromosState extends State<CarouselPromos> {
  List _carouselImages = [
    'assets/img/carousel/carousel_1.png',
    'assets/img/carousel/carousel_2.png',
    'assets/img/carousel/carousel_3.png',
    'assets/img/carousel/carousel_4.png',
    'assets/img/carousel/carousel_5.png'
  ];

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 190.0,
      width: double.infinity,
      child: Carousel(
        boxFit: BoxFit.fill,
        autoplay: true,
        animationCurve: Curves.fastOutSlowIn,
        animationDuration: Duration(milliseconds: 1000),
        dotSize: 5.0,
        dotIncreasedColor: Colors.pink,
        dotBgColor: Colors.transparent,
        dotPosition: DotPosition.bottomCenter,
        // dotVerticalPadding: 10.0,
        showIndicator: true,
        indicatorBgPadding: 5.0,
        images: [
          ExactAssetImage(_carouselImages[0]),
          ExactAssetImage(_carouselImages[1]),
          ExactAssetImage(_carouselImages[2]),
          ExactAssetImage(_carouselImages[3]),
          ExactAssetImage(_carouselImages[4]),
        ],
      ),
    );
  }
}
