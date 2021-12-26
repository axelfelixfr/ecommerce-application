import 'package:backdrop/app_bar.dart';
import 'package:backdrop/backdrop.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:ecommerce_application/pages/home/market_page.dart';
import 'package:ecommerce_application/providers/products_provider.dart';
import 'package:ecommerce_application/utilities/my_app_colors.dart';
import 'package:ecommerce_application/widgets/home_page/backlayer_menu.dart';
import 'package:ecommerce_application/widgets/home_page/carousel_promos.dart';
import 'package:ecommerce_application/widgets/home_page/inner_page/categories_navigation_rail.dart';
import 'package:ecommerce_application/widgets/home_page/card_popular_product.dart';
import 'package:ecommerce_application/widgets/home_page/list_other_categories.dart';
import 'package:ecommerce_application/widgets/home_page/list_recipes.dart';
import 'package:ecommerce_application/widgets/home_page/swiper_categories.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:line_icons/line_icons.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  String _uid;
  String _userImageUrl;

  final FirebaseAuth _auth = FirebaseAuth.instance;

  @override
  void initState() {
    super.initState();
    getDataUser();
  }

  // Método para obtener información del usuario
  void getDataUser() async {
    User user = _auth.currentUser;
    _uid = user.uid;

    // Se manda a traer el documento del usuario con su información a través de su id
    final DocumentSnapshot userDoc = user.isAnonymous
        ? null
        : await FirebaseFirestore.instance.collection('users').doc(_uid).get();

    if (userDoc != null) {
      setState(() {
        _userImageUrl = userDoc.get('imageUrl');
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final productsProvider =
        Provider.of<ProductsProvider>(context, listen: false);
    productsProvider.fetchProducts();
    final listPopularProducts = productsProvider.popularProducts;

    return Scaffold(
        body: Center(
            child: BackdropScaffold(
                frontLayerBackgroundColor:
                    Theme.of(context).scaffoldBackgroundColor,
                headerHeight: MediaQuery.of(context).size.height * 0.25,
                appBar: BackdropAppBar(
                  // title: Text("Mercado a Distancia"),
                  title: Image.asset(
                      'assets/img/logo/MercadoADistanciaAppBar.png'),
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
                                backgroundImage: NetworkImage(_userImageUrl ??
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
                                child: Row(
                                  children: [
                                    Text('Ver todo',
                                        style: TextStyle(
                                            fontWeight: FontWeight.w800,
                                            fontSize: 15,
                                            color: MyAppColors.cartColor)),
                                    Icon(LineIcons.chevronRight,
                                        color: MyAppColors.cartColor)
                                  ],
                                ))
                          ]),
                        ),
                        SwiperCategories(),
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Text(
                            'Otras categorías',
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
                                  return ListOtherCategories(index: index);
                                },
                                itemCount: 6)),
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Row(children: [
                            Text('Lo más vendido',
                                style: TextStyle(
                                    fontWeight: FontWeight.w800, fontSize: 20)),
                            Spacer(),
                            FlatButton(
                                onPressed: () {
                                  Navigator.of(context).pushNamed(
                                      MarketPage.routeName,
                                      arguments: 'popular');
                                },
                                child: Row(
                                  children: [
                                    Text('Ver todo',
                                        style: TextStyle(
                                            fontWeight: FontWeight.w800,
                                            fontSize: 15,
                                            color: MyAppColors.cartColor)),
                                    Icon(LineIcons.chevronRight,
                                        color: MyAppColors.cartColor)
                                  ],
                                ))
                          ]),
                        ),
                        Container(
                            width: double.infinity,
                            height: 285,
                            margin: EdgeInsets.symmetric(horizontal: 3),
                            child: ListView.builder(
                                scrollDirection: Axis.horizontal,
                                itemCount: listPopularProducts.length,
                                itemBuilder: (BuildContext context, int index) {
                                  return ChangeNotifierProvider.value(
                                      value: listPopularProducts[index],
                                      child: CardPopularProduct()
                                      /* 
                                    CardPopularProduct(
                                        name: listPopularProducts[index].name,
                                        imageUrl:
                                            listPopularProducts[index].imageUrl,
                                        price: listPopularProducts[index].price,
                                        description: listPopularProducts[index]
                                            .description
                                        ),*/
                                      );
                                })),
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
                      ]),
                ))));
  }
}
