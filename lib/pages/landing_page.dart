import 'package:cached_network_image/cached_network_image.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:cool_alert/cool_alert.dart';
import 'package:ecommerce_application/pages/login_page.dart';
import 'package:ecommerce_application/pages/sign_up_page.dart';
import 'package:ecommerce_application/utilities/my_app_colors.dart';
import 'package:ecommerce_application/widgets/bottom_navigation.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_signin_button/flutter_signin_button.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:line_icons/line_icons.dart';

class LandingPage extends StatefulWidget {
  @override
  _LandingPageState createState() => _LandingPageState();
}

class _LandingPageState extends State<LandingPage>
    with TickerProviderStateMixin {
  AnimationController _animationController;
  Animation<double> _animation;
  List<String> images = [
    'https://cdn.pixabay.com/photo/2016/11/19/20/55/apples-1841132_960_720.jpg',
    'https://cdn.pixabay.com/photo/2018/02/12/09/00/the-market-3147758_960_720.jpg',
    'https://cdn.pixabay.com/photo/2017/10/02/17/24/chops-2809505_960_720.jpg',
    'https://cdn.pixabay.com/photo/2016/12/05/20/35/chicken-1884873_960_720.jpg',
    'https://cdn.pixabay.com/photo/2016/11/29/05/07/breads-1867459_960_720.jpg',
    'https://cdn.pixabay.com/photo/2015/01/16/15/02/market-601580_960_720.jpg',
    'https://cdn.pixabay.com/photo/2018/02/23/18/32/market-3176255_960_720.jpg',
    'https://cdn.pixabay.com/photo/2018/09/30/20/46/stand-3714597_960_720.jpg',
    'https://cdn.pixabay.com/photo/2021/02/21/07/42/food-6035549_960_720.jpg',
    'https://cdn.pixabay.com/photo/2017/09/16/21/44/food-2756948_960_720.jpg',
    // 'https://cdn.pixabay.com/photo/2016/01/21/23/43/market-1154999_960_720.jpg',
    'https://cdn.pixabay.com/photo/2016/03/27/21/59/bread-1284438_960_720.jpg',
    'https://cdn.pixabay.com/photo/2014/02/03/11/43/fruits-257343_960_720.jpg',
    // 'https://cdn.pixabay.com/photo/2015/09/27/06/18/market-960361_960_720.jpg',
    'https://cdn.pixabay.com/photo/2017/09/09/16/38/vegetables-2732589_960_720.jpg',
    'https://cdn.pixabay.com/photo/2017/01/28/17/19/viet-nam-2015934_960_720.jpg',
    // 'https://cdn.pixabay.com/photo/2017/10/01/20/17/music-2806852_960_720.jpg',
    'https://cdn.pixabay.com/photo/2021/02/07/20/35/vegetables-5992673_960_720.jpg',
    'https://cdn.pixabay.com/photo/2018/02/04/19/42/ham-3130701_960_720.jpg',
    'https://cdn.pixabay.com/photo/2015/06/25/22/06/the-market-place-821843_960_720.jpg',
    'https://cdn.pixabay.com/photo/2015/04/05/13/09/spices-707807_960_720.jpg',
    'https://cdn.pixabay.com/photo/2015/01/16/15/01/market-601573_960_720.jpg',
    'https://cdn.pixabay.com/photo/2016/11/29/10/09/bakery-1868925_960_720.jpg',
  ];

  final FirebaseAuth _auth = FirebaseAuth.instance;
  bool _isLoading = false;

  @override
  void initState() {
    super.initState();
    images.shuffle();
    _animationController =
        AnimationController(duration: Duration(seconds: 20), vsync: this);
    _animation =
        CurvedAnimation(parent: _animationController, curve: Curves.linear)
          ..addListener(() {
            setState(() {});
          })
          ..addStatusListener((animationStatus) {
            if (animationStatus == AnimationStatus.completed) {
              _animationController.reset();
              _animationController.forward();
            }
          });
    _animationController.forward();
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  Future<void> _googleSignIn() async {
    final googleSignIn = GoogleSignIn();
    final googleAccount = await googleSignIn.signIn();

    if (googleAccount != null) {
      final googleAuth = await googleAccount.authentication;
      if (googleAuth.accessToken != null && googleAuth.idToken != null) {
        try {
          var date = DateTime.now().toString();
          var parseDate = DateTime.parse(date);
          var formattedDate =
              "${parseDate.day}-${parseDate.month}-${parseDate.year}";

          final authResult = await _auth.signInWithCredential(
              GoogleAuthProvider.credential(
                  idToken: googleAuth.idToken,
                  accessToken: googleAuth.accessToken));
          await FirebaseFirestore.instance
              .collection('users')
              .doc(authResult.user.uid)
              .set({
            'id': authResult.user.uid,
            'name': authResult.user.displayName,
            'email': authResult.user.email,
            'phoneNumber': authResult.user.phoneNumber,
            'imageUrl': authResult.user.photoURL,
            'joinedAt': formattedDate,
            'createdAt': Timestamp.now()
          });
        } catch (error) {
          // Si ocurrio un error se muestra la alerta
          CoolAlert.show(
              context: context,
              title: '¡Error!',
              type: CoolAlertType.error,
              confirmBtnColor: Colors.amber,
              text: error.message,
              animType: CoolAlertAnimType.slideInUp,
              backgroundColor: Theme.of(context).backgroundColor);
        }
      }
    }
  }

  void _loginAnonymously() async {
    setState(() {
      _isLoading = true;
    });
    try {
      await _auth.signInAnonymously();
    } catch (error) {
      // Si ocurrio un error se muestra la alerta
      CoolAlert.show(
          context: context,
          title: '¡Error!',
          type: CoolAlertType.error,
          confirmBtnColor: Colors.amber,
          text: error.message,
          animType: CoolAlertAnimType.slideInUp,
          backgroundColor: Theme.of(context).backgroundColor);
      // print('Ocurrio un error: ${error.message}');
    } finally {
      setState(() {
        _isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Stack(children: [
      CachedNetworkImage(
        imageUrl: images[1],
        // placeholder: (context, url) =>
        //     Center(child: CircularProgressIndicator()),
        errorWidget: (context, url, error) => Icon(LineIcons.exclamationCircle),
        fit: BoxFit.cover,
        height: double.infinity,
        width: double.infinity,
        alignment: FractionalOffset(_animation.value, 0),
      ),
      Container(
          margin: EdgeInsets.only(top: 30),
          width: double.infinity,
          child:
              Column(crossAxisAlignment: CrossAxisAlignment.center, children: [
            SizedBox(height: 30),
            Text('Bienvenido a',
                style: TextStyle(fontSize: 40, fontWeight: FontWeight.w600)),
            SizedBox(height: 10),
            Image.asset('assets/img/MercadoADistancia.png',
                filterQuality: FilterQuality.high),
            // Padding(
            //   padding: const EdgeInsets.symmetric(horizontal: 30),
            //   child: Text('Mercado a Distancia',
            //       textAlign: TextAlign.center,
            //       style: TextStyle(fontSize: 26, fontWeight: FontWeight.w400)),
            // ),
          ])),
      Column(mainAxisAlignment: MainAxisAlignment.end, children: [
        Row(children: [
          SizedBox(width: 10),
          Expanded(
              child: ElevatedButton(
                  style: ButtonStyle(
                      backgroundColor: MaterialStateProperty.all(Colors.amber),
                      shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                          RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(7),
                              side: BorderSide(
                                  color: MyAppColors.backgroundColor)))),
                  onPressed: () {
                    Navigator.pushNamed(context, LoginPage.routeName);
                  },
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(LineIcons.doorOpen),
                      SizedBox(width: 5),
                      Text('Entrar',
                          style: TextStyle(
                              fontWeight: FontWeight.w500, fontSize: 17)),
                    ],
                  ))),
          SizedBox(width: 10),
          Expanded(
              child: ElevatedButton(
                  style: ButtonStyle(
                      backgroundColor:
                          MaterialStateProperty.all(Colors.orange.shade400),
                      shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                          RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(7),
                              side: BorderSide(
                                  color: MyAppColors.backgroundColor)))),
                  onPressed: () {
                    Navigator.pushNamed(context, SignUpPage.routeName);
                  },
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(LineIcons.userPlus),
                      SizedBox(width: 5),
                      Text('Registrarse',
                          style: TextStyle(
                              fontWeight: FontWeight.w500, fontSize: 17)),
                    ],
                  ))),
          SizedBox(width: 10),
        ]),
        SizedBox(height: 30),
        Row(children: [
          Expanded(
              child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10),
            child: Divider(
              color: Colors.amberAccent,
              thickness: 3,
            ),
          )),
          Text('También puedes iniciar sesión con:',
              style: TextStyle(fontWeight: FontWeight.w800)),
          Expanded(
              child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10),
            child: Divider(
              color: Colors.amberAccent,
              thickness: 3,
            ),
          )),
        ]),
        SizedBox(height: 30),
        // Padding(
        //   padding: const EdgeInsets.symmetric(horizontal: 15.0),
        //   child: GoogleAuthButton(
        //       onPressed: () {},
        //       darkMode: false,
        //       text: 'Iniciar sesión con Google'),
        // ),
        // SizedBox(height: 10),
        // Padding(
        //   padding: const EdgeInsets.symmetric(horizontal: 15.0),
        //   child: FacebookAuthButton(
        //       onPressed: () {
        //         Navigator.pushNamed(context, MyBottomNavigation.routeName);
        //       },
        //       darkMode: false,
        //       text: 'Iniciar sesión con Facebook'),
        // ),
        SignInButton(
          Buttons.Google,
          padding: EdgeInsets.symmetric(horizontal: 30.0),
          text: 'Continuar con Google',
          onPressed: _googleSignIn,
        ),
        SizedBox(height: 10),
        _isLoading
            ? CircularProgressIndicator()
            : SignInButtonBuilder(
                padding: EdgeInsets.symmetric(horizontal: 30.0),
                innerPadding: EdgeInsets.symmetric(horizontal: 5.0),
                text: 'Continuar como invitado',
                icon: LineIcons.user,
                onPressed: _loginAnonymously,
                backgroundColor: Colors.blueGrey[700],
              ),
        SizedBox(height: 40),
      ])
    ]));
  }
}
