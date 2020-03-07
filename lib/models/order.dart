import 'package:flutter/cupertino.dart';

import '../models/cart.dart';

class Order {
  String id;
  double amount;
  List<Cart> products;
  DateTime orderTime;

  Order({
    @required this.id,
    @required this.amount,
    @required this.products,
    @required this.orderTime,
  });
}
