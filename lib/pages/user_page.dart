import 'package:ecommerce_application/providers/dark_theme_provider.dart';
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

  @override
  void initState() {
    super.initState();
    _scrollController = ScrollController();
    _scrollController.addListener(() {
      setState(() {});
    });
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
              decoration: const BoxDecoration(
                gradient: LinearGradient(
                    colors: [Colors.amber, Colors.amberAccent],
                    begin: FractionalOffset(0.0, 0.0),
                    end: FractionalOffset(1.0, 0.0),
                    stops: [0.0, 1.0],
                    tileMode: TileMode.clamp),
              ),
              child: FlexibleSpaceBar(
                // collapseMode: CollapseMode.parallax,
                centerTitle: true,
                title: AnimatedOpacity(
                  duration: const Duration(milliseconds: 300),
                  opacity: top <= 110.0 ? 1.0 : 0,
                  child: Row(
                    children: [
                      const SizedBox(
                        width: 12,
                      ),
                      Container(
                        height: kToolbarHeight / 1.8,
                        width: kToolbarHeight / 1.8,
                        decoration: const BoxDecoration(
                          boxShadow: [
                            BoxShadow(
                              color: Colors.white,
                              blurRadius: 1.0,
                            ),
                          ],
                          shape: BoxShape.circle,
                          image: DecorationImage(
                            fit: BoxFit.fill,
                            image: NetworkImage(
                                'https://t3.ftcdn.net/jpg/01/83/55/76/240_F_183557656_DRcvOesmfDl5BIyhPKrcWANFKy2964i9.jpg'),
                          ),
                        ),
                      ),
                      const SizedBox(
                        width: 12,
                      ),
                      const Text(
                        'Guest',
                        style: TextStyle(fontSize: 20.0, color: Colors.white),
                      ),
                    ],
                  ),
                ),
                background: const Image(
                  image: NetworkImage(
                      'https://t3.ftcdn.net/jpg/01/83/55/76/240_F_183557656_DRcvOesmfDl5BIyhPKrcWANFKy2964i9.jpg'),
                  fit: BoxFit.fill,
                ),
              ),
            );
          }),
        ),
        SliverToBoxAdapter(
            child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
                padding: const EdgeInsets.only(left: 8.0),
                child: userTitle('Información del usuario')),
            const Divider(thickness: 1, color: Colors.grey),
            userListTile('Correo electrónico', 'Correo sub', 0, context),
            userListTile('Número de teléfono', 'Teléfono sub', 1, context),
            userListTile('Dirección de envío', 'subtitlo bonito', 2, context),
            userListTile('Fecha de unión', 'subtitlo bonito', 3, context),
            // userListTile('', 'subtitlo bonito', 0, context),
            Padding(
                padding: const EdgeInsets.only(left: 8.0),
                child: userTitle('Configuración de usuario')),
            const Divider(thickness: 1, color: Colors.grey),
            ListTileSwitch(
              value: themeChange.darkTheme,
              leading: const Icon(LineIcons.moon),
              onChanged: (value) {
                setState(() {
                  themeChange.darkTheme = value;
                });
              },
              visualDensity: VisualDensity.comfortable,
              switchType: SwitchType.cupertino,
              switchActiveColor: Colors.indigo,
              title: const Text('Modo Oscuro'),
            ),
            Material(
              color: Colors.transparent,
              child: InkWell(
                splashColor: Theme.of(context).splashColor,
                child: ListTile(
                  onTap: () async {
                    // Navigator.canPop(context)? Navigator.pop(context):null;
                    showDialog(
                        context: context,
                        builder: (BuildContext ctx) {
                          return AlertDialog(
                            title: Row(
                              children: [
                                Padding(
                                  padding: const EdgeInsets.only(right: 6.0),
                                  child: Image.network(
                                    'https://image.flaticon.com/icons/png/128/1828/1828304.png',
                                    height: 20,
                                    width: 20,
                                  ),
                                ),
                                const Padding(
                                  padding: EdgeInsets.all(8.0),
                                  child: Text('Sign out'),
                                ),
                              ],
                            ),
                            content: const Text('¿Seguro(a) de cerrar sesión?'),
                            actions: [
                              TextButton(
                                  style: TextButton.styleFrom(
                                    padding: const EdgeInsets.all(0),
                                    primary: Colors.red[400],
                                  ),
                                  onPressed: () async {
                                    Navigator.pop(context);
                                  },
                                  child: const Text('Cancelar')),
                              ClipRRect(
                                borderRadius: BorderRadius.circular(10),
                                child: Stack(
                                  children: <Widget>[
                                    Positioned.fill(
                                      child: Container(
                                        decoration: const BoxDecoration(
                                          color:
                                              Color.fromARGB(255, 255, 193, 7),
                                        ),
                                      ),
                                    ),
                                    TextButton(
                                      style: TextButton.styleFrom(
                                        padding: const EdgeInsets.all(0),
                                        primary: Colors.white,
                                        // textStyle:
                                        // const TextStyle(fontSize: 20),
                                      ),
                                      onPressed: () {},
                                      child: const Text('Aceptar'),
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          );
                        });
                  },
                  title: const Text('Cerrar sesión'),
                  leading: const Icon(Icons.exit_to_app_rounded),
                ),
              ),
            ),
          ],
        ))
      ]),
      _buildFab()
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
          child: const Icon(LineIcons.retroCamera),
        ),
      ),
    );
  }

  // Lista de iconos que tendra la lista de opciones
  final List<IconData> _userTileIcons = [
    LineIcons.envelopeAlt,
    LineIcons.tty,
    LineIcons.shippingFast,
    Icons.watch_later,
    LineIcons.alternateSignOut
  ];

  // Widget de un item de la lista de opciones
  Widget userListTile(
      String title, String subTitle, int indexItem, BuildContext context) {
    return ListTile(
      title: Text(title),
      subtitle: Text(subTitle),
      leading: Icon(_userTileIcons[indexItem]),
    );
  }

  // Titulo para lista de opciones
  Widget userTitle(String title) {
    return Padding(
      padding: const EdgeInsets.all(14.0),
      child: Text(
        title,
        style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 23),
      ),
    );
  }
}
