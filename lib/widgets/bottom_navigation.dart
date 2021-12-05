import 'package:ecommerce_application/pages/cart_page.dart';
import 'package:ecommerce_application/pages/feeds_page.dart';
import 'package:ecommerce_application/pages/home_page.dart';
import 'package:ecommerce_application/pages/search_page.dart';
import 'package:ecommerce_application/pages/user_page.dart';
import 'package:flutter/material.dart';
import 'package:line_icons/line_icons.dart';

class BottomNavigation extends StatefulWidget {
  @override
  _BottomNavigationState createState() => _BottomNavigationState();
}

class _BottomNavigationState extends State<BottomNavigation> {
  // List<Map<String, Object>> _pages;
  List _pages = [HomePage(), FeedsPage(), SearchPage(), CartPage(), UserPage()];

  int _selectedPageIndex = 4;

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
            shape: CircularNotchedRectangle(),
            notchMargin: 2,
            elevation: 5,
            clipBehavior: Clip.antiAlias,
            child: Container(
              height: kBottomNavigationBarHeight * 0.98,
              decoration: BoxDecoration(
                  border:
                      Border(top: BorderSide(width: 0.3, color: Colors.amber))),
              child: BottomNavigationBar(
                  onTap: _selectPage,
                  backgroundColor: Theme.of(context).primaryColor,
                  unselectedItemColor: Theme.of(context).textSelectionColor,
                  selectedItemColor: Colors.amber,
                  currentIndex: _selectedPageIndex,
                  items: [
                    BottomNavigationBarItem(
                        icon: Icon(LineIcons.home), label: 'Home'),
                    BottomNavigationBarItem(
                        icon: Icon(LineIcons.rss), label: 'Feeds'),
                    BottomNavigationBarItem(
                        icon: Icon(null), activeIcon: null, label: 'Search'),
                    BottomNavigationBarItem(
                        icon: Icon(LineIcons.shoppingBasket), label: 'Cart'),
                    BottomNavigationBarItem(
                        icon: Icon(LineIcons.user), label: 'User'),
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
                child: Icon(LineIcons.search),
                splashColor: Colors.grey,
                onPressed: () => setState(() {
                      _selectedPageIndex = 2;
                    }))));
  }
}
