import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:cool_alert/cool_alert.dart';
import 'package:ecommerce_application/utilities/my_app_colors.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:image_picker/image_picker.dart';
import 'package:line_icons/line_icons.dart';
import 'package:uuid/uuid.dart';

class UploadProduct extends StatefulWidget {
  static const routeName = '/UploadProduct';

  @override
  _UploadProductState createState() => _UploadProductState();
}

class _UploadProductState extends State<UploadProduct> {
  final _formKey = GlobalKey<FormState>();

  var _productName = '';
  var _productPrice = '';
  var _productCategory = '';
  var _productDistributor = '';
  var _productDescription = '';
  var _productQuantity = '';
  final TextEditingController _categoryController = TextEditingController();
  final TextEditingController _distributorController = TextEditingController();
  String _categoryValue;
  String _distributorValue;
  File _pickedImage;
  bool _isLoading = false;
  String _url;
  final FirebaseAuth _auth = FirebaseAuth.instance;
  var uuid = Uuid();

  showAlertDialog(BuildContext context, String title, String body) {
    // Se muestra el modal/dialogo
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text(title),
          content: Text(body),
          actions: [
            FlatButton(
              child: Text("OK"),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }

  void _trySubmit() async {
    final isValid = _formKey.currentState.validate();
    FocusScope.of(context).unfocus();
    print('Si paso');
    if (isValid) {
      _formKey.currentState.save();
      print(_productName);
      print(_productPrice);
      print(_productCategory);
      print(_productDistributor);
      print(_productDescription);
      print(_productQuantity);
    }

    if (isValid) {
      _formKey.currentState.save();
      try {
        if (_pickedImage == null) {
          CoolAlert.show(
              context: context,
              title: '¡No hay imagen!',
              type: CoolAlertType.error,
              confirmBtnColor: Colors.amber,
              text: 'Por favor debes ingresar una imagen para el producto',
              animType: CoolAlertAnimType.slideInUp,
              backgroundColor: Theme.of(context).backgroundColor);
        } else {
          setState(() {
            _isLoading = true;
          });
          final ref = FirebaseStorage.instance
              .ref()
              .child('productsImages')
              .child(_productName + '.jpg');
          await ref.putFile(_pickedImage);

          _url = await ref.getDownloadURL();

          final User user = _auth.currentUser;
          final _uidUser = user.uid;
          final _productId = uuid.v4();
          await FirebaseFirestore.instance
              .collection('products')
              .doc(_productId)
              .set({
            'productId': _productId,
            'productName': _productName,
            'price': _productPrice,
            'image': _url,
            'category': _productCategory,
            'distributor': _productDistributor,
            'description': _productDescription,
            'quantity': _productQuantity,
            'userId': _uidUser,
            'createdAt': Timestamp.now()
          });
          Navigator.canPop(context) ? Navigator.pop(context) : null;
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
        setState(() {
          _isLoading = false;
        });
      }
    } else {
      setState(() {
        _isLoading = false;
      });
    }
  }

  void _pickImageCamera() async {
    final picker = ImagePicker();
    final pickedImage = await picker.getImage(
      source: ImageSource.camera,
      imageQuality: 40,
    );
    final pickedImageFile = File(pickedImage.path);
    setState(() {
      _pickedImage = pickedImageFile;
    });
  }

  void _pickImageGallery() async {
    final picker = ImagePicker();
    final pickedImage = await picker.getImage(
      source: ImageSource.gallery,
      imageQuality: 50,
    );
    final pickedImageFile = pickedImage == null ? null : File(pickedImage.path);

    setState(() {
      _pickedImage = pickedImageFile;
    });
  }

  void _removeImage() {
    setState(() {
      _pickedImage = null;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomSheet: Container(
        height: kBottomNavigationBarHeight * 0.8,
        width: double.infinity,
        decoration: BoxDecoration(
          color: MyAppColors.white,
          border: Border(
            top: BorderSide(
              color: Colors.grey,
              width: 0.5,
            ),
          ),
        ),
        child: Material(
          color: Theme.of(context).backgroundColor,
          child: InkWell(
            onTap: _trySubmit,
            splashColor: Colors.grey,
            child: _isLoading
                ? Center(child: CircularProgressIndicator())
                : Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    mainAxisSize: MainAxisSize.max,
                    children: <Widget>[
                      Padding(
                        padding: const EdgeInsets.only(right: 2),
                        child: Text('Subir producto',
                            style: TextStyle(fontSize: 16),
                            textAlign: TextAlign.center),
                      ),
                      GradientIcon(
                        LineIcons.upload,
                        20,
                        LinearGradient(
                          colors: <Color>[
                            Colors.green,
                            Colors.yellow,
                            Colors.deepOrange,
                            Colors.orange,
                            Colors.yellow[800]
                          ],
                          begin: Alignment.topLeft,
                          end: Alignment.bottomRight,
                        ),
                      ),
                    ],
                  ),
          ),
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Center(
              child: Card(
                margin: EdgeInsets.all(15),
                child: Padding(
                  padding: EdgeInsets.all(16),
                  child: Form(
                    key: _formKey,
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: <Widget>[
                        Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Flexible(
                              flex: 3,
                              child: Padding(
                                padding: const EdgeInsets.only(right: 9),
                                child: TextFormField(
                                  key: ValueKey('Name'),
                                  validator: (value) {
                                    if (value.isEmpty) {
                                      return 'Introduce el nombre';
                                    }
                                    return null;
                                  },
                                  keyboardType: TextInputType.name,
                                  decoration: InputDecoration(
                                    labelText: 'Nombre del producto',
                                    labelStyle: TextStyle(
                                        color: Theme.of(context).hintColor),
                                  ),
                                  onSaved: (value) {
                                    _productName = value;
                                  },
                                ),
                              ),
                            ),
                            Flexible(
                              flex: 1,
                              child: TextFormField(
                                key: ValueKey('Price \$'),
                                keyboardType: TextInputType.number,
                                validator: (value) {
                                  if (value.isEmpty) {
                                    return 'Introduce un precio';
                                  }
                                  return null;
                                },
                                inputFormatters: <TextInputFormatter>[
                                  FilteringTextInputFormatter.allow(
                                      RegExp(r'[0-9]')),
                                ],
                                decoration: InputDecoration(
                                  labelText: 'Precio \$',
                                  labelStyle: TextStyle(
                                      color: Theme.of(context).hintColor),
                                ),
                                onSaved: (value) {
                                  _productPrice = value;
                                },
                              ),
                            ),
                          ],
                        ),
                        SizedBox(height: 10),
                        /* Picker image */
                        Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: <Widget>[
                            Expanded(
                              child: this._pickedImage == null
                                  ? Container(
                                      margin: EdgeInsets.all(10),
                                      height: 200,
                                      width: 200,
                                      decoration: BoxDecoration(
                                        border: Border.all(width: 1),
                                        borderRadius: BorderRadius.circular(4),
                                        color:
                                            Theme.of(context).backgroundColor,
                                      ),
                                    )
                                  : Container(
                                      margin: EdgeInsets.all(10),
                                      height: 200,
                                      width: 200,
                                      child: Container(
                                        height: 200,
                                        decoration: BoxDecoration(
                                          color:
                                              Theme.of(context).backgroundColor,
                                        ),
                                        child: Image.file(
                                          this._pickedImage,
                                          fit: BoxFit.contain,
                                          alignment: Alignment.center,
                                        ),
                                      ),
                                    ),
                            ),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                FittedBox(
                                  child: FlatButton.icon(
                                    textColor: Colors.white,
                                    onPressed: _pickImageCamera,
                                    icon:
                                        Icon(Icons.camera, color: Colors.amber),
                                    label: Text(
                                      'Cámara',
                                      style: TextStyle(
                                        fontWeight: FontWeight.w500,
                                        color: Theme.of(context)
                                            .textSelectionColor,
                                      ),
                                    ),
                                  ),
                                ),
                                FittedBox(
                                  child: FlatButton.icon(
                                    textColor: Colors.white,
                                    onPressed: _pickImageGallery,
                                    icon:
                                        Icon(Icons.image, color: Colors.amber),
                                    label: Text(
                                      'Galería',
                                      style: TextStyle(
                                        fontWeight: FontWeight.w500,
                                        color: Theme.of(context)
                                            .textSelectionColor,
                                      ),
                                    ),
                                  ),
                                ),
                                FittedBox(
                                  child: FlatButton.icon(
                                    textColor: Colors.white,
                                    onPressed: _removeImage,
                                    icon: Icon(LineIcons.minusCircle,
                                        color: Colors.red[400]),
                                    label: Text(
                                      'Eliminar',
                                      style: TextStyle(
                                        fontWeight: FontWeight.w500,
                                        color: Colors.redAccent,
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                        Row(
                          crossAxisAlignment: CrossAxisAlignment.end,
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Expanded(
                              // flex: 3,
                              child: Padding(
                                padding: const EdgeInsets.only(right: 9),
                                child: Container(
                                  child: TextFormField(
                                    controller: _categoryController,
                                    keyboardType: TextInputType.name,
                                    key: ValueKey('Category'),
                                    validator: (value) {
                                      if (value.isEmpty) {
                                        return 'Por favor agrega una categoría';
                                      }
                                      return null;
                                    },
                                    decoration: InputDecoration(
                                      labelText: 'Nueva categoría',
                                      labelStyle: TextStyle(
                                          color: Theme.of(context).hintColor),
                                    ),
                                    onSaved: (value) {
                                      _productCategory = value;
                                    },
                                  ),
                                ),
                              ),
                            ),
                            DropdownButton<String>(
                              items: [
                                DropdownMenuItem<String>(
                                  child: Text('Verduras'),
                                  value: 'Verduras',
                                ),
                                DropdownMenuItem<String>(
                                  child: Text('Frutas'),
                                  value: 'Frutas',
                                ),
                                DropdownMenuItem<String>(
                                  child: Text('Carne'),
                                  value: 'Carne',
                                ),
                                DropdownMenuItem<String>(
                                  child: Text('Pollo'),
                                  value: 'Pollo',
                                ),
                                DropdownMenuItem<String>(
                                  child: Text('Pescado'),
                                  value: 'Pescado',
                                ),
                                DropdownMenuItem<String>(
                                  child: Text('Bebidas'),
                                  value: 'Bebidas',
                                ),
                                DropdownMenuItem<String>(
                                  child: Text('Higiene personal'),
                                  value: 'Higiene personal',
                                ),
                                DropdownMenuItem<String>(
                                  child: Text('Legumbres'),
                                  value: 'Legumbres',
                                ),
                                DropdownMenuItem<String>(
                                  child: Text('Mascotas'),
                                  value: 'Mascotas',
                                ),
                                DropdownMenuItem<String>(
                                  child: Text('Pan'),
                                  value: 'Pan',
                                ),
                                DropdownMenuItem<String>(
                                  child: Text('Quesos'),
                                  value: 'Quesos',
                                ),
                              ],
                              onChanged: (String value) {
                                setState(() {
                                  _categoryValue = value;
                                  _categoryController.text = value;
                                  print(_productCategory);
                                });
                              },
                              hint: Text('Elige una categoría'),
                              value: _categoryValue,
                            ),
                          ],
                        ),
                        SizedBox(height: 10),
                        Row(
                          crossAxisAlignment: CrossAxisAlignment.end,
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Expanded(
                              child: Padding(
                                padding: const EdgeInsets.only(right: 9),
                                child: Container(
                                  child: TextFormField(
                                    controller: _distributorController,
                                    keyboardType: TextInputType.name,
                                    key: ValueKey('Distributor'),
                                    validator: (value) {
                                      if (value.isEmpty) {
                                        return 'El distribuidor esta vacío';
                                      }
                                      return null;
                                    },
                                    decoration: InputDecoration(
                                      labelText: 'Nuevo distribuidor',
                                      labelStyle: TextStyle(
                                          color: Theme.of(context).hintColor),
                                    ),
                                    onSaved: (value) {
                                      _productDistributor = value;
                                    },
                                  ),
                                ),
                              ),
                            ),
                            DropdownButton<String>(
                              items: [
                                DropdownMenuItem<String>(
                                  child: Text('Bachoco'),
                                  value: 'Bachoco',
                                ),
                                DropdownMenuItem<String>(
                                  child: Text('Bimbo'),
                                  value: 'Bimbo',
                                ),
                                DropdownMenuItem<String>(
                                  child: Text('Lala'),
                                  value: 'Lala',
                                ),
                                DropdownMenuItem<String>(
                                  child: Text('Pepsi'),
                                  value: 'Pepsi',
                                ),
                                DropdownMenuItem<String>(
                                  child: Text('Nestlé'),
                                  value: 'Nestlé',
                                ),
                                DropdownMenuItem<String>(
                                  child: Text('La Costeña'),
                                  value: 'La Costeña',
                                ),
                                DropdownMenuItem<String>(
                                  child: Text('Grupo Herdez'),
                                  value: 'Grupo Herdez',
                                ),
                                DropdownMenuItem<String>(
                                  child: Text('Independiente'),
                                  value: 'Independiente',
                                ),
                              ],
                              onChanged: (String value) {
                                setState(() {
                                  _distributorValue = value;
                                  _distributorController.text = value;
                                  print(_productDistributor);
                                });
                              },
                              hint: Text('Elige un distribuidor'),
                              value: _distributorValue,
                            ),
                          ],
                        ),
                        SizedBox(height: 15),
                        TextFormField(
                            key: ValueKey('Description'),
                            keyboardType: TextInputType.name,
                            validator: (value) {
                              if (value.isEmpty) {
                                return 'La descripción es requerida';
                              }
                              return null;
                            },
                            maxLines: 10,
                            textCapitalization: TextCapitalization.sentences,
                            decoration: InputDecoration(
                              labelText: 'Descripción',
                              hintText: 'La descripción del producto',
                              border: OutlineInputBorder(),
                              labelStyle:
                                  TextStyle(color: Theme.of(context).hintColor),
                            ),
                            onSaved: (value) {
                              _productDescription = value;
                            },
                            onChanged: (text) {
                              // setState(() => charLength -= text.length);
                            }),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          crossAxisAlignment: CrossAxisAlignment.end,
                          children: [
                            Expanded(
                              //flex: 2,
                              child: Padding(
                                padding: const EdgeInsets.only(right: 9),
                                child: TextFormField(
                                  keyboardType: TextInputType.number,
                                  key: ValueKey('Quantity'),
                                  validator: (value) {
                                    if (value.isEmpty) {
                                      return 'Introduce una cantidad';
                                    }
                                    return null;
                                  },
                                  decoration: InputDecoration(
                                    labelText: 'Cantidad',
                                    labelStyle: TextStyle(
                                        color: Theme.of(context).hintColor),
                                  ),
                                  onSaved: (value) {
                                    _productQuantity = value;
                                  },
                                ),
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
            SizedBox(
              height: 50,
            )
          ],
        ),
      ),
    );
  }
}

class GradientIcon extends StatelessWidget {
  GradientIcon(
    this.icon,
    this.size,
    this.gradient,
  );

  final IconData icon;
  final double size;
  final Gradient gradient;

  @override
  Widget build(BuildContext context) {
    return ShaderMask(
      child: SizedBox(
        width: size * 1.2,
        height: size * 1.2,
        child: Icon(
          icon,
          size: size,
          color: Colors.white,
        ),
      ),
      shaderCallback: (Rect bounds) {
        final Rect rect = Rect.fromLTRB(0, 0, size, size);
        return gradient.createShader(rect);
      },
    );
  }
}
