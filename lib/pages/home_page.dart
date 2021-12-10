import 'package:backdrop/app_bar.dart';
import 'package:backdrop/backdrop.dart';
import 'package:carousel_pro/carousel_pro.dart';
import 'package:ecommerce_application/utilities/my_app_colors.dart';
import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  List _carouselImages = [
    'assets/img/carousel_1.png',
    'assets/img/carousel_2.png',
    'assets/img/carousel_3.png',
    'assets/img/carousel_4.png',
    'assets/img/carousel_5.png'
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Center(
            child: BackdropScaffold(
      headerHeight: MediaQuery.of(context).size.height * 0.25,
      appBar: BackdropAppBar(
        title: Text("Home"),
        leading: BackdropToggleButton(icon: AnimatedIcons.arrow_menu),
        flexibleSpace: Container(
            decoration:
                // BoxDecoration(color: Theme.of(context).backgroundColor)
                BoxDecoration(
                    gradient: LinearGradient(colors: [
          MyAppColors.gradiendYStart,
          MyAppColors.gradiendYEnd
        ]))),
        actions: <Widget>[
          IconButton(
              iconSize: 15,
              padding: const EdgeInsets.all(10),
              icon: CircleAvatar(
                  radius: 15,
                  backgroundColor: Colors.white,
                  child: CircleAvatar(
                      radius: 13,
                      backgroundImage: NetworkImage(
                          'https://t3.ftcdn.net/jpg/01/83/55/76/240_F_183557656_DRcvOesmfDl5BIyhPKrcWANFKy2964i9.jpg'))),
              onPressed: () {}),
        ],
      ),
      backLayer: Center(
        child: Text("Back Layer"),
      ),
      frontLayer: Container(
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
      ),
    )));
  }
}
