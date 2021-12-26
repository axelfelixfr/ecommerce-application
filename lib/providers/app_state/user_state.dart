import 'package:ecommerce_application/pages/auth/landing_page.dart';
import 'package:ecommerce_application/widgets/bottom_navigation.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class UserState extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
        stream: FirebaseAuth.instance.authStateChanges(),
        builder: (context, userSnapshot) {
          if (userSnapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          } else if (userSnapshot.connectionState == ConnectionState.active) {
            if (userSnapshot.hasData) {
              print('El usuario ahora esta logueado');
              return MyBottomNavigation();
            } else {
              print('No hay un usuario logueado ahora');
              return LandingPage();
            }
          } else if (userSnapshot.hasError) {
            return Center(child: Text('Ocurrio un error'));
          }
        });
  }
}
