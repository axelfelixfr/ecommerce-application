import 'package:ecommerce_application/utilities/my_app_colors.dart';
import 'package:flutter/material.dart';
import 'package:line_icons/line_icons.dart';

class GlobalMethods {
  Future<void> showDialogAlert(BuildContext context, String title,
      String subtitle, Function func) async {
    showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
              title: Row(children: [
                Icon(LineIcons.exclamationCircle, color: Colors.red[400]),
                Padding(
                  padding: const EdgeInsets.only(left: 8.0),
                  child: Text(title),
                )
              ]),
              content: Text(subtitle),
              actions: [
                TextButton(
                    style: TextButton.styleFrom(
                      padding: EdgeInsets.all(0),
                      primary: Colors.red[400],
                    ),
                    onPressed: () async {
                      Navigator.pop(context);
                    },
                    child: Text('Cancelar')),
                ClipRRect(
                  borderRadius: BorderRadius.circular(10),
                  child: Stack(
                    children: <Widget>[
                      Positioned.fill(
                        child: Container(
                            decoration: BoxDecoration(
                                gradient: LinearGradient(
                                    colors: [
                                      MyAppColors.gradiendYStart,
                                      MyAppColors.gradiendYEnd
                                    ],
                                    begin: const FractionalOffset(0.0, 0.0),
                                    end: const FractionalOffset(5.0, 9.0),
                                    stops: [0.0, 0.1],
                                    tileMode: TileMode.mirror))),
                      ),
                      TextButton(
                        style: TextButton.styleFrom(
                          padding: EdgeInsets.all(0),
                          primary: Colors.white,
                          // textStyle:
                          // TextStyle(fontSize: 20),
                        ),
                        onPressed: () {
                          func();
                          Navigator.pop(context);
                        },
                        child: Text('Aceptar'),
                      ),
                    ],
                  ),
                ),
              ]
              /*[
                TextButton(
                    onPressed: () => Navigator.pop(context),
                    child: Text('Cancelar')),
                TextButton(
                    onPressed: () {
                      func();
                      Navigator.pop(context);
                    },
                    child: Text('Sí'))
              ]*/
              );
        });
  }
}
