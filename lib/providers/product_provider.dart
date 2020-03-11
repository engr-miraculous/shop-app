import 'dart:convert';
import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;

class Product with ChangeNotifier {
  final String id;
  final String title;
  final String description;
  final double price;
  final String imageUrl;
  bool isFavorite;

  Product({
    @required this.id,
    @required this.title,
    @required this.description,
    @required this.price,
    @required this.imageUrl,
    this.isFavorite = false,
  });

  Future<void> toggleIsFavorite(id) async {
    final url = 'https://shop-app-f1f0d.firebaseio.com/products/$id.json';
    var oldFavorite = isFavorite;
    var newFavorite = !isFavorite;
    isFavorite = newFavorite;
    notifyListeners();
    var response =
        await http.patch(url, body: json.encode({'isFavorite': newFavorite}));
    if (response.statusCode >= 400) {
      isFavorite = oldFavorite;
      return notifyListeners();
    } 
  }
}
