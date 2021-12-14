import 'package:ecommerce_application/models/product.dart';
import 'package:ecommerce_application/providers/products_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'category_rail.dart';

class CategoriesNavigationRail extends StatefulWidget {
  CategoriesNavigationRail({Key key}) : super(key: key);

  static const routeName = '/CategoriesNavigationRail';
  @override
  _CategoriesNavigationRailState createState() =>
      _CategoriesNavigationRailState();
}

class _CategoriesNavigationRailState extends State<CategoriesNavigationRail> {
  int _selectedIndex = 0;
  final padding = 8.0;
  String routeArgs;
  String category;
  @override
  void didChangeDependencies() {
    routeArgs = ModalRoute.of(context).settings.arguments.toString();
    _selectedIndex = int.parse(
      routeArgs.substring(1, 2),
    );
    print(routeArgs.toString());
    if (_selectedIndex == 0) {
      setState(() {
        category = 'Verdura';
      });
    }
    if (_selectedIndex == 1) {
      setState(() {
        category = 'Fruta';
      });
    }
    if (_selectedIndex == 2) {
      setState(() {
        category = 'Carne';
      });
    }
    if (_selectedIndex == 3) {
      setState(() {
        category = 'Pollo';
      });
    }
    if (_selectedIndex == 4) {
      setState(() {
        category = 'Pescado';
      });
    }
    if (_selectedIndex == 5) {
      setState(() {
        category = 'Todo';
      });
    }
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Row(
        children: <Widget>[
          LayoutBuilder(
            builder: (context, constraint) {
              return SingleChildScrollView(
                child: ConstrainedBox(
                  constraints: BoxConstraints(minHeight: constraint.maxHeight),
                  child: IntrinsicHeight(
                    child: NavigationRail(
                      minWidth: 56.0,
                      groupAlignment: 1.0,
                      selectedIndex: _selectedIndex,
                      onDestinationSelected: (int index) {
                        setState(() {
                          _selectedIndex = index;
                          if (_selectedIndex == 0) {
                            setState(() {
                              category = 'Verdura';
                            });
                          }
                          if (_selectedIndex == 1) {
                            setState(() {
                              category = 'Fruta';
                            });
                          }
                          if (_selectedIndex == 2) {
                            setState(() {
                              category = 'Carne';
                            });
                          }
                          if (_selectedIndex == 3) {
                            setState(() {
                              category = 'Pollo';
                            });
                          }
                          if (_selectedIndex == 4) {
                            setState(() {
                              category = 'Pescado';
                            });
                          }
                          if (_selectedIndex == 5) {
                            setState(() {
                              category = 'Todo';
                            });
                          }
                          print(category);
                        });
                      },
                      labelType: NavigationRailLabelType.all,
                      leading: Column(
                        children: <Widget>[
                          SizedBox(
                            height: 20,
                          ),
                          Center(
                            child: CircleAvatar(
                              radius: 16,
                              backgroundImage: NetworkImage(
                                  "https://cdn1.vectorstock.com/i/thumb-large/62/60/default-avatar-photo-placeholder-profile-image-vector-21666260.jpg"),
                            ),
                          ),
                          SizedBox(
                            height: 80,
                          ),
                        ],
                      ),
                      selectedLabelTextStyle: TextStyle(
                        color: Colors.pink,
                        fontSize: 20,
                        letterSpacing: 1,
                        // decoration: TextDecoration.lineThrough,
                        // decorationThickness: 2,
                      ),
                      unselectedLabelTextStyle: TextStyle(
                        fontSize: 15,
                        letterSpacing: 0.8,
                      ),
                      destinations: [
                        buildRotatedTextRailDestination("Verdura 🥬", padding),
                        buildRotatedTextRailDestination("Fruta 🍉", padding),
                        buildRotatedTextRailDestination("Carne 🥩", padding),
                        buildRotatedTextRailDestination("Pollo 🍗", padding),
                        buildRotatedTextRailDestination("Pescado 🍤", padding),
                        buildRotatedTextRailDestination("Todo 🛒", padding),
                      ],
                    ),
                  ),
                ),
              );
            },
          ),
          // This is the main content.

          ContentSpace(context, category)
        ],
      ),
    );
  }
}

NavigationRailDestination buildRotatedTextRailDestination(
    String text, double padding) {
  return NavigationRailDestination(
    icon: SizedBox.shrink(),
    label: Padding(
      padding: EdgeInsets.symmetric(vertical: padding),
      child: RotatedBox(
        quarterTurns: -1,
        child: Text(text),
      ),
    ),
  );
}

class ContentSpace extends StatelessWidget {
  // final int _selectedIndex;

  final String category;
  ContentSpace(BuildContext context, this.category);

  @override
  Widget build(BuildContext context) {
    final productsProvider =
        Provider.of<ProductsProvider>(context, listen: false);
    List<Product> listProductsForCategory =
        productsProvider.findByCategory(category);
    // Si se selecciona 'Todo', entonces iteramos todos los productos que existen en productsProvider
    if (category == 'Todo') {
      for (int i = 0; i < productsProvider.products.length; i++) {
        listProductsForCategory.add(productsProvider.products[i]);
      }
    }

    return Expanded(
      child: Padding(
        padding: const EdgeInsets.fromLTRB(24, 8, 0, 0),
        child: MediaQuery.removePadding(
          removeTop: true,
          context: context,
          child: ListView.builder(
            itemCount: listProductsForCategory.length,
            itemBuilder: (BuildContext context, int index) =>
                ChangeNotifierProvider.value(
                    value: listProductsForCategory[index],
                    child: CategoryRail()),
          ),
        ),
      ),
    );
  }
}
