import 'package:backdrop/app_bar.dart';
import 'package:backdrop/backdrop.dart';
import 'package:ecommerce_application/utilities/my_app_colors.dart';
import 'package:ecommerce_application/widgets/home_page/backlayer_menu.dart';
import 'package:ecommerce_application/widgets/home_page/carousel_promos.dart';
import 'package:ecommerce_application/widgets/home_page/inner_page/categories_navigation_rail.dart';
import 'package:ecommerce_application/widgets/home_page/card_popular_product.dart';
import 'package:ecommerce_application/widgets/home_page/list_recipes.dart';
import 'package:ecommerce_application/widgets/home_page/swiper_categories.dart';
import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Center(
            child: BackdropScaffold(
                frontLayerBackgroundColor:
                    Theme.of(context).scaffoldBackgroundColor,
                headerHeight: MediaQuery.of(context).size.height * 0.25,
                appBar: BackdropAppBar(
                  title: Text("Inicio"),
                  leading: BackdropToggleButton(icon: AnimatedIcons.home_menu),
                  flexibleSpace: Container(
                      decoration:
                          // BoxDecoration(color: Theme.of(context).backgroundColor)
                          BoxDecoration(
                              gradient: LinearGradient(
                                  colors: [
                                    MyAppColors.gradiendYStart,
                                    MyAppColors.gradiendYEnd
                                  ],
                                  begin: const FractionalOffset(0.0, 0.0),
                                  end: const FractionalOffset(7.0, 0.0),
                                  stops: [0.0, 0.1],
                                  tileMode: TileMode.mirror))),
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
                backLayer: BackLayerMenu(),
                frontLayer: SingleChildScrollView(
                  child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        CarouselPromos(),
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
                                    CategoriesNavigationRail.routeName,
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
                        SwiperCategories(),
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
                                  return ListRecipes(index: index);
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
                                  return CardPopularProduct();
                                }))
                      ]),
                ))));
  }
}
