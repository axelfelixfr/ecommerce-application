import 'package:animated_bottom_navigation_bar/animated_bottom_navigation_bar.dart';
import 'package:auto_size_text/auto_size_text.dart';
import 'package:ecommerce_application/pages/home/cart_page.dart';
import 'package:ecommerce_application/pages/home/market_page.dart';
import 'package:ecommerce_application/pages/home/home_page.dart';
import 'package:ecommerce_application/pages/home/search_page.dart';
import 'package:ecommerce_application/pages/home/user_page.dart';
import 'package:ecommerce_application/helpers/hex_color.dart';
import 'package:ecommerce_application/utilities/my_app_icons.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class MyBottomNavigation extends StatefulWidget {
  static const routeName = '/HomeBottomNavigation';

  @override
  _MyBottomNavigationState createState() => _MyBottomNavigationState();
}

class _MyBottomNavigationState extends State<MyBottomNavigation>
    with SingleTickerProviderStateMixin {
  final autoSizeGroup = AutoSizeGroup();

  AnimationController _animationController;
  Animation<double> animation;
  CurvedAnimation curve;

  final iconList = <IconData>[
    MyAppIcons.home,
    MyAppIcons.market,
    MyAppIcons.shopping,
    MyAppIcons.user,
  ];

  // List<Map<String, Object>> _pages;
  final List _pages = [
    HomePage(),
    MarketPage(),
    CartPage(),
    UserPage(),
    SearchPage()
  ];

  final List _namePage = ['Inicio', 'Mercado', 'Carrito', 'Usuario'];

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
  void dispose() {
    // TODO: implement dispose
    super.dispose();
  }

  @override
  void initState() {
    super.initState();
    final systemTheme = SystemUiOverlayStyle.light.copyWith(
      systemNavigationBarColor: HexColor('#373A36'),
      systemNavigationBarIconBrightness: Brightness.light,
    );
    SystemChrome.setSystemUIOverlayStyle(systemTheme);

    _animationController = AnimationController(
      duration: Duration(seconds: 1),
      vsync: this,
    );
    curve = CurvedAnimation(
      parent: _animationController,
      curve: Interval(
        0.5,
        1.0,
        curve: Curves.fastOutSlowIn,
      ),
    );
    animation = Tween<double>(
      begin: 0,
      end: 1,
    ).animate(curve);

    Future.delayed(
      Duration(seconds: 1),
      () => _animationController.forward(),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _pages[_selectedPageIndex], //_pages[_selectedPageIndex]['page'],
      floatingActionButton: ScaleTransition(
        scale: animation,
        child: FloatingActionButton(
            elevation: 8,
            backgroundColor: HexColor('#FFA400'),
            child: Icon(
              MyAppIcons.search,
              color: HexColor('#373A36'),
            ),
            onPressed: () => setState(() {
                  _animationController.reset();
                  _animationController.forward();
                  _selectedPageIndex = 4;
                })),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      bottomNavigationBar: Container(
        color: Theme.of(context).scaffoldBackgroundColor,
        child: AnimatedBottomNavigationBar.builder(
          itemCount: iconList.length,
          tabBuilder: (int index, bool isActive) {
            final color = isActive
                ? HexColor('#FFA400')
                : Theme.of(context).textSelectionColor;
            return Column(
              mainAxisSize: MainAxisSize.min,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(
                  iconList[index],
                  size: 24,
                  color: color,
                ),
                const SizedBox(height: 4),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 8),
                  child: AutoSizeText(
                    _namePage[index],
                    maxLines: 1,
                    style: TextStyle(color: color),
                    group: autoSizeGroup,
                  ),
                )
              ],
            );
          },
          backgroundColor: Theme.of(context).backgroundColor,
          activeIndex: _selectedPageIndex,
          splashColor: HexColor('#FFA400'),
          notchAndCornersAnimation: animation,
          splashSpeedInMilliseconds: 300,
          notchSmoothness: NotchSmoothness.defaultEdge,
          gapLocation: GapLocation.center,
          leftCornerRadius: 32,
          rightCornerRadius: 32,
          onTap: _selectPage,
        ),
      ),
      /*  
        BottomAppBar(
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
                    })))
    */
    );
  }
}
