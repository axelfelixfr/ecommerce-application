import 'package:ecommerce_application/pages/cart_page.dart';
import 'package:ecommerce_application/pages/market_page.dart';
import 'package:ecommerce_application/pages/home_page.dart';
import 'package:ecommerce_application/pages/search_page.dart';
import 'package:ecommerce_application/pages/user_page.dart';
import 'package:ecommerce_application/utilities/my_app_icons.dart';
import 'package:flutter/material.dart';

class MyBottomNavigation extends StatefulWidget {
  @override
  _MyBottomNavigationState createState() => _MyBottomNavigationState();
}

class _MyBottomNavigationState extends State<MyBottomNavigation> {
  // List<Map<String, Object>> _pages;
  final List _pages = [
    HomePage(),
    MarketPage(),
    SearchPage(),
    CartPage(),
    UserPage()
  ];

  int _selectedPageIndex = 0;

  // @override
  // void initState() {
  //   _pages = [
  //     {'page': Home()},
  //     {'page': Feeds()},
  //     {'page': Search()},
  //     {'page': ShoppingCart()},
  //     {'page': UserInfo()}
  //   ];
  //   super.initState();
  // }

  void _selectPage(int index) {
    setState(() {
      _selectedPageIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: _pages[_selectedPageIndex], //_pages[_selectedPageIndex]['page'],
        bottomNavigationBar: BottomAppBar(
            shape: const CircularNotchedRectangle(),
            notchMargin: 2,
            elevation: 5,
            clipBehavior: Clip.antiAlias,
            child: Container(
              height: kBottomNavigationBarHeight * 0.98,
              decoration: const BoxDecoration(
                  border:
                      Border(top: BorderSide(width: 0.5, color: Colors.amber))),
              child: BottomNavigationBar(
                  onTap: _selectPage,
                  backgroundColor: Theme.of(context).primaryColor,
                  unselectedItemColor: Theme.of(context).textSelectionColor,
                  selectedItemColor: Colors.amber,
                  currentIndex: _selectedPageIndex,
                  items: [
                    BottomNavigationBarItem(
                        icon: Icon(MyAppIcons.home), label: 'Inicio'),
                    BottomNavigationBarItem(
                        icon: Icon(MyAppIcons.rss), label: 'Mercado'),
                    const BottomNavigationBarItem(
                        icon: Icon(null), activeIcon: null, label: 'Buscar'),
                    BottomNavigationBarItem(
                        icon: Icon(MyAppIcons.shopping), label: 'Carrito'),
                    BottomNavigationBarItem(
                        icon: Icon(MyAppIcons.user), label: 'Usuario'),
                  ]),
            )),
        floatingActionButtonLocation:
            FloatingActionButtonLocation.miniCenterDocked,
        floatingActionButton: Padding(
            padding: const EdgeInsets.all(0.8),
            child: FloatingActionButton(
                backgroundColor: Colors.amber,
                tooltip: 'Search',
                elevation: 5,
                hoverElevation: 10,
                child: Icon(MyAppIcons.search),
                splashColor: Colors.grey,
                onPressed: () => setState(() {
                      _selectedPageIndex = 2;
                    }))));
  }
}
