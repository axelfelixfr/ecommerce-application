import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:ecommerce_application/pages/home/cart_page.dart';
import 'package:ecommerce_application/pages/home/orders_page.dart';
import 'package:ecommerce_application/pages/home/wishlist_page.dart';
import 'package:ecommerce_application/providers/dark_theme_provider.dart';
import 'package:ecommerce_application/utilities/my_app_colors.dart';
import 'package:ecommerce_application/utilities/my_app_icons.dart';
import 'package:giffy_dialog/giffy_dialog.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:line_icons/line_icons.dart';
import 'package:list_tile_switch/list_tile_switch.dart';
import 'package:provider/provider.dart';

class UserPage extends StatefulWidget {
  @override
  _UserPageState createState() => _UserPageState();
}

class _UserPageState extends State<UserPage> {
  // bool _value = false;
  ScrollController _scrollController;
  var top = 0.0;
  // Firebase - información del usuario
  String _uid;
  String _name;
  String _email;
  int _phoneNumber;
  String _joinedAt;
  String _userImageUrl;

  final FirebaseAuth _auth = FirebaseAuth.instance;
  @override
  void initState() {
    super.initState();
    _scrollController = ScrollController();
    _scrollController.addListener(() {
      setState(() {});
    });
    // Se inicializa trayendo la información del usuario
    getDataUser();
  }

