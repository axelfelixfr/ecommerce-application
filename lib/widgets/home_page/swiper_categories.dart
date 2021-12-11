import 'package:flutter/material.dart';
import 'package:flutter_swiper/flutter_swiper.dart';
import 'inner_page/categories_navigation_rail.dart';

class SwiperCategories extends StatefulWidget {
  @override
  _SwiperCategoriesState createState() => _SwiperCategoriesState();
}

class _SwiperCategoriesState extends State<SwiperCategories> {
  List _swiperImages = [
    'assets/img/swiper_1.png',
    'assets/img/swiper_2.png',
    'assets/img/swiper_3.png',
    'assets/img/swiper_4.png',
    'assets/img/swiper_5.png'
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
            Navigator.of(context).pushNamed(
              CategoriesNavigationRail.routeName,
              arguments: {
                index,
              },
            );
          },
          itemBuilder: (BuildContext context, int index) {
            return ClipRRect(
              borderRadius: BorderRadius.circular(10),
              child: Container(
                color: Color.fromARGB(255, 235, 235, 235),
                child: Image.asset(
                  _swiperImages[index],
                  // fit: BoxFit.fill
                ),
              ),
            );
          },
        ));
  }
}
