import 'package:flutter/material.dart';

import '../models/order.dart';
import '../models/cart.dart';
class OrderProvider with ChangeNotifier {
  List<Order> _orders = [];

  List<Order> get getOrders {
    return [..._orders];
  }

  void addOrder(List<Cart> cartProducts, double totalPrice) {
    _orders.insert(
      0,
      Order(
        id: DateTime.now().toString(),
        amount: totalPrice,
        products: cartProducts,
        orderTime: DateTime.now(),
      ),
    );
    notifyListeners();
  }

  
}
