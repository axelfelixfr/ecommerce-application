import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:cool_alert/cool_alert.dart';
import 'package:ecommerce_application/utilities/my_app_colors.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:image_picker/image_picker.dart';
import 'package:line_icons/line_icons.dart';
import 'package:rounded_loading_button/rounded_loading_button.dart';
import 'package:wave/config.dart';
import 'package:wave/wave.dart';
import 'dart:io';

class SignUpPage extends StatefulWidget {
  static const routeName = '/SignUpPage';

  @override
  _SignUpPageState createState() => _SignUpPageState();
}

class _SignUpPageState extends State<SignUpPage> {
  final FocusNode _passwordFocusNode = FocusNode();
  final FocusNode _emailFocusNode = FocusNode();
  final FocusNode _phoneNumberFocusNode = FocusNode();
  String _emailAddress = '';
  String _password = '';
  String _fullName = '';
  int _phoneNumber;
  File _pickedImage;
  String _url;
  bool _obscureText = true;
  final _formKey = GlobalKey<FormState>();
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final RoundedLoadingButtonController _btnRegisterController =
      new RoundedLoadingButtonController();

  @override
  void dispose() {
    _passwordFocusNode.dispose();
    _emailFocusNode.dispose();
    _phoneNumberFocusNode.dispose();
    super.dispose();
  }

  void _submitForm() async {
    final isValid = _formKey.currentState.validate();
    FocusScope.of(context).unfocus();
    var date = DateTime.now().toString();
    var parseDate = DateTime.parse(date);
    var formattedDate = "${parseDate.day}-${parseDate.month}-${parseDate.year}";
    if (isValid) {
      _btnRegisterController.start();
      _formKey.currentState.save();
      try {
        if (_pickedImage == null) {
          CoolAlert.show(
              context: context,
              title: '¡No hay imagen!',
              type: CoolAlertType.error,
              confirmBtnColor: Colors.amber,
              text: 'Por favor debes ingresar una imagen para crear una cuenta',
              animType: CoolAlertAnimType.slideInUp,
              backgroundColor: Theme.of(context).backgroundColor);
          _btnRegisterController.stop();
        } else {
          final ref = FirebaseStorage.instance
              .ref()
              .child('userImages')
              .child(_emailAddress + '.jpg');
          await ref.putFile(_pickedImage);

          _url = await ref.getDownloadURL();

          await _auth.createUserWithEmailAndPassword(
              email: _emailAddress.trim(), password: _password.trim());
          final User user = _auth.currentUser;
          final _uid = user.uid;
          await user.updateProfile(displayName: _fullName, photoURL: _url);
          await user.reload();
          await FirebaseFirestore.instance.collection('users').doc(_uid).set({
            'id': _uid,
            'name': _fullName,
            'email': _emailAddress,
            'phoneNumber': _phoneNumber,
            'imageUrl': _url,
            'joinedAt': formattedDate,
            'createdAt': Timestamp.now()
          }).then((value) {
            //  print('Si paso $value');
            _btnRegisterController.success();
            Navigator.canPop(context) ? Navigator.pop(context) : null;
          });
        }
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
        _btnRegisterController.stop();
      }
    } else {
      _btnRegisterController.stop();
    }
  }

  void _pickImageCamera() async {
    final picker = ImagePicker();
    final pickedImage =
        await picker.getImage(source: ImageSource.camera, imageQuality: 50);
    final pickedImageFile = File(pickedImage.path);
    setState(() {
      _pickedImage = pickedImageFile;
    });
    Navigator.pop(context);
  }

  void _pickImageGallery() async {
    final picker = ImagePicker();
    final pickedImage = await picker.getImage(source: ImageSource.gallery);
    final pickedImageFile = File(pickedImage.path);
    setState(() {
      _pickedImage = pickedImageFile;
    });
    Navigator.pop(context);
  }

