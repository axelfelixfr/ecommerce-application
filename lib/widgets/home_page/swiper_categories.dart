import 'package:flutter/material.dart';
import 'package:flutter_swiper/flutter_swiper.dart';
import 'inner_page/categories_navigation_rail.dart';

class SwiperCategories extends StatefulWidget {
  final int index;

  const SwiperCategories({Key key, this.index}) : super(key: key);
  @override
  _SwiperCategoriesState createState() => _SwiperCategoriesState();
}

class _SwiperCategoriesState extends State<SwiperCategories> {
  List<Map<String, Object>> categories = [
    {
      'categoryName': 'Verdura',
      'categoryImagesPath': 'assets/img/swiper/swiper_1.png',
    },
    {
      'categoryName': 'Fruta',
      'categoryImagesPath': 'assets/img/swiper/swiper_2.png',
    },
    {
      'categoryName': 'Carne',
      'categoryImagesPath': 'assets/img/swiper/swiper_3.png',
    },
    {
      'categoryName': 'Pollo',
      'categoryImagesPath': 'assets/img/swiper/swiper_4.png',
    },
    {
      'categoryName': 'Pescado',
      'categoryImagesPath': 'assets/img/swiper/swiper_5.png',
    }
  ];

  List _swiperImages = [
    'assets/img/swiper/swiper_1.png',
    'assets/img/swiper/swiper_2.png',
    'assets/img/swiper/swiper_3.png',
    'assets/img/swiper/swiper_4.png',
    'assets/img/swiper/swiper_5.png'
  ];

  @override
  Widget build(BuildContext context) {
    return Container(
        height: 190,
        width: MediaQuery.of(context).size.width,
        child: Swiper(
          itemCount: _swiperImages.length,
          autoplay: true,
          viewportFraction: 0.7,
          scale: 0.85,
          onTap: (index) {
            // Navigator.of(context).pushNamed(CategoriesNavigationRail.routeName,
            // arguments: '${categories[index]['categoryName']}');
            // print('${categories[index]['categoryName']}');
            Navigator.of(context).pushNamed(CategoriesNavigationRail.routeName,
                arguments: {index});
          },
          itemBuilder: (BuildContext context, int index) {
            return ClipRRect(
              borderRadius: BorderRadius.circular(10),
              child: Container(
                color: Color.fromARGB(255, 235, 235, 235),
                child: Image.asset(
                    // _swiperImages[index],
                    categories[index]['categoryImagesPath']
                    // fit: BoxFit.fill
                    ),
              ),
            );
          },
        ));
  }
}
