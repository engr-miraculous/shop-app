import 'package:flutter/material.dart';


class Cart {
  String id;
  String title;
  int quantity;
  double price;

  Cart({
    @required this.id,
    @required this.title,
    @required this.quantity,
    @required this.price,
  });
}