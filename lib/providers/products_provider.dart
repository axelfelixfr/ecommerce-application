import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:ecommerce_application/models/product.dart';
import 'package:flutter/material.dart';

class ProductsProvider with ChangeNotifier {
  List<Product> _products = [];
  List<Product> get products {
    return [..._products];
  }

  Future<void> fetchProducts() async {
    await FirebaseFirestore.instance
        .collection('products')
        .get()
        .then((QuerySnapshot productsSnapshot) {
      _products = [];
      productsSnapshot.docs.forEach((productItem) {
        _products.insert(
            0,
            Product(
                id: productItem.get('productId'),
                name: productItem.get('productName'),
                description: productItem.get('description'),
                price: double.parse(productItem.get('price')),
                imageUrl: productItem.get('image'),
                distributor: productItem.get('distributor'),
                productCategoryName: productItem.get('category'),
                quantity: int.parse(productItem.get('quantity')),
                isPopular: true));
      });
    });
  }

  List<Product> get popularProducts {
    return _products.where((element) => element.isPopular).toList();
  }

  Product findByID(String productId) {
    return _products.firstWhere((element) => element.id == productId);
  }

  List<Product> findByCategory(String categoryName) {
    List _categoryList = _products
        .where((element) => element.productCategoryName
            .toLowerCase()
            .contains(categoryName.toLowerCase()))
        .toList();

    return _categoryList;
  }

  List<Product> searchQuery(String searchText) {
    List _productsList = _products
        .where((element) =>
            element.name.toLowerCase().contains(searchText.toLowerCase()))
        .toList();

    return _productsList;
  }

