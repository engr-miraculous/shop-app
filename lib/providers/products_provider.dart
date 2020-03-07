import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

import '../providers/product_provider.dart';

class ProductProvider with ChangeNotifier {
  List<Product> _items = [
    Product(
      id: 'p1',
      title: 'Red Shirt',
      description: 'A red shirt - it is pretty red!',
      price: 29.99,
      imageUrl:
          'https://cdn.pixabay.com/photo/2016/10/02/22/17/red-t-shirt-1710578_1280.jpg',
    ),
    Product(
      id: 'p2',
      title: 'Trousers',
      description: 'A nice pair of trousers.',
      price: 59.99,
      imageUrl:
          'https://upload.wikimedia.org/wikipedia/commons/thumb/e/e8/Trousers%2C_dress_%28AM_1960.022-8%29.jpg/512px-Trousers%2C_dress_%28AM_1960.022-8%29.jpg',
    ),
    Product(
      id: 'p3',
      title: 'Yellow Scarf',
      description: 'Warm and cozy - exactly what you need for the winter.',
      price: 19.99,
      imageUrl:
          'https://live.staticflickr.com/4043/4438260868_cc79b3369d_z.jpg',
    ),
    Product(
      id: 'p4',
      title: 'A Pan',
      description: 'Prepare any meal you want.',
      price: 49.99,
      imageUrl:
          'https://upload.wikimedia.org/wikipedia/commons/thumb/1/14/Cast-Iron-Pan.jpg/1024px-Cast-Iron-Pan.jpg',
    ),
  ];

  List<Product> get items {
    return [..._items];
  }

  Product getById(String id) {
    return _items.firstWhere((product) => product.id == id);
  }

  List<Product> get favoriteItems {
    return _items.where((product) => product.isFavorite == true).toList();
  }

  Future<void> saveProduct(Product savedProduct) {
    var url = 'https://shop-app-f1f0d.firebaseio.com/products.json';
   return http
        .post(url,
            body: json.encode({
              'title': savedProduct.title,
              'description': savedProduct.description,
              'price': savedProduct.price.toString(),
              'imageUrl': savedProduct.imageUrl,
            }))
        .then((response) {
      _items.insert(
        0,
        Product(
          id: json.decode(response.body)['name'],
          title: savedProduct.title,
          description: savedProduct.description,
          price: savedProduct.price,
          imageUrl: savedProduct.imageUrl,
        ),
      );
      print('${_items[0].id}');
      notifyListeners();
    }).catchError((error) { 
      print(error.toString());
      throw error;});
  }

  void editProduct(String id, Product changedProduct) {
    var productIndex = _items.indexWhere((product) => product.id == id);

    if (productIndex == -1) {
      return;
    } else {
      _items[productIndex] = Product(
        id: changedProduct.id,
        title: changedProduct.title,
        description: changedProduct.description,
        price: changedProduct.price,
        imageUrl: changedProduct.imageUrl,
      );
      notifyListeners();
    }
  }

  void deletProduct(String id) {
    _items.removeWhere((product) => product.id == id);
    notifyListeners();
  }
}
