import 'package:flutter/material.dart';

class ListRecipes extends StatelessWidget {
  ListRecipes({Key key, this.index}) : super(key: key);

  final int index;

  final List<String> _listImagesRecipes = [
    'assets/img/recetas/receta_alambre_res.jpg',
    'assets/img/recetas/receta_chile_atun.jpg',
    'assets/img/recetas/receta_milanesa_caballo.jpg',
    'assets/img/recetas/receta_papas_chorizo.jpg',
    'assets/img/recetas/receta_rajas_poblanas.jpg',
    'assets/img/recetas/receta_tinga_pollo.jpg',
    'assets/img/recetas/receta_tostadas_salpicon.jpg'
  ];

  final List<String> _listTitleRecipes = [
    'Alambres de Res',
    'Chile Relleno de Atún',
    'Milanesa a Caballo',
    'Papas con Chorizo',
    'Rajas Poblanas',
    'Tinga de Pollo con Chipotle',
    'Tostadas de Salpicon'
  ];

  @override
  Widget build(BuildContext context) {
    return Stack(children: [
      Container(
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10),
              image: DecorationImage(
                  image: AssetImage(_listImagesRecipes[index]),
                  fit: BoxFit.cover)),
          margin: EdgeInsets.symmetric(horizontal: 10),
          width: 150,
          height: 150),
      Positioned(
          bottom: 0,
          left: 10,
          right: 10,
          child: Container(
              padding: EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
              color: Theme.of(context).backgroundColor,
              child: Text(_listTitleRecipes[index],
                  style: TextStyle(
                      fontWeight: FontWeight.w500,
                      fontSize: 18,
                      color: Theme.of(context).textSelectionColor))))
    ]);
  }
}
