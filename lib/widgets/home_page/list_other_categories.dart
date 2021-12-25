import 'package:flutter/material.dart';

import 'inner_page/other_categories_products.dart';

class ListOtherCategories extends StatefulWidget {
  ListOtherCategories({Key key, this.index}) : super(key: key);

  final int index;

  @override
  _ListOtherCategoriesState createState() => _ListOtherCategoriesState();
}

class _ListOtherCategoriesState extends State<ListOtherCategories> {
  List<Map<String, Object>> otherCategories = [
    {
      'otherCategoryName': 'Bebidas',
      'otherCategoryImagesPath':
          'assets/img/other_categories/otros_bebidas.jpg',
    },
    {
      'otherCategoryName': 'Higiene personal',
      'otherCategoryImagesPath':
          'assets/img/other_categories/otros_higiene_personal.jpg',
    },
    {
      'otherCategoryName': 'Legumbres',
      'otherCategoryImagesPath':
          'assets/img/other_categories/otros_legumbres.jpg',
    },
    {
      'otherCategoryName': 'Mascotas',
      'otherCategoryImagesPath':
          'assets/img/other_categories/otros_mascotas.jpg',
    },
    {
      'otherCategoryName': 'Pan',
      'otherCategoryImagesPath': 'assets/img/other_categories/otros_pan.png',
    },
    {
      'otherCategoryName': 'Quesos',
      'otherCategoryImagesPath': 'assets/img/other_categories/otros_quesos.png',
    }
  ];

  @override
  Widget build(BuildContext context) {
    return Stack(children: [
      InkWell(
        onTap: () {
          Navigator.of(context).pushNamed(OtherCategoriesProducts.routeName,
              arguments:
                  '${otherCategories[widget.index]['otherCategoryName']}');
        },
        child: Container(
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                image: DecorationImage(
                    image: AssetImage(otherCategories[widget.index]
                        ['otherCategoryImagesPath']),
                    fit: BoxFit.cover)),
            margin: EdgeInsets.symmetric(horizontal: 10),
            width: 150,
            height: 150),
      ),
      Positioned(
          bottom: 0,
          left: 10,
          right: 10,
          child: Container(
              padding: EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
              color: Theme.of(context).backgroundColor,
              child: Text(otherCategories[widget.index]['otherCategoryName'],
                  style: TextStyle(
                      fontWeight: FontWeight.w500,
                      fontSize: 18,
                      color: Theme.of(context).textSelectionColor))))
    ]);
  }
}
