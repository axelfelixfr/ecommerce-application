import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class MyAppTheme {
  static ThemeData themeData(bool isDarkTheme, BuildContext context) {
    return ThemeData(
      textTheme: GoogleFonts.poppinsTextTheme(Theme.of(context).textTheme.apply(
          bodyColor: isDarkTheme
              ? Color.fromARGB(255, 242, 242, 242)
              : Color.fromARGB(255, 33, 33, 33))),
      primaryTextTheme:
          GoogleFonts.montserratTextTheme(Theme.of(context).primaryTextTheme),
      scaffoldBackgroundColor: isDarkTheme
          ? Color.fromARGB(255, 33, 33, 33)
          : Color.fromARGB(255, 242, 242, 242),
      primarySwatch: Colors.pink,
      primaryColor: isDarkTheme
          ? Color.fromARGB(255, 33, 33, 33)
          : Color.fromARGB(255, 242, 242, 242),
      accentColor: isDarkTheme ? Colors.white60 : Colors.black45,
      backgroundColor:
          isDarkTheme ? Color.fromARGB(255, 55, 55, 55) : Colors.white,
      indicatorColor: isDarkTheme ? Color(0xff0E1D36) : Color(0xffCBDCF8),
      buttonColor: isDarkTheme ? Color(0xff3B3B3B) : Color(0xffF1F5FB),
      hintColor: isDarkTheme ? Colors.grey.shade300 : Colors.grey.shade800,
      highlightColor: isDarkTheme ? Color(0xff372901) : Color(0xffFCE192),
      hoverColor: isDarkTheme ? Color(0xff3A3A3B) : Color(0xff4285F4),
      focusColor: isDarkTheme ? Color(0xff0B2512) : Color(0xffA8DAB5),
      disabledColor: Colors.grey,
      textSelectionColor:
          isDarkTheme ? Colors.white : Color.fromARGB(255, 33, 33, 33),
      cardColor: isDarkTheme ? Color(0xFF151515) : Colors.white,
      canvasColor:
          isDarkTheme ? Color.fromARGB(255, 33, 33, 33) : Colors.grey[50],
      brightness: isDarkTheme ? Brightness.dark : Brightness.light,
      buttonTheme: Theme.of(context).buttonTheme.copyWith(
          colorScheme: isDarkTheme ? ColorScheme.dark() : ColorScheme.light()),
      appBarTheme: AppBarTheme(
        elevation: 0.0,
      ),
    );
  }
}
