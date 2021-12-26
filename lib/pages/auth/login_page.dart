import 'package:cool_alert/cool_alert.dart';
import 'package:ecommerce_application/utilities/my_app_colors.dart';
import 'package:email_validator/email_validator.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:line_icons/line_icons.dart';
import 'package:lovelydialogs/lovely_dialogs.dart';
import 'package:rounded_loading_button/rounded_loading_button.dart';
import 'package:wave/config.dart';
import 'package:wave/wave.dart';

class LoginPage extends StatefulWidget {
  static const routeName = '/LoginPage';

  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final FocusNode _passwordFocusNode = FocusNode();
  String _emailAddress = '';
  String _password = '';
  bool _obscureText = true;
  final _formKey = GlobalKey<FormState>();
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final RoundedLoadingButtonController _btnLoginController =
      new RoundedLoadingButtonController();

  @override
  void dispose() {
    _passwordFocusNode.dispose();
    super.dispose();
  }

  void _submitForm() async {
    final isValid = _formKey.currentState.validate();
    FocusScope.of(context).unfocus();
    if (isValid) {
      _btnLoginController.start();
      _formKey.currentState.save();
      try {
        await _auth
            .signInWithEmailAndPassword(
                email: _emailAddress.trim(), password: _password.trim())
            .then((value) {
          print('Si paso $value');
          _btnLoginController.success();
          // Navigator.pop(context);
          Navigator.canPop(context) ? Navigator.pop(context) : null;
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
        // print('Ocurrio un error: ${error.message}');
      } finally {
        _btnLoginController.stop();
      }
    } else {
      _btnLoginController.stop();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Stack(children: [
      Container(
          height: MediaQuery.of(context).size.height,
          child: RotatedBox(
            quarterTurns: 2,
            child: WaveWidget(
              config: CustomConfig(
                gradients: [
                  [MyAppColors.gradiendFStart, MyAppColors.gradiendFEnd],
                  [MyAppColors.gradiendYStart, MyAppColors.gradiendYEnd]
                ],
                durations: [19440, 10800],
                heightPercentages: [0.20, 0.25],
                blur: MaskFilter.blur(BlurStyle.solid, 10),
                gradientBegin: Alignment.bottomLeft,
                gradientEnd: Alignment.topRight,
              ),
              waveAmplitude: 0,
              size: Size(
                double.infinity,
                double.infinity,
              ),
            ),
          )),
      SingleChildScrollView(
        child: Column(
          children: [
            Container(
                margin: EdgeInsets.only(top: 60),
                height: 90.0,
                // width: 120.0,
                // decoration: BoxDecoration(
                //     color: Colors.white,
                //     borderRadius: BorderRadius.circular(20),
                //     image: DecorationImage(
                //         image: AssetImage('assets/img/MercadoADistancia.png'),
                //         fit: BoxFit.fill),
                //     shape: BoxShape.rectangle)
                child:
                    Image.asset('assets/img/logo/MercadoADistanciaYellow.png')),
            SizedBox(height: 25),
            Form(
                key: _formKey,
                child: Column(children: [
                  Padding(
                    padding: const EdgeInsets.all(12),
                    child: TextFormField(
                      style: TextStyle(color: Colors.black),
                      key: ValueKey('email'),
                      validator: (value) {
                        if (value.isEmpty || !value.contains('@')) {
                          return 'Por favor ingresa un email válido';
                        }
                        return null;
                      },
                      textInputAction: TextInputAction.next,
                      onEditingComplete: () => FocusScope.of(context)
                          .requestFocus(_passwordFocusNode),
                      keyboardType: TextInputType.emailAddress,
                      decoration: InputDecoration(
                          labelStyle: TextStyle(color: Colors.black87),
                          border: const UnderlineInputBorder(),
                          filled: true,
                          prefixIcon: Icon(LineIcons.at, color: Colors.grey),
                          labelText: 'Correo electrónico',
                          fillColor: Colors.white),
                      onSaved: (value) {
                        _emailAddress = value;
                      },
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(12),
                    child: TextFormField(
                      style: TextStyle(color: Colors.black),
                      key: ValueKey('password'),
                      validator: (value) {
                        if (value.isEmpty || value.length < 7) {
                          return 'Por favor ingresa un password válido';
                        }
                        return null;
                      },
                      keyboardType: TextInputType.visiblePassword,
                      focusNode: _passwordFocusNode,
                      decoration: InputDecoration(
                          labelStyle: TextStyle(color: Colors.black87),
                          border: const UnderlineInputBorder(),
                          filled: true,
                          prefixIcon: Icon(LineIcons.lock, color: Colors.grey),
                          suffixIcon: GestureDetector(
                              onTap: () {
                                setState(() {
                                  _obscureText = !_obscureText;
                                });
                              },
                              child: Icon(
                                  _obscureText
                                      ? LineIcons.eye
                                      : LineIcons.lowVision,
                                  color: Colors.grey)),
                          labelText: 'Contraseña',
                          fillColor: Colors.white),
                      onSaved: (value) {
                        _password = value;
                      },
                      obscureText: _obscureText,
                      onEditingComplete: _submitForm,
                    ),
                  ),
                  Row(mainAxisAlignment: MainAxisAlignment.center, children: [
                    SizedBox(width: 10),
                    // ElevatedButton(
                    //     style: ButtonStyle(
                    //         backgroundColor:
                    //             MaterialStateProperty.all(Colors.amber),
                    //         shape: MaterialStateProperty.all<
                    //                 RoundedRectangleBorder>(
                    //             RoundedRectangleBorder(
                    //                 borderRadius: BorderRadius.circular(7),
                    //                 side: BorderSide(
                    //                     color: MyAppColors.backgroundColor)))),
                    //     onPressed: _submitForm,
                    //     child: Row(
                    //       mainAxisAlignment: MainAxisAlignment.center,
                    //       children: [
                    //         Icon(LineIcons.doorOpen),
                    //         SizedBox(width: 5),
                    //         Text('Entrar',
                    //             style: TextStyle(
                    //                 fontWeight: FontWeight.w500, fontSize: 17)),
                    //       ],
                    //     )),
                    RoundedLoadingButton(
                      borderRadius: 7,
                      height: 35,
                      width: 150,
                      curve: Curves.easeInCubic,
                      color: Colors.amber,
                      child: Text('Entrar',
                          style: TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.w500,
                              fontSize: 17)),
                      controller: _btnLoginController,
                      onPressed: _submitForm,
                    )
                    // SizedBox(width: 10)
                  ]),
                  Align(
                    alignment: Alignment.bottomRight,
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: TextButton(
                          onPressed: () {
                            dialogPassword(context);
                          },
                          child: Text('¿Haz olvidado tu contraseña?',
                              style: TextStyle(
                                  color: Theme.of(context).primaryColor))),
                    ),
                  )
                ]))
          ],
        ),
      )
    ]));
  }

  void sendPasswordResetEmail(String email, BuildContext context) async {
    try {
      await _auth.sendPasswordResetEmail(email: email);
      // .then((value) {
      //   return CoolAlert.show(
      //       context: context,
      //       title: '¡Te contactaremos!',
      //       type: CoolAlertType.success,
      //       confirmBtnColor: Colors.amber,
      //       text:
      //           'Se enviará un correo electrónico hacia la dirección: ${email}',
      //       animType: CoolAlertAnimType.slideInUp,
      //       backgroundColor: Theme.of(context).backgroundColor);
      // });
      CoolAlert.show(
          context: context,
          title: '¡Te contactaremos!',
          type: CoolAlertType.success,
          confirmBtnColor: Colors.amber,
          text: 'Se enviará un correo electrónico hacia la dirección: ${email}',
          animType: CoolAlertAnimType.slideInUp,
          backgroundColor: Theme.of(context).backgroundColor);
    } on FirebaseAuthException catch (e) {
      return CoolAlert.show(
          context: context,
          title: '¡Error!',
          type: CoolAlertType.error,
          confirmBtnColor: Colors.amber,
          text: e.message,
          animType: CoolAlertAnimType.slideInUp,
          backgroundColor: Theme.of(context).backgroundColor);
    }
  }

  Future<Widget> dialogPassword(BuildContext context) {
    return LovelyTextInputDialog(
      context: context,
      color: Colors.amber,
      leading: Icon(LineIcons.lock),
      confirmString: 'Enviar',
      title: 'Escribe tu correo electrónico',
      hintText: 'Correo electrónico',
      hintIcon: Icon(LineIcons.at, color: Colors.grey),
      onConfirm: (emailUser) {
        if (emailUser == null) {
          CoolAlert.show(
              context: context,
              title: '¡Hubo un error!',
              type: CoolAlertType.error,
              confirmBtnColor: Colors.amber,
              text: 'No escribio ningún correo electrónico',
              animType: CoolAlertAnimType.slideInUp,
              backgroundColor: Theme.of(context).backgroundColor);
        }
        final bool isValidEmail = EmailValidator.validate(emailUser);
        if (isValidEmail) {
          sendPasswordResetEmail(emailUser, context);
        } else {
          CoolAlert.show(
              context: context,
              title: '¡Error!',
              type: CoolAlertType.error,
              confirmBtnColor: Colors.amber,
              text: 'No es un email valido',
              animType: CoolAlertAnimType.slideInUp,
              backgroundColor: Theme.of(context).backgroundColor);
        }
      },
      onChange: (text) => print('Current string is ' + text),
    ).show();
  }
}
