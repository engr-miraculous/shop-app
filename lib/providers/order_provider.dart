import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

import '../models/order.dart';
import '../models/cart.dart';

class OrderProvider with ChangeNotifier {
  List<Order> _orders = [];

  List<Order> get getOrders {
    return [..._orders];
  }

  Future<void> fetchAndSetOrder() async {
    const url = 'https://shop-app-f1f0d.firebaseio.com/order.json';
    List<Order> fetchedOrders = [];
    try {
      var result = await http.get(url); // as Map<String, dynamic>;
      var responseObjects = json.decode(result.body) as Map<String, dynamic>;
      if (responseObjects == null) {
        return;
      }
      print(responseObjects);
      responseObjects.forEach((id, orders) {
        fetchedOrders.add(
          Order(
            id: id,
            amount: orders['amount'],
            products: (orders['cartItems'] as List<dynamic>).map((carts) {
              return Cart(
                id: carts['id'],
                title: carts['title'],
                quantity: carts['quantity'],
                price: carts['price'],
              );
            }).toList(),
            orderTime: DateTime.parse(orders['time']),
          ),
        );
      });

      _orders = fetchedOrders;
      print(_orders);
      notifyListeners();

      return result;
    } catch (e) {
      print(e.toString());
      throw e;
    }
  }

  Future<void> addOrder(List<Cart> cartProducts, double totalPrice) async {
    const url = 'https://shop-app-f1f0d.firebaseio.com/order.json';
    var orderTime = DateTime.now().toIso8601String();
    try {
      var reasponse = await http.post(url,
          body: json.encode({
            'amount': totalPrice,
            'time': orderTime,
            'cartItems': cartProducts.map((product) {
              return {
                'id': product.id,
                'title': product.title,
                'price': product.price,
                'quantity': product.quantity,
              };
            }).toList(),
          }));

      _orders.insert(
        0,
        Order(
          id: json.decode(reasponse.body)['name'],
          amount: totalPrice,
          products: cartProducts,
          orderTime: DateTime.parse(orderTime),
        ),
      );
      notifyListeners();
    } catch (e) {
      throw e;
    }
  }
}
