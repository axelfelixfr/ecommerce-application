import 'package:flutter/material.dart';
import 'package:line_icons/line_icons.dart';
import 'package:list_tile_switch/list_tile_switch.dart';

class UserPage extends StatefulWidget {
  @override
  _UserPageState createState() => _UserPageState();
}

class _UserPageState extends State<UserPage> {
  bool _value = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
            padding: const EdgeInsets.only(left: 8.0),
            child: userTitle('Información del usuario')),
        Divider(thickness: 1, color: Colors.grey),
        userListTile('Correo electrónico', 'Correo sub', 0, context),
        userListTile('Número de teléfono', 'Teléfono sub', 1, context),
        userListTile('Dirección de envío', 'subtitlo bonito', 2, context),
        userListTile('Fecha de unión', 'subtitlo bonito', 3, context),
        // userListTile('', 'subtitlo bonito', 0, context),
        Padding(
            padding: const EdgeInsets.only(left: 8.0),
            child: userTitle('Configuración de usuario')),
        Divider(thickness: 1, color: Colors.grey),
        ListTileSwitch(
          value: _value,
          leading: Icon(LineIcons.moon),
          onChanged: (value) {
            setState(() {
              _value = value;
            });
          },
          visualDensity: VisualDensity.comfortable,
          switchType: SwitchType.cupertino,
          switchActiveColor: Colors.indigo,
          title: Text('Modo Oscuro'),
        ),
        userListTile('Cerrar sesión', '', 4, context),
      ],
    ));
  }

  List<IconData> _userTileIcons = [
    LineIcons.envelopeAlt,
    LineIcons.tty,
    LineIcons.shippingFast,
    Icons.watch_later,
    LineIcons.alternateSignOut
  ];

  Widget userListTile(
      String title, String subTitle, int indexItem, BuildContext context) {
    return Material(
      color: Colors.transparent,
      child: InkWell(
        splashColor: Theme.of(context).splashColor,
        child: ListTile(
            onTap: () {},
            title: Text(title),
            subtitle: Text(subTitle),
            leading: Icon(_userTileIcons[indexItem])),
      ),
    );
  }

  Widget userTitle(String title) {
    return Text(title,
        style: TextStyle(fontWeight: FontWeight.bold, fontSize: 23));
  }
}