  /*
  List<Product> _products = [
    Product(
        id: 'Longaniza',
        name: 'Longaniza',
        description: '1 kg de longaniza',
        price: 50.99,
        imageUrl:
            'https://images-na.ssl-images-amazon.com/images/I/81%2Bh9mpyQmL._AC_SL1500_.jpg',
        brand: 'Desconocida',
        productCategoryName: 'Carne',
        quantity: 65,
        isPopular: false),
    Product(
        id: 'Pechuga de pollo',
        name: 'Pechuga de pollo',
        description: '1 pechuga de pollo entera',
        price: 50.99,
        imageUrl:
            'https://images-na.ssl-images-amazon.com/images/I/51ME-ADMjRL._AC_SL1000_.jpg',
        brand: 'Desconocida',
        productCategoryName: 'Pollo',
        quantity: 1002,
        isPopular: false),
    Product(
        id: 'Camaron de mar',
        name: 'Camaron de mar',
        description: '1 kg de camaron de mar',
        price: 50.99,
        imageUrl:
            'https://images-na.ssl-images-amazon.com/images/I/61HFJwSDQ4L._AC_SL1000_.jpg',
        brand: 'Desconocida',
        productCategoryName: 'Pescado',
        quantity: 6423,
        isPopular: true),
    Product(
        id: 'Jitomate',
        name: 'Jitomate',
        description: '1 Kg de jitomate',
        price: 9.99,
        imageUrl:
            'https://images-na.ssl-images-amazon.com/images/I/6186cnZIdoL._AC_SL1000_.jpg',
        brand: 'Desconocida',
        productCategoryName: 'Verdura',
        quantity: 3,
        isPopular: true),
    Product(
        id: 'Sandia',
        name: 'Sandia',
        description: '1 Sandia entera',
        price: 11.00,
        imageUrl: 'https://m.media-amazon.com/images/I/71cSV-RTBSL.jpg',
        brand: 'Desconocida',
        productCategoryName: 'Fruta',
        quantity: 3,
        isPopular: true),
    Product(
        id: 'Carne Hamburguesa',
        name: 'Carne Hamburguesa',
        description: '1 kg de carne para hamburguesa',
        price: 50.99,
        imageUrl:
            'https://m.media-amazon.com/images/I/71XXJC7V8tL._FMwebp__.jpg',
        brand: 'Apple',
        productCategoryName: 'Carne',
        quantity: 2654,
        isPopular: false),
    Product(
        id: 'Melon',
        name: 'Melon',
        description: '1 kg de melon',
        price: 22.30,
        imageUrl:
            'https://images-na.ssl-images-amazon.com/images/I/91YHIgoKb4L._AC_UX425_.jpg',
        brand: 'No brand',
        productCategoryName: 'Fruta',
        quantity: 58466,
        isPopular: true),
    Product(
        id: 'Jugo',
        name: 'Jugo',
        description: '1 jugo',
        price: 58.99,
        imageUrl:
            'https://m.media-amazon.com/images/I/71g7tHQt-sL._AC_UL320_.jpg',
        brand: 'Desconocida',
        productCategoryName: 'Bebidas',
        quantity: 84894,
        isPopular: false),
    Product(
        id: 'Cubrebocas',
        name: 'Cubrebocas',
        description: '1 paquete de cubrebocas con 12 piezas',
        price: 50.99,
        imageUrl:
            'https://images-na.ssl-images-amazon.com/images/I/7177o9jITiL._AC_UX466_.jpg',
        brand: 'Desconocida',
        productCategoryName: 'Higiene Personal',
        quantity: 49847,
        isPopular: true),
    Product(
        id: 'Queso oaxaca',
        name: 'Queso oaxaca',
        description: '1 kg de queso oaxaca',
        price: 191.89,
        imageUrl:
            'https://images-na.ssl-images-amazon.com/images/I/71KVPm5KJdL._AC_UX500_.jpg',
        brand: 'Desconocida',
        productCategoryName: 'Quesos',
        quantity: 65489,
        isPopular: false),
    Product(
        id: 'Manzana',
        name: 'Manzana',
        description: '1 kg de manzana',
        price: 189.99,
        imageUrl:
            'https://images-na.ssl-images-amazon.com/images/I/61jvFw72OVL._AC_UX466_.jpg',
        brand: 'Desconocida',
        productCategoryName: 'Fruta',
        quantity: 89741,
        isPopular: false),
    Product(
        id: 'Pitahaya',
        name: 'Pitahaya',
        description: '1 pitahaya entera',
        price: 88.88,
        imageUrl:
            'https://images-na.ssl-images-amazon.com/images/I/51KMhoElQcL._AC_UX466_.jpg',
        brand: 'Desconocida',
        productCategoryName: 'Fruta',
        quantity: 8941,
        isPopular: true),
    Product(
        id: 'Banana',
        name: 'Banana',
        description: '1 kg de banana',
        price: 68.29,
        imageUrl:
            'https://images-na.ssl-images-amazon.com/images/I/71lKAfQDUoL._AC_UX466_.jpg',
        brand: 'Desconocida',
        productCategoryName: 'Fruta',
        quantity: 3,
        isPopular: false),
    Product(
        id: 'Carne de res',
        name: 'Carne de res',
        description: '1 kg de carne de res',
        price: 54.98,
        imageUrl:
            'https://images-na.ssl-images-amazon.com/images/I/61dwB-2X-6L._SL1500_.jpg',
        brand: 'Desconocida',
        productCategoryName: 'Carne',
        quantity: 8515,
        isPopular: false),
    Product(
        id: 'Brocoli',
        name: 'Brocoli',
        description: '1 kg de brocoli',
        price: 80.99,
        imageUrl:
            'https://images-na.ssl-images-amazon.com/images/I/81w9cll2RmL._SL1500_.jpg',
        brand: 'Desconocida',
        productCategoryName: 'Verdura',
        quantity: 3,
        isPopular: false),
    Product(
        id: 'Alas de pollo',
        name: 'Alas de pollo',
        description: '1 kg de alas de pollo',
        price: 50.99,
        imageUrl:
            'https://images-na.ssl-images-amazon.com/images/I/71E6h0kl3ZL._SL1500_.jpg',
        brand: 'Desconocida',
        productCategoryName: 'Pollo',
        quantity: 38425,
        isPopular: true),
    Product(
        id: 'Pimiento Amarillo',
        name: 'Pimiento Amarillo',
        description: '1 kg de pimiento amarillo',
        price: 14,
        imageUrl:
            'https://images-na.ssl-images-amazon.com/images/I/61RkTTLRnNL._SL1134_.jpg',
        brand: '',
        productCategoryName: 'Verdura',
        quantity: 384,
        isPopular: false),
    Product(
        id: 'Pimiento Rojo',
        name: 'Pimiento Rojo',
        description: '1 kg de pimiento rojo',
        price: 50.99,
        imageUrl:
            'https://images-na.ssl-images-amazon.com/images/I/619pgKveCdL._SL1500_.jpg',
        brand: 'Desconocida',
        productCategoryName: 'Verdura',
        quantity: 45,
        isPopular: true),
    Product(
        id: 'Refresco de 2 Lt Coca-cola',
        name: 'Refresco de 2 Lt Coca-cola',
        description: '1 Refresco de 2 Lt Coca-cola',
        price: 84.99,
        imageUrl:
            'https://images-na.ssl-images-amazon.com/images/I/61EsS5sSaCL._SL1500_.jpg',
        brand: 'Coca-cola',
        productCategoryName: 'Bebidas',
        quantity: 98432,
        isPopular: true),
    Product(
        id: 'Arroz blanco',
        name: 'Arroz blanco',
        description: '1 kg de arroz blanco',
        price: 890.99,
        imageUrl:
            'https://images-na.ssl-images-amazon.com/images/I/71e7ksQ-xyL._AC_SL1500_.jpg',
        brand: 'Desconocida',
        productCategoryName: 'Legumbres',
        quantity: 3811,
        isPopular: false),
    Product(
        id: 'Frijoles negros',
        name: 'Frijoles negros',
        description: '1 kg de frijoles negros',
        price: 630.99,
        imageUrl:
            'https://images-na.ssl-images-amazon.com/images/I/31ZSymDl-YL._AC_.jpg',
        brand: 'Desconocida',
        productCategoryName: 'Legumbres',
        quantity: 325,
        isPopular: true),
    Product(
        id: 'Lentejas',
        name: 'Lentejas',
        description: '1 kg de lentejas',
        price: 1220.99,
        imageUrl:
            'https://images-na.ssl-images-amazon.com/images/I/71W690nu%2BXL._AC_SL1500_.jpg',
        brand: 'Desconocida',
        productCategoryName: 'Legumbres',
        quantity: 81,
        isPopular: true),
    Product(
        id: 'Queso panela',
        name: 'Queso panela',
        description: '1 kg de queso panela',
        price: 1220.99,
        imageUrl:
            'https://images-na.ssl-images-amazon.com/images/I/41OfZx5ex3L._AC_.jpg',
        brand: 'Desconocida',
        productCategoryName: 'Quesos',
        quantity: 815,
        isPopular: false),
    Product(
        id: 'Queso doble crema',
        name: 'Queso doble crema',
        description: '1 kg de queso crema',
        price: 800.99,
        imageUrl:
            'https://images-na.ssl-images-amazon.com/images/I/71an9eiBxpL._AC_SL1500_.jpg',
        brand: 'Desconocida',
        productCategoryName: 'Quesos',
        quantity: 885,
        isPopular: true),
    Product(
        id: 'Queso amarillo',
        name: 'Queso amarillo',
        description: '1 kg de queso amarillo',
        price: 1220.99,
        imageUrl:
            'https://images-na.ssl-images-amazon.com/images/I/61wLbRLshAL._AC_SL1200_.jpg',
        brand: 'Desconocida',
        productCategoryName: 'Quesos',
        quantity: 815,
        isPopular: true),
    Product(
        id: 'Zanahoria',
        name: 'Zanahoria',
        description: '1 kg de zanahoria',
        price: 700.89,
        imageUrl:
            'https://images-na.ssl-images-amazon.com/images/I/315CQ1KmlwL._AC_.jpg',
        brand: 'Desconocida',
        productCategoryName: 'Verdura',
        quantity: 815,
        isPopular: false),
    Product(
        id: 'Kiwi',
        name: 'Kiwi',
        description: '1 kg de kiwi',
        price: 780.99,
        imageUrl:
            'https://images-na.ssl-images-amazon.com/images/I/61QRQHn0jJL._AC_SL1200_.jpg',
        brand: 'Desconocida',
        productCategoryName: 'Fruta',
        quantity: 4455,
        isPopular: true),
    Product(
        id: 'Bisteces',
        name: 'Bisteces',
        description: '1 kg de bisteces',
        price: 800.99,
        imageUrl:
            'https://images-na.ssl-images-amazon.com/images/I/61qNHbx9LDL._AC_SL1200_.jpg',
        brand: 'Desconocida',
        productCategoryName: 'Carne',
        quantity: 885,
        isPopular: false),
    Product(
        id: 'Bolillo',
        name: 'Bolillo',
        description: '3 piezas de bolillo',
        price: 9.99,
        imageUrl:
            'https://images-na.ssl-images-amazon.com/images/I/71P-p2sj6eL._AC_SL1500_.jpg',
        brand: 'Desconocida',
        productCategoryName: 'Pan',
        quantity: 91,
        isPopular: true),
    Product(
        id: 'Concha de pan dulce',
        name: 'Concha de pan dulce',
        description: '3 piezas de concha de pan de dulce',
        price: 120.99,
        imageUrl:
            'https://images-na.ssl-images-amazon.com/images/I/71xytsyiHzL._AC_SL1500_.jpg',
        brand: 'Desconocida',
        productCategoryName: 'Pan',
        quantity: 815,
        isPopular: false),
    Product(
        id: 'Chilindrina de pan dulce',
        name: 'Chilindrina de pan dulce',
        description: '3 piezas de chilindrina de pan dulce',
        price: 1220.99,
        imageUrl:
            'https://images-na.ssl-images-amazon.com/images/I/81sBT3voCPL._AC_SL1500_.jpg',
        brand: 'No brand',
        productCategoryName: 'Pan',
        quantity: 8100,
        isPopular: true),
    Product(
        id: 'Pasta de diente Colgate',
        name: 'Pasta de diente Colgate',
        description: '1 paquete de pasta dental Colgate',
        price: 127.99,
        imageUrl:
            'https://images-na.ssl-images-amazon.com/images/I/71Rj3InxQlL._SL1500_.jpg',
        brand: 'Desconocida',
        productCategoryName: 'Higiene Personal',
        quantity: 9145,
        isPopular: false),
    Product(
        id: 'Crema para el cuerpo',
        name: 'Crema para el cuerpo',
        description: '1 crema para el cuerpo',
        price: 1224.88,
        imageUrl:
            'https://images-na.ssl-images-amazon.com/images/I/81KabJxRvDL._AC_SL1500_.jpg',
        brand: 'Desconocida',
        productCategoryName: 'Higiene Personal',
        quantity: 25,
        isPopular: true),
    Product(
        id: 'Rastrillo para vello facial',
        name: 'Rastrillo para vello facial',
        description: '3 piezas de rastrillo para vello facial',
        price: 1220.99,
        imageUrl:
            'https://images-na.ssl-images-amazon.com/images/I/81khjDZg5xL._AC_SL1500_.jpg',
        brand: 'Desconocida',
        productCategoryName: 'Higiene Personal',
        quantity: 651,
        isPopular: false),
    Product(
        id: 'Croquetas para perro',
        name: 'Croquetas para perro',
        description: '1 kg de croqueta para perro',
        price: 1220.99,
        imageUrl:
            'https://images-na.ssl-images-amazon.com/images/I/716-fllmUCL._AC_SL1500_.jpg',
        brand: 'Desconocida',
        productCategoryName: 'Mascotas',
        quantity: 594,
        isPopular: true),
    Product(
        id: 'Plato para perros',
        name: 'Plato para perros',
        description: '1 plato para perro',
        price: 300.99,
        imageUrl:
            'https://images-na.ssl-images-amazon.com/images/I/71QxxtRFFkL._AC_SL1232_.jpg',
        brand: 'Desconocida',
        productCategoryName: 'Mascotas',
        quantity: 78,
        isPopular: false),
    Product(
        id: 'Correa para perro',
        name: 'Correa para perro',
        description: '1 correa para perro',
        price: 100.99,
        imageUrl:
            'https://images-na.ssl-images-amazon.com/images/I/71vCuRn4CkL._AC_SL1500_.jpg',
        brand: 'Desconocida',
        productCategoryName: 'Mascotas',
        quantity: 156,
        isPopular: true),
    Product(
        id: 'Juguete para perro',
        name: 'Juguete para perro',
        description: '1 juguete para perro',
        price: 86.99,
        imageUrl:
            'https://images-na.ssl-images-amazon.com/images/I/51EWl3XsiYL._AC_SL1000_.jpg',
        brand: 'Desconocida',
        productCategoryName: 'Mascotas',
        quantity: 142,
        isPopular: false),
    Product(
        id: 'Cuerno pan dulce',
        name: 'Cuerno pan dulce',
        description: '3 piezas de cuerno pan dulce',
        price: 300.99,
        imageUrl:
            'https://images-na.ssl-images-amazon.com/images/I/51bSW9gjoaL._AC_SL1024_.jpg',
        brand: 'Desconocida',
        productCategoryName: 'Pan',
        quantity: 167,
        isPopular: false),
    Product(
        id: 'Oreja de pan dulce',
        name: 'Oreja de pan dulce',
        description: '3 piezas de oreja de pan dulce',
        price: 40.99,
        imageUrl:
            'https://images-na.ssl-images-amazon.com/images/I/51r2LCE3FLL._AC_SL1000_.jpg',
        brand: 'Desconocida',
        productCategoryName: 'Pan',
        quantity: 659,
        isPopular: false),
    Product(
        id: 'Gatorade',
        name: 'Gatorade',
        description: '1 gatorade',
        price: 20.99,
        imageUrl:
            'https://images-na.ssl-images-amazon.com/images/I/61MVdCYfbOL._AC_UX679_.jpg',
        brand: 'Desconocida',
        productCategoryName: 'Bebidas',
        quantity: 98,
        isPopular: false),
    Product(
        id: 'Sprite en lata',
        name: 'Sprite en lata',
        description: '1 sprite en lata',
        price: 33.99,
        imageUrl:
            'https://images-na.ssl-images-amazon.com/images/I/91M50AHRTKL._AC_UX569_.jpg',
        brand: 'Desconocida',
        productCategoryName: 'Bebidas',
        quantity: 951,
        isPopular: false)
  ];
  */
}
