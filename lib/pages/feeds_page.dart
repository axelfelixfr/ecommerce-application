import 'package:flutter/material.dart';
import 'package:ecommerce_application/widgets/feeds_page/feeds_products.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';

class FeedsPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: StaggeredGridView.countBuilder(
      crossAxisCount: 6,
      itemCount: 8,
      itemBuilder: (BuildContext context, int index) => FeedsProducts(),
      staggeredTileBuilder: (int index) =>
          new StaggeredTile.count(3, index.isEven ? 4 : 5),
      mainAxisSpacing: 8.0,
      crossAxisSpacing: 6.0,
    )
        /*
        GridView.count(
            crossAxisCount: 2,
            childAspectRatio: 250 / 290,
            crossAxisSpacing: 5,
            mainAxisSpacing: 5,
            children: List.generate(100, (index) {
              return FeedsProducts();
            }))
          */
        );
  }
}