  void _removeImage() {
    setState(() {
      _pickedImage = null;
    });
    Navigator.pop(context);
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
            SizedBox(height: 30),
            Stack(children: [
              Container(
                  margin: EdgeInsets.symmetric(vertical: 30, horizontal: 30),
                  child: CircleAvatar(
                      radius: 71,
                      backgroundColor: MyAppColors.starterColor,
                      child: CircleAvatar(
                        backgroundColor: MyAppColors.endColor,
                        radius: 65,
                        backgroundImage: _pickedImage == null
                            ? null
                            : FileImage(_pickedImage),
                      ))),
              Positioned(
                  top: 120,
                  left: 110,
                  child: RawMaterialButton(
                      onPressed: () {
                        showDialog(
                            context: context,
                            builder: (BuildContext context) {
                              return AlertDialog(
                                title: Text('Cambiar opción',
                                    style: TextStyle(
                                        fontWeight: FontWeight.w600,
                                        color: MyAppColors.endColor)),
                                content: SingleChildScrollView(
                                    child: ListBody(children: [
                                  InkWell(
                                      onTap: _pickImageCamera,
                                      splashColor: Colors.amberAccent,
                                      child: Row(children: [
                                        Padding(
                                          padding: const EdgeInsets.all(8.0),
                                          child: Icon(Icons.camera,
                                              color: Colors.amber),
                                        ),
                                        Text('Cámara',
                                            style: TextStyle(
                                                fontSize: 18,
                                                fontWeight: FontWeight.w500,
                                                color: MyAppColors.title))
                                      ])),
                                  InkWell(
                                      onTap: _pickImageGallery,
                                      splashColor: Colors.amberAccent,
                                      child: Row(children: [
                                        Padding(
                                          padding: const EdgeInsets.all(8.0),
                                          child: Icon(LineIcons.photoVideo,
                                              color: Colors.amber),
                                        ),
                                        Text('Galería',
                                            style: TextStyle(
                                                fontSize: 18,
                                                fontWeight: FontWeight.w500,
                                                color: MyAppColors.title))
                                      ])),
                                  InkWell(
                                      onTap: _removeImage,
                                      splashColor: Colors.amberAccent,
                                      child: Row(children: [
                                        Padding(
                                          padding: const EdgeInsets.all(8.0),
                                          child: Icon(LineIcons.minusCircle,
                                              color: Colors.red[400]),
                                        ),
                                        Text('Eliminar',
                                            style: TextStyle(
                                                fontSize: 18,
                                                fontWeight: FontWeight.w500,
                                                color: Colors.red[400]))
                                      ]))
                                ])),
                              );
                            });
                      },
                      elevation: 10,
                      fillColor: MyAppColors.starterColor,
                      child: Icon(LineIcons.retroCamera,
                          color: Colors.white, size: 25),
                      padding: EdgeInsets.all(15.0),
                      shape: CircleBorder()))
            ]),
            Form(
                key: _formKey,
                child: Column(children: [
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 12),
                    child: TextFormField(
                      style: TextStyle(color: Colors.black),
                      key: ValueKey('name'),
                      validator: (value) {
                        if (value.isEmpty || value.length < 4) {
                          return 'Por favor ingresa un nombre válido';
                        }
                        return null;
                      },
                      textInputAction: TextInputAction.next,
                      onEditingComplete: () =>
                          FocusScope.of(context).requestFocus(_emailFocusNode),
                      keyboardType: TextInputType.name,
                      decoration: InputDecoration(
                          labelStyle: TextStyle(color: Colors.black87),
                          border: const UnderlineInputBorder(),
                          filled: true,
                          prefixIcon: Icon(LineIcons.user, color: Colors.grey),
                          labelText: 'Nombre',
                          fillColor: Colors.white),
                      onSaved: (value) {
                        _fullName = value;
                      },
                    ),
                  ),
                  SizedBox(height: 10),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 12),
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
                      focusNode: _emailFocusNode,
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
                  SizedBox(height: 10),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 12),
                    child: TextFormField(
                      style: TextStyle(color: Colors.black),
                      key: ValueKey('password'),
                      validator: (value) {
                        if (value.isEmpty || value.length < 7) {
                          return 'Por favor ingresa una contraseña válida';
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
                      onEditingComplete: () => FocusScope.of(context)
                          .requestFocus(_phoneNumberFocusNode),
                    ),
                  ),
                  SizedBox(height: 10),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 12),
                    child: TextFormField(
                      style: TextStyle(color: Colors.black),
                      key: ValueKey('phone number'),
                      validator: (value) {
                        if (value.isEmpty) {
                          return 'Por favor ingresa un número telefonico válido';
                        }
                        return null;
                      },
                      inputFormatters: [FilteringTextInputFormatter.digitsOnly],
                      textInputAction: TextInputAction.next,
                      onEditingComplete: _submitForm,
                      keyboardType: TextInputType.phone,
                      focusNode: _phoneNumberFocusNode,
                      decoration: InputDecoration(
                          labelStyle: TextStyle(color: Colors.black87),
                          border: const UnderlineInputBorder(),
                          filled: true,
                          prefixIcon:
                              Icon(LineIcons.mobilePhone, color: Colors.grey),
                          labelText: 'Número de teléfono',
                          fillColor: Colors.white),
                      onSaved: (value) {
                        _phoneNumber = int.parse(value);
                      },
                    ),
                  ),
                  SizedBox(height: 20),
                  Row(mainAxisAlignment: MainAxisAlignment.center, children: [
                    // ElevatedButton(
                    //     style: ButtonStyle(
                    //         backgroundColor: MaterialStateProperty.all(
                    //             Colors.orange.shade400),
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
                    //         Icon(LineIcons.userPlus),
                    //         SizedBox(width: 5),
                    //         Text('Crear cuenta',
                    //             style: TextStyle(
                    //                 fontWeight: FontWeight.w500, fontSize: 17)),
                    //       ],
                    //     )),
                    RoundedLoadingButton(
                      borderRadius: 7,
                      height: 35,
                      width: 150,
                      curve: Curves.easeInCubic,
                      color: Colors.orange.shade400,
                      child: Text('Crear cuenta',
                          style: TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.w500,
                              fontSize: 17)),
                      controller: _btnRegisterController,
                      onPressed: _submitForm,
                    )
                    // SizedBox(width: 10)
                  ]),
                ]))
          ],
        ),
      )
    ]));
  }
}