  // Método para obtener información del usuario
  void getDataUser() async {
    User user = _auth.currentUser;
    _uid = user.uid;
    // print('El nombre es: ${user.displayName}');
    // print('Su foto es: ${user.photoURL}');
    // Se manda a traer el documento del usuario con su información a través de su id
    final DocumentSnapshot userDoc = user.isAnonymous
        ? null
        : await FirebaseFirestore.instance.collection('users').doc(_uid).get();

    if (userDoc != null) {
      setState(() {
        _name = userDoc.get('name');
        _email = user.email;
        _phoneNumber = userDoc.get('phoneNumber');
        _joinedAt = userDoc.get('joinedAt');
        _userImageUrl = userDoc.get('imageUrl');
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final themeChange = Provider.of<DarkThemeProvider>(context);
    return Scaffold(
        body: Stack(children: [
      CustomScrollView(controller: _scrollController, slivers: <Widget>[
        SliverAppBar(
          // leading: Icon(Icons.ac_unit_outlined),
          // automaticallyImplyLeading: false,
          elevation: 0,
          expandedHeight: 200,
          pinned: true,
          flexibleSpace: LayoutBuilder(
              builder: (BuildContext context, BoxConstraints constraints) {
            top = constraints.biggest.height;
            return Container(
              decoration: BoxDecoration(
                gradient: LinearGradient(
                    colors: [
                      MyAppColors.gradiendYStart,
                      MyAppColors.gradiendYEnd
                    ],
                    begin: const FractionalOffset(0.0, 0.0),
                    end: const FractionalOffset(7.0, 0.0),
                    stops: [0.0, 0.1],
                    tileMode: TileMode.mirror),
              ),
              child: FlexibleSpaceBar(
                // collapseMode: CollapseMode.parallax,
                centerTitle: true,
                title: AnimatedOpacity(
                  duration: Duration(milliseconds: 300),
                  opacity: top <= 110.0 ? 1.0 : 0,
                  child: Row(
                    children: [
                      SizedBox(
                        width: 12,
                      ),
                      Container(
                        height: kToolbarHeight / 1.8,
                        width: kToolbarHeight / 1.8,
                        decoration: BoxDecoration(
                          boxShadow: [
                            BoxShadow(
                              color: Colors.white,
                              blurRadius: 1.0,
                            ),
                          ],
                          shape: BoxShape.circle,
                          image: DecorationImage(
                            fit: BoxFit.fill,
                            image: NetworkImage(_userImageUrl ??
                                'https://s2.qwant.com/thumbr/0x380/e/2/1dcae51df64ecca2a6a8eafd5fd420fcc23d09d4473b89678965fafa2bbfe1/user-icon-vector.jpg?u=https%3A%2F%2Fstatic.vecteezy.com%2Fsystem%2Fresources%2Fpreviews%2F000%2F551%2F599%2Foriginal%2Fuser-icon-vector.jpg&q=0&b=1&p=0&a=0'),
                          ),
                        ),
                      ),
                      SizedBox(
                        width: 12,
                      ),
                      Text(
                        _name == null ? 'Invitado' : _name,
                        style: TextStyle(fontSize: 20.0, color: Colors.white),
                      ),
                    ],
                  ),
                ),
                background: Image(
                  image: AssetImage('assets/img/pages/market-922845_1920.jpg'),
                  fit: BoxFit.fill,
                ),
              ),
            );
          }),
        ),
        !_auth.currentUser.isAnonymous
            ? SliverToBoxAdapter(
                child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                      padding: EdgeInsets.only(top: 5.0),
                      child: userTitle(
                          'Hola, bienvenido a nuestro Mercado a Distancia')),
                  Divider(thickness: 1, color: Colors.grey),
                  Material(
                      color: Colors.transparent,
                      child: InkWell(
                          splashColor: Theme.of(context).splashColor,
                          child: ListTile(
                            onTap: () => Navigator.of(context)
                                .pushNamed(WishlistPage.routeName),
                            title: Text('Mi lista'),
                            trailing: Icon(LineIcons.angleRight),
                            leading: Icon(MyAppIcons.wishlist),
                          ))),
                  Material(
                      color: Colors.transparent,
                      child: InkWell(
                          splashColor: Theme.of(context).splashColor,
                          child: ListTile(
                            onTap: () => Navigator.of(context)
                                .pushNamed(CartPage.routeName),
                            title: Text('Mi carrito'),
                            trailing: Icon(LineIcons.angleRight),
                            leading: Icon(MyAppIcons.shopping),
                          ))),
                  Material(
                      color: Colors.transparent,
                      child: InkWell(
                          splashColor: Theme.of(context).splashColor,
                          child: ListTile(
                            onTap: () => Navigator.of(context)
                                .pushNamed(OrdersPage.routeName),
                            title: Text('Mis mandados'),
                            trailing: Icon(LineIcons.angleRight),
                            leading: Icon(LineIcons.dollyFlatbed),
                          ))),
                  Padding(
                      padding: EdgeInsets.only(left: 8.0),
                      child: userTitle('Información del usuario')),
                  Divider(thickness: 1, color: Colors.grey),
                  userListTile('Correo electrónico', _email ?? '', 0, context),
                  userListTile(
                      'Número de teléfono',
                      _phoneNumber == null
                          ? 'No ha registrado número de teléfono'
                          : _phoneNumber.toString(),
                      1,
                      context),
                  userListTile('Dirección de envío', '', 2, context),
                  userListTile('Fecha de unión', _joinedAt ?? '', 3, context),
                  // userListTile('', 'subtitlo bonito', 0, context),
                  Padding(
                      padding: EdgeInsets.only(left: 8.0),
                      child: userTitle('Ajustes')),
                  Divider(thickness: 1, color: Colors.grey),
                  ListTileSwitch(
                    value: themeChange.darkTheme,
                    switchActiveColor: Colors.amber,
                    leading: themeChange.darkTheme
                        ? Icon(LineIcons.sun)
                        : Icon(LineIcons.moon),
                    onChanged: (value) {
                      setState(() {
                        themeChange.darkTheme = value;
                      });
                    },
                    visualDensity: VisualDensity.comfortable,
                    switchType: SwitchType.cupertino,
                    title: Text('Modo Oscuro'),
                  ),
                  Material(
                    color: Colors.transparent,
                    child: InkWell(
                      splashColor: Theme.of(context).splashColor,
                      child: ListTile(
                        onTap: () async {
                          showDialog(
                              context: context,
                              builder: (_) => AssetGiffyDialog(
                                    image: Image.asset('assets/gif/homero.gif',
                                        fit: BoxFit.fill),
                                    buttonOkColor: Colors.amber,
                                    buttonOkText: Text('Sí',
                                        style: TextStyle(color: Colors.white)),
                                    buttonCancelText: Text('Cancelar',
                                        style: TextStyle(color: Colors.white)),
                                    title: Text(
                                      '¡Antes de que te vayas!',
                                      style: TextStyle(
                                          fontSize: 22.0,
                                          fontWeight: FontWeight.w600),
                                    ),
                                    description: Text(
                                      '¿Estás seguro de querer continuar con salir de la aplicación?',
                                      textAlign: TextAlign.center,
                                    ),
                                    entryAnimation: EntryAnimation.TOP,
                                    onOkButtonPressed: () async {
                                      await _auth.signOut().then(
                                          (value) => Navigator.pop(context));
                                    },
                                  ));
                          // Navigator.canPop(context)? Navigator.pop(context):null;
                          /*
                    showDialog(
                        context: context,
                        builder: (BuildContext ctx) {
                          return AlertDialog(
                            title: Row(
                              children: [
                                Icon(LineIcons.alternateSignOut),
                                Padding(
                                  padding: EdgeInsets.only(left: 8.0),
                                  child: Text('Cerrar sesión'),
                                ),
                              ],
                            ),
                            content: Text('¿Seguro(a) de cerrar sesión?'),
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
                                                  begin: const FractionalOffset(
                                                      0.0, 0.0),
                                                  end: const FractionalOffset(
                                                      5.0, 9.0),
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
                                        // Navigator.pushNamed(context, "/");
                                        _auth.signOut();
                                      },
                                      child: Text('Aceptar'),
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          );
                        });
                        */
                        },
                        title: Text('Cerrar sesión'),
                        leading: Icon(LineIcons.alternateSignOut),
                      ),
                    ),
                  ),
                ],
              ))
            : SliverToBoxAdapter(
                child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                      padding: EdgeInsets.only(left: 8.0),
                      child: userTitle(
                          'Hola, bienvenido a nuestro Mercado a Distancia')),
                  Divider(thickness: 1, color: Colors.grey),
                  ListTileSwitch(
                    value: themeChange.darkTheme,
                    switchActiveColor: Colors.amber,
                    leading: themeChange.darkTheme
                        ? Icon(LineIcons.sun)
                        : Icon(LineIcons.moon),
                    onChanged: (value) {
                      setState(() {
                        themeChange.darkTheme = value;
                      });
                    },
                    visualDensity: VisualDensity.comfortable,
                    switchType: SwitchType.cupertino,
                    title: Text('Modo Oscuro'),
                  ),
                  Material(
                    color: Colors.transparent,
                    child: InkWell(
                      splashColor: Theme.of(context).splashColor,
                      child: ListTile(
                        onTap: () async {
                          showDialog(
                              context: context,
                              builder: (_) => AssetGiffyDialog(
                                    image: Image.asset('assets/gif/homero.gif',
                                        fit: BoxFit.fill),
                                    buttonOkColor: Colors.amber,
                                    buttonOkText: Text('Sí',
                                        style: TextStyle(color: Colors.white)),
                                    buttonCancelText: Text('Cancelar',
                                        style: TextStyle(color: Colors.white)),
                                    title: Text(
                                      '¡Antes de que te vayas!',
                                      style: TextStyle(
                                          fontSize: 22.0,
                                          fontWeight: FontWeight.w600),
                                    ),
                                    description: Text(
                                      '¿Estás seguro de querer continuar con salir de la aplicación?',
                                      textAlign: TextAlign.center,
                                      style: TextStyle(),
                                    ),
                                    entryAnimation: EntryAnimation.TOP,
                                    onOkButtonPressed: () async {
                                      await _auth.signOut().then(
                                          (value) => Navigator.pop(context));
                                    },
                                  ));
                        },
                        title: Text('Salir de la aplicación'),
                        leading: Icon(LineIcons.alternateSignOut),
                      ),
                    ),
                  ),
                ],
              ))
      ]),
      !_auth.currentUser.isAnonymous ? _buildFab() : Container()
    ]));
  }

  Widget _buildFab() {
    // Posición inicial
    const double defaultTopMargin = 200.0 - 4.0;
    // Pixeles desde la parte superior donde debería empezar la escala
    const double scaleStart = 160.0;
    // Pixeles desde la parte superior donde debería terminar la escala
    const double scaleEnd = scaleStart / 2;

    double top = defaultTopMargin;
    double scale = 1.0;
    if (_scrollController.hasClients) {
      double offset = _scrollController.offset;
      top -= offset;
      if (offset < defaultTopMargin - scaleStart) {
        // Si offset es más pequeña no reduce la escala, sino que le asigna 1
        scale = 1.0;
      } else if (offset < defaultTopMargin - scaleEnd) {
        // offser entre scaleStart y scaleEnd, si se cumple escala hacia abajo
        scale = (defaultTopMargin - scaleEnd - offset) / scaleEnd;
      } else {
        // Si offset paso el scaleEnd se oculta el boton
        scale = 0.0;
      }
    }

    // Widget del boton flotante con el icono de la camara
    return Positioned(
      top: top,
      right: 16.0,
      child: Transform(
        transform: Matrix4.identity()..scale(scale),
        alignment: Alignment.center,
        child: FloatingActionButton(
          backgroundColor: Colors.amber,
          heroTag: "btnFlotant",
          onPressed: () {},
          child: Icon(LineIcons.retroCamera),
        ),
      ),
    );
  }

  // Lista de iconos que tendra la lista de opciones
  final List<IconData> _userTileIcons = [
    LineIcons.envelopeAlt,
    LineIcons.mobilePhone,
    LineIcons.shippingFast,
    Icons.watch_later,
    LineIcons.alternateSignOut
  ];

  // Widget de un item de la lista de opciones
  Widget userListTile(
      String title, String subTitle, int indexItem, BuildContext context) {
    return Material(
        color: Colors.transparent,
        child: InkWell(
            splashColor: Theme.of(context).splashColor,
            child: ListTile(
              onTap: () {},
              title: Text(title),
              subtitle: Text(subTitle,
                  style: TextStyle(color: Theme.of(context).accentColor)),
              leading: Icon(_userTileIcons[indexItem]),
            )));
  }

  // Titulo para lista de opciones
  Widget userTitle(String title) {
    return Padding(
      padding: EdgeInsets.all(14.0),
      child: Text(
        title,
        style: TextStyle(fontWeight: FontWeight.bold, fontSize: 23),
      ),
    );
  }
}
