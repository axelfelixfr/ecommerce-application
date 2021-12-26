import 'package:badges/badges.dart';
import 'package:ecommerce_application/models/product.dart';
import 'package:ecommerce_application/providers/cart_provider.dart';
import 'package:ecommerce_application/providers/products_provider.dart';
import 'package:ecommerce_application/providers/wishlist_provider.dart';
import 'package:ecommerce_application/utilities/my_app_colors.dart';
import 'package:ecommerce_application/utilities/my_app_icons.dart';
import 'package:flutter/material.dart';
import 'package:ecommerce_application/widgets/market_page/market_products.dart';
import 'package:provider/provider.dart';

import 'cart_page.dart';
import 'wishlist_page.dart';

class MarketPage extends StatefulWidget {
  static const routeName = '/MarketPage';

  @override
  _MarketPageState createState() => _MarketPageState();
}

class _MarketPageState extends State<MarketPage> {
  Future<void> _getProductsOnRefresh() async {
    await Provider.of<ProductsProvider>(context, listen: false).fetchProducts();
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    final popular = ModalRoute.of(context).settings.arguments as String;
    final productsProvider = Provider.of<ProductsProvider>(context);
    List<Product> listProducts = productsProvider.products;
    if (popular == 'popular') {
      listProducts = productsProvider.popularProducts;
    }

    return Scaffold(
        appBar: AppBar(
            title: Text('Nuestro mercado'),
            backgroundColor: Theme.of(context).cardColor,
            actions: [
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
                    icon:
                        Icon(MyAppIcons.wishlist, color: MyAppColors.favColor),
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
                    icon:
                        Icon(MyAppIcons.shopping, color: MyAppColors.cartColor),
                    onPressed: () {
                      Navigator.of(context).pushNamed(CartPage.routeName);
                    },
                  ),
                ),
              ),
            ]),
        body:
            /* StaggeredGridView.countBuilder(
      crossAxisCount: 6,
      itemCount: 8,
      itemBuilder: (BuildContext context, int index) => MarketProducts(),
      staggeredTileBuilder: (int index) =>
          new StaggeredTile.count(3, index.isEven ? 4 : 5),
      mainAxisSpacing: 8.0,
      crossAxisSpacing: 6.0,
    )*/
            RefreshIndicator(
          onRefresh: _getProductsOnRefresh,
          child: GridView.count(
              crossAxisCount: 2,
              childAspectRatio: 250 / 420,
              crossAxisSpacing: 8,
              mainAxisSpacing: 8,
              children: List.generate(listProducts.length, (index) {
                return ChangeNotifierProvider.value(
                  value: listProducts[index],
                  child: MarketProducts(),
                );
              })),
        ));
  }
}
