import 'package:ecommerce_application/utilities/my_app_theme.dart';
import 'package:flutter/material.dart';
import 'package:ecommerce_application/widgets/bottom_navigation.dart';
import 'package:provider/provider.dart';
import 'providers/dark_theme_provider.dart';

void main() {
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

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
        providers: [
          ChangeNotifierProvider(create: (_) {
            return themeChangeProvider;
          })
        ],
        child:
            Consumer<DarkThemeProvider>(builder: (context, themeData, child) {
          return MaterialApp(
            title: 'Flutter Demo',
            theme: MyAppTheme.themeData(themeChangeProvider.darkTheme, context),
            home: MyBottomNavigation(),
          );
        }));
  }
}
