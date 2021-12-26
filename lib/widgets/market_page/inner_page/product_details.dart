import 'package:badges/badges.dart';
import 'package:ecommerce_application/pages/home/cart_page.dart';
import 'package:ecommerce_application/pages/home/wishlist_page.dart';
import 'package:ecommerce_application/providers/cart_provider.dart';
import 'package:ecommerce_application/providers/dark_theme_provider.dart';
import 'package:ecommerce_application/providers/products_provider.dart';
import 'package:ecommerce_application/providers/wishlist_provider.dart';
import 'package:ecommerce_application/utilities/my_app_colors.dart';
import 'package:ecommerce_application/utilities/my_app_icons.dart';
import 'package:ecommerce_application/widgets/market_page/market_products.dart';
import 'package:flutter/material.dart';
import 'package:line_icons/line_icons.dart';
import 'package:provider/provider.dart';

class ProductDetails extends StatefulWidget {
  static const routeName = '/ProductDetails';

  @override
  _ProductDetailsState createState() => _ProductDetailsState();
}

class _ProductDetailsState extends State<ProductDetails> {
  GlobalKey previewContainer = new GlobalKey();

  @override
  Widget build(BuildContext context) {
    final themeState = Provider.of<DarkThemeProvider>(context);
    final productsProvider =
        Provider.of<ProductsProvider>(context, listen: false);
    // Buscamos al producto por su id e imprimimos su información
    final productId = ModalRoute.of(context).settings.arguments as String;
    final informationProduct = productsProvider.findByID(productId);
    // Lista de productos para sugerir otros productos
    final listProducts = productsProvider.products;
    // Provider del carrito de compras
    final cartProvider = Provider.of<CartProvider>(context);
    // Provider para wishlist
    final wishlistProvider = Provider.of<WishlistProvider>(context);

    return Scaffold(
        body: Stack(children: <Widget>[
      Container(
          foregroundDecoration: BoxDecoration(color: Colors.transparent),
          height: MediaQuery.of(context).size.height * 0.47,
          width: double.infinity,
          child:
              Image.network(informationProduct.imageUrl, fit: BoxFit.fitWidth)),
      SingleChildScrollView(
          padding: const EdgeInsets.only(top: 16.0, bottom: 20.0),
          child:
              Column(crossAxisAlignment: CrossAxisAlignment.start, children: <
                  Widget>[
            const SizedBox(height: 250),
            Padding(
                padding: const EdgeInsets.all(16.0),
                child: Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: <Widget>[
                      Material(
                        color: Colors.transparent,
                        child: InkWell(
                            splashColor: Colors.amber.shade200,
                            onTap: () {},
                            borderRadius: BorderRadius.circular(30),
                            child: Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Icon(LineIcons.save,
                                    size: 23, color: Colors.black87))),
                      ),
                      Material(
                        color: Colors.transparent,
                        child: InkWell(
                            splashColor: Colors.amber.shade200,
                            onTap: () {},
                            borderRadius: BorderRadius.circular(30),
                            child: Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Icon(LineIcons.shareSquare,
                                    size: 23, color: Colors.black87))),
                      )
                    ])),
            Container(
                // padding: const EdgeInsets.all(8.0),
                color: Theme.of(context).scaffoldBackgroundColor,
                child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Padding(
                          padding: const EdgeInsets.all(16.0),
                          child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Container(
                                    width:
                                        MediaQuery.of(context).size.width * 0.9,
                                    child: Text(informationProduct.name,
                                        maxLines: 2,
                                        style: TextStyle(
                                            // color: Theme.of(context).textSelectionColor,
                                            fontSize: 28.0,
                                            fontWeight: FontWeight.w600))),
                                SizedBox(height: 8),
                                Text('\$ ${informationProduct.price}',
                                    maxLines: 2,
                                    style: TextStyle(
                                        color: themeState.darkTheme
                                            ? Theme.of(context).disabledColor
                                            : MyAppColors.subTitle,
                                        fontSize: 21.0,
                                        fontWeight: FontWeight.bold))
                              ])),
                      const SizedBox(height: 3.0),
                      Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 8.0),
                          child: Divider(
                              thickness: 1, color: Colors.grey, height: 1)),
                      const SizedBox(height: 5.0),
                      Padding(
                          padding: const EdgeInsets.all(16.0),
                          child: Text(informationProduct.description,
                              style: TextStyle(
                                  fontWeight: FontWeight.w400,
                                  fontSize: 21.0,
                                  color: themeState.darkTheme
                                      ? Theme.of(context).disabledColor
                                      : MyAppColors.subTitle))),
                      const SizedBox(height: 5.0),
                      Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 8.0),
                          child: Divider(
                              thickness: 1, color: Colors.grey, height: 1)),
                      _moreDetails(themeState.darkTheme, 'Marca: ',
                          informationProduct.distributor),
                      _moreDetails(themeState.darkTheme, 'Cantidad: ',
                          '${informationProduct.quantity}'),
                      _moreDetails(themeState.darkTheme, 'Categoría: ',
                          informationProduct.productCategoryName),
                      _moreDetails(
                          themeState.darkTheme,
                          'Popularidad: ',
                          informationProduct.isPopular
                              ? 'Es popular'
                              : 'Aún no lo es :('),
                      const SizedBox(height: 15.0),
                      Divider(thickness: 1, color: Colors.grey, height: 1),
                      const SizedBox(height: 15.0),
                      Container(
                          color: Theme.of(context).backgroundColor,
                          width: double.infinity,
                          child: Column(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                const SizedBox(height: 10),
                                Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Text('Sin reseñas aún',
                                        style: TextStyle(
                                            color: Theme.of(context)
                                                .textSelectionColor,
                                            fontWeight: FontWeight.w600,
                                            fontSize: 21.0))),
                                Padding(
                                    padding: const EdgeInsets.all(2.0),
                                    child: Text(
                                        'Sé el primero en realizar una reseña',
                                        style: TextStyle(
                                          fontWeight: FontWeight.w400,
                                          fontSize: 20,
                                        ))),
                                const SizedBox(height: 70),
                                Divider(
                                    thickness: 1,
                                    color: Colors.grey,
                                    height: 1),
                              ])),
                      // const SizedBox(height: 15.0),
                      Container(
                          width: double.infinity,
                          padding: EdgeInsets.all(8.0),
                          color: Theme.of(context).scaffoldBackgroundColor,
                          child: Text('Te sugerimos también:',
                              style: TextStyle(
                                  fontSize: 20, fontWeight: FontWeight.w700))),
                      Container(
                          margin: EdgeInsets.only(bottom: 30),
                          width: double.infinity,
                          height: 340,
                          child: ListView.builder(
                              itemCount: listProducts.length < 7
                                  ? listProducts.length
                                  : 7,
                              scrollDirection: Axis.horizontal,
                              itemBuilder: (BuildContext context, int index) {
                                return ChangeNotifierProvider.value(
                                    value: listProducts[index],
                                    child: MarketProducts());
                              }))
                    ]))
          ])),
      Positioned(
          top: 0,
          left: 0,
          right: 0,
          child: AppBar(
              backgroundColor: Colors.transparent,
              elevation: 0,
              centerTitle: true,
              title: Text('Detalle',
                  style: TextStyle(
                      color: Colors.black87,
                      fontSize: 17.0,
                      fontWeight: FontWeight.w500)),
              actions: <Widget>[
                Consumer<WishlistProvider>(
                  builder: (_, wishl, ch) => Badge(
                    badgeColor: MyAppColors.cartBadgeColor,
                    animationType: BadgeAnimationType.slide,
                    toAnimate: true,
                    position: BadgePosition.topEnd(top: 5, end: 7),
                    badgeContent: Text(
                      wishl.getWishlistItems.length.toString(),
                      style: TextStyle(color: Colors.white),
                    ),
                    child: IconButton(
                      icon: Icon(MyAppIcons.wishlist,
                          color: MyAppColors.favColor),
                      onPressed: () {
                        Navigator.of(context).pushNamed(WishlistPage.routeName);
                      },
                    ),
                  ),
                ),
                Consumer<CartProvider>(
                  builder: (_, cart, ch) => Badge(
                    badgeColor: MyAppColors.cartBadgeColor,
                    animationType: BadgeAnimationType.slide,
                    toAnimate: true,
                    position: BadgePosition.topEnd(top: 5, end: 7),
                    badgeContent: Text(
                      cart.getCartItems.length.toString(),
                      style: TextStyle(color: Colors.white),
                    ),
                    child: IconButton(
                      icon: Icon(MyAppIcons.shopping,
                          color: MyAppColors.cartColor),
                      onPressed: () {
                        Navigator.of(context).pushNamed(CartPage.routeName);
                      },
                    ),
                  ),
                ),
              ])),
      Align(
          alignment: Alignment.bottomRight,
          child: Row(children: [
            Expanded(
                flex: 3,
                child: Container(
                    height: 50,
                    child: RaisedButton(
                      materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
                      shape: RoundedRectangleBorder(side: BorderSide.none),
                      color: Colors.redAccent.shade400,
                      /* 
                      child: Text(
                        cartProvider.getCartItems.containsKey(productId)
                            ? 'In cart'
                            : 'Add to Cart'.toUpperCase(),
                        style: TextStyle(fontSize: 16, color: Colors.white),
                      ),
                      */
                      child: Text(
                          cartProvider.getCartItems.containsKey(productId)
                              ? 'Ya esta en tu carrito'.toUpperCase()
                              : 'Agregar al carrito'.toUpperCase(),
                          style: TextStyle(fontSize: 13, color: Colors.white)),
                      onPressed:
                          cartProvider.getCartItems.containsKey(productId)
                              ? () {}
                              : () {
                                  cartProvider.addProductToCart(
                                      productId,
                                      informationProduct.price,
                                      informationProduct.name,
                                      informationProduct.imageUrl);
                                },
                    ))),
            Expanded(
                flex: 2,
                child: Container(
                    height: 50,
                    child: RaisedButton(
                      materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
                      shape: RoundedRectangleBorder(side: BorderSide.none),
                      color: Theme.of(context).backgroundColor,
                      child: Row(
                        children: [
                          Text('Comprar'.toUpperCase(),
                              style: TextStyle(
                                  fontSize: 12,
                                  color: Theme.of(context).textSelectionColor)),
                          SizedBox(width: 5),
                          Icon(LineIcons.creditCard,
                              color: Colors.green.shade700, size: 19)
                        ],
                      ),
                      onPressed: () {},
                    ))),
            Expanded(
                flex: 1,
                child: Container(
                    height: 50,
                    color: themeState.darkTheme
                        ? Theme.of(context).disabledColor
                        : MyAppColors.subTitle,
                    child: InkWell(
                      splashColor: MyAppColors.favColor,
                      child: Center(
                          child: Icon(
                              wishlistProvider.getWishlistItems
                                      .containsKey(productId)
                                  ? Icons.favorite
                                  : MyAppIcons.wishlist,
                              color: wishlistProvider.getWishlistItems
                                      .containsKey(productId)
                                  ? Colors.redAccent
                                  : Colors.white)),
                      onTap: () {
                        wishlistProvider.addAndRemoveFromWishlist(
                            productId,
                            informationProduct.price,
                            informationProduct.name,
                            informationProduct.imageUrl);
                      },
                    ))),
          ]))
    ]));
  }

  Widget _moreDetails(bool themeState, String nameProduct, String infoProduct) {
    return Padding(
        padding: const EdgeInsets.only(top: 15, left: 16, right: 16),
        child: Row(mainAxisAlignment: MainAxisAlignment.start, children: [
          Text(nameProduct,
              style: TextStyle(
                  color: Theme.of(context).textSelectionColor,
                  fontWeight: FontWeight.w600,
                  fontSize: 21.0)),
          Text(infoProduct,
              style: TextStyle(
                  color: themeState
                      ? Theme.of(context).disabledColor
                      : MyAppColors.subTitle,
                  fontWeight: FontWeight.w400,
                  fontSize: 20.0)),
        ]));
  }
}
