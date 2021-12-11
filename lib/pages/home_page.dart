import 'package:backdrop/app_bar.dart';
import 'package:backdrop/backdrop.dart';
import 'package:carousel_pro/carousel_pro.dart';
import 'package:ecommerce_application/utilities/my_app_colors.dart';
import 'package:ecommerce_application/widgets/home_page/inner_page/brand_navigation_rail.dart';
import 'package:ecommerce_application/widgets/home_page/popular_products.dart';
import 'package:ecommerce_application/widgets/home_page/recipes.dart';
import 'package:flutter/material.dart';
import 'package:flutter_swiper/flutter_swiper.dart';

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

  List _swiperImages = [
    'assets/img/swiper_1.png',
    'assets/img/swiper_2.png',
    'assets/img/swiper_3.png',
    'assets/img/swiper_4.png',
    'assets/img/swiper_5.png'
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Center(
            child: BackdropScaffold(
                frontLayerBackgroundColor:
                    Theme.of(context).scaffoldBackgroundColor,
                headerHeight: MediaQuery.of(context).size.height * 0.25,
                appBar: BackdropAppBar(
                  title: Text("Home"),
                  leading: BackdropToggleButton(icon: AnimatedIcons.home_menu),
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
                frontLayer: SingleChildScrollView(
                  child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Container(
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
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Row(children: [
                            Text('Categorías',
                                style: TextStyle(
                                    fontWeight: FontWeight.w800, fontSize: 20)),
                            Spacer(),
                            FlatButton(
                                onPressed: () {
                                  Navigator.of(context).pushNamed(
                                    BrandNavigationRailScreen.routeName,
                                    arguments: {
                                      5,
                                    },
                                  );
                                },
                                child: Text('Ver todo...',
                                    style: TextStyle(
                                        fontWeight: FontWeight.w800,
                                        fontSize: 15,
                                        color: Colors.pink)))
                          ]),
                        ),
                        Container(
                            height: 190,
                            width: MediaQuery.of(context).size.width,
                            child: Swiper(
                              itemCount: _swiperImages.length,
                              autoplay: true,
                              viewportFraction: 0.7,
                              scale: 0.85,
                              onTap: (index) {
                                Navigator.of(context).pushNamed(
                                  BrandNavigationRailScreen.routeName,
                                  arguments: {
                                    index,
                                  },
                                );
                              },
                              itemBuilder: (BuildContext context, int index) {
                                return ClipRRect(
                                  borderRadius: BorderRadius.circular(10),
                                  child: Container(
                                    color: Color.fromARGB(255, 235, 235, 235),
                                    child: Image.asset(
                                      _swiperImages[index],
                                      // fit: BoxFit.fill
                                    ),
                                  ),
                                );
                              },
                            )),
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Text(
                            'Recetas',
                            style: TextStyle(
                                fontWeight: FontWeight.w800, fontSize: 20),
                          ),
                        ),
                        Container(
                            width: double.infinity,
                            height: 180,
                            child: ListView.builder(
                                scrollDirection: Axis.horizontal,
                                itemBuilder: (BuildContext context, int index) {
                                  return RecipesWidget(index: index);
                                },
                                itemCount: 7)),
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Row(children: [
                            Text('Lo más vendido',
                                style: TextStyle(
                                    fontWeight: FontWeight.w800, fontSize: 20)),
                            Spacer(),
                            FlatButton(
                                onPressed: () {},
                                child: Text('Ver todo...',
                                    style: TextStyle(
                                        fontWeight: FontWeight.w800,
                                        fontSize: 15,
                                        color: Colors.pink)))
                          ]),
                        ),
                        Container(
                            width: double.infinity,
                            height: 285,
                            margin: EdgeInsets.symmetric(horizontal: 3),
                            child: ListView.builder(
                                scrollDirection: Axis.horizontal,
                                itemCount: 8,
                                itemBuilder: (BuildContext context, int index) {
                                  return PopularProducts();
                                }))
                      ]),
                ))));
  }
}
