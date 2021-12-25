import 'package:ecommerce_application/pages/cart_page.dart';
import 'package:ecommerce_application/pages/login_page.dart';
import 'package:ecommerce_application/pages/market_page.dart';
import 'package:ecommerce_application/pages/sign_up_page.dart';
import 'package:ecommerce_application/pages/wishlist_page.dart';
import 'package:ecommerce_application/widgets/bottom_navigation.dart';
import 'package:ecommerce_application/providers/state_app/user_state.dart';
import 'package:ecommerce_application/widgets/home_page/inner_page/other_categories_products.dart';
import 'package:ecommerce_application/widgets/home_page/inner_page/upload_product.dart';
import 'package:ecommerce_application/widgets/market_page/inner_page/product_details.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'providers/cart_provider.dart';
import 'providers/dark_theme_provider.dart';
import 'providers/products_provider.dart';
import 'providers/wishlist_provider.dart';
import 'utilities/my_app_theme.dart';
import 'widgets/home_page/inner_page/categories_navigation_rail.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart' as DotEnv;

Future main() async {
  await DotEnv.load(fileName: '.env');
  WidgetsFlutterBinding.ensureInitialized();
  runApp(AppEcommerce());
}

class AppEcommerce extends StatefulWidget {
  // This widget is the root of your application.
  @override
  _AppEcommerceState createState() => _AppEcommerceState();
}

class _AppEcommerceState extends State<AppEcommerce> {
  DarkThemeProvider themeChangeProvider = DarkThemeProvider();

  void getCurrentAppTheme() async {
    themeChangeProvider.darkTheme =
        await themeChangeProvider.darkThemePreferences.getTheme();
  }

  @override
  void initState() {
    getCurrentAppTheme();
    super.initState();
  }

  // Inicializamos Firebase desde el main
  final Future<FirebaseApp> _initialization = Firebase.initializeApp();

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
        future: _initialization,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return MaterialApp(
                home:
                    Scaffold(body: Center(child: CircularProgressIndicator())));
          } else if (snapshot.hasError) {
            return MaterialApp(
                home: Scaffold(
                    body: Center(child: Text("Ocurrio un error :'("))));
          }
          return MultiProvider(
              providers: [
                ChangeNotifierProvider(create: (_) {
                  return themeChangeProvider;
                }),
                ChangeNotifierProvider(create: (_) => ProductsProvider()),
                ChangeNotifierProvider(create: (_) => CartProvider()),
                ChangeNotifierProvider(create: (_) => WishlistProvider()),
              ],
              child: Consumer<DarkThemeProvider>(
                  builder: (context, themeData, child) {
                return MaterialApp(
                  title: 'Mercado a Distancia',
                  debugShowCheckedModeBanner: false,
                  theme: MyAppTheme.themeData(
                      themeChangeProvider.darkTheme, context),
                  home: UserState(),
                  routes: {
                    CategoriesNavigationRail.routeName: (context) =>
                        CategoriesNavigationRail(),
                    CartPage.routeName: (context) => CartPage(),
                    MarketPage.routeName: (context) => MarketPage(),
                    WishlistPage.routeName: (context) => WishlistPage(),
                    ProductDetails.routeName: (context) => ProductDetails(),
                    OtherCategoriesProducts.routeName: (context) =>
                        OtherCategoriesProducts(),
                    LoginPage.routeName: (context) => LoginPage(),
                    SignUpPage.routeName: (context) => SignUpPage(),
                    MyBottomNavigation.routeName: (context) =>
                        MyBottomNavigation(),
                    UploadProduct.routeName: (context) => UploadProduct()
                  },
                );
              }));
        });
  }
}
