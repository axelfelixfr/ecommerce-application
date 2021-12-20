import 'package:ecommerce_application/utilities/my_app_colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:line_icons/line_icons.dart';
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

  @override
  void dispose() {
    _passwordFocusNode.dispose();
    super.dispose();
  }

  void _submitForm() {
    final isValid = _formKey.currentState.validate();
    FocusScope.of(context).unfocus();
    if (isValid) {
      _formKey.currentState.save();
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
      Column(
        children: [
          Container(
              margin: EdgeInsets.only(top: 80),
              height: 90.0,
              // width: 120.0,
              // decoration: BoxDecoration(
              //     color: Colors.white,
              //     borderRadius: BorderRadius.circular(20),
              //     image: DecorationImage(
              //         image: AssetImage('assets/img/MercadoADistancia.png'),
              //         fit: BoxFit.fill),
              //     shape: BoxShape.rectangle)
              child: Image.asset('assets/img/MercadoADistanciaYellow.png')),
          SizedBox(height: 30),
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
                    onEditingComplete: () =>
                        FocusScope.of(context).requestFocus(_passwordFocusNode),
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
                  ElevatedButton(
                      style: ButtonStyle(
                          backgroundColor:
                              MaterialStateProperty.all(Colors.amber),
                          shape:
                              MaterialStateProperty.all<RoundedRectangleBorder>(
                                  RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(7),
                                      side: BorderSide(
                                          color:
                                              MyAppColors.backgroundColor)))),
                      onPressed: _submitForm,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(LineIcons.doorOpen),
                          SizedBox(width: 5),
                          Text('Entrar',
                              style: TextStyle(
                                  fontWeight: FontWeight.w500, fontSize: 17)),
                        ],
                      )),
                  // SizedBox(width: 10)
                ]),
              ]))
        ],
      )
    ]));
  }
}
