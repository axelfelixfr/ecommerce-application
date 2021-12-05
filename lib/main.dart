import 'package:ecommerce_application/widgets/bottom_navigation.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(AppEcommerce());
}

class AppEcommerce extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Ecommerce App',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: BottomNavigation(),
    );
  }
}
