import 'package:ecommerce_application/models/product.dart';
import 'package:ecommerce_application/providers/products_provider.dart';
import 'package:flutter/material.dart';
import 'package:ecommerce_application/widgets/market_page/market_products.dart';
import 'package:line_icons/line_icons.dart';
import 'package:provider/provider.dart';

class OtherCategoriesProducts extends StatelessWidget {
  static const routeName = '/OtherCategoriesProducts';

  @override
  Widget build(BuildContext context) {
    final productsProvider =
        Provider.of<ProductsProvider>(context, listen: false);
    final otherCategory = ModalRoute.of(context).settings.arguments as String;
    List<Product> listProducts = productsProvider.findByCategory(otherCategory);

    return Scaffold(
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
            listProducts.isEmpty
                ? Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(LineIcons.loudlyCryingFace,
                          size: 80, color: Colors.amber),
                      Padding(
                        padding: const EdgeInsets.all(3.0),
                        child: Text('No hay productos aún en esta categoría',
                            textAlign: TextAlign.center,
                            style: TextStyle(fontSize: 20)),
                      ),
                    ],
                  )
                : GridView.count(
                    crossAxisCount: 2,
                    childAspectRatio: 250 / 420,
                    crossAxisSpacing: 8,
                    mainAxisSpacing: 8,
                    children: List.generate(listProducts.length, (index) {
                      return ChangeNotifierProvider.value(
                        value: listProducts[index],
                        child: MarketProducts(),
                      );
                    })));
  }
}
