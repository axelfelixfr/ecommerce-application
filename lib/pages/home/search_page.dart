import 'package:ecommerce_application/models/product.dart';
import 'package:ecommerce_application/providers/products_provider.dart';
import 'package:ecommerce_application/utilities/my_app_colors.dart';
import 'package:ecommerce_application/widgets/market_page/market_products.dart';
import 'package:ecommerce_application/widgets/search_page/header_search.dart';
import 'package:flutter/material.dart';
import 'package:line_icons/line_icons.dart';
import 'package:provider/provider.dart';

class SearchPage extends StatefulWidget {
  static const routeName = '/SearchPage';

  @override
  _SearchPageState createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> {
  TextEditingController _searchTextController;
  final FocusNode _node = new FocusNode();

  @override
  void initState() {
    super.initState();
    _searchTextController = TextEditingController();
    _searchTextController.addListener(() {
      setState(() {});
    });
  }

  @override
  void dispose() {
    super.dispose();
    _node.dispose();
    _searchTextController.dispose();
  }

  List<Product> _searchList = [];

  @override
  Widget build(BuildContext context) {
    final productsProvider = Provider.of<ProductsProvider>(context);
    final listProducts = productsProvider.products;
    return Scaffold(
        body: CustomScrollView(
      slivers: <Widget>[
        SliverPersistentHeader(
            delegate: HeaderSearch(
          stackPaddingTop: 174,
          title: RichText(
              text: TextSpan(children: [
            TextSpan(
                text: 'Buscar',
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 24))
          ])),
          stackChild: Container(
              decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.all(Radius.circular(10)),
                  boxShadow: [
                    BoxShadow(
                        color: Colors.black12, spreadRadius: 1, blurRadius: 3)
                  ]),
              margin: EdgeInsets.symmetric(horizontal: 16),
              child: TextField(
                controller: _searchTextController,
                minLines: 1,
                focusNode: _node,
                decoration: InputDecoration(
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                        borderSide:
                            BorderSide(width: 0, style: BorderStyle.none)),
                    prefixIcon: Icon(LineIcons.search),
                    hintText: 'Buscar productos',
                    filled: true,
                    fillColor: Theme.of(context).cardColor,
                    suffixIcon: IconButton(
                        icon: Icon(LineIcons.times,
                            color: _searchTextController.text.isNotEmpty
                                ? Colors.red[400]
                                : Colors.grey),
                        onPressed: _searchTextController.text.isEmpty
                            ? null
                            : () {
                                _searchTextController.clear();
                                _node.unfocus();
                              })),
                onChanged: (value) {
                  _searchTextController.text.toLowerCase();
                  setState(() {
                    _searchList = productsProvider.searchQuery(value);
                  });
                },
              )),
        )),
        SliverToBoxAdapter(
            child: _searchTextController.text.isNotEmpty && _searchList.isEmpty
                ? Column(
                    children: [
                      SizedBox(height: 30),
                      Icon(LineIcons.search, size: 45),
                      SizedBox(height: 30),
                      Text('No se encontraron productos',
                          style: TextStyle(
                              fontSize: 15, fontWeight: FontWeight.w500)),
                    ],
                  )
                : GridView.count(
                    physics: NeverScrollableScrollPhysics(),
                    shrinkWrap: true,
                    crossAxisCount: 2,
                    childAspectRatio: 250 / 420,
                    crossAxisSpacing: 8,
                    mainAxisSpacing: 8,
                    children: List.generate(
                        _searchTextController.text.isEmpty
                            ? listProducts.length
                            : _searchList.length, (index) {
                      return ChangeNotifierProvider.value(
                        value: _searchTextController.text.isEmpty
                            ? listProducts[index]
                            : _searchList[index],
                        child: MarketProducts(),
                      );
                    })))
      ],
    ));
  }
}
