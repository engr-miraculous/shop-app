import 'package:flutter/material.dart';


import '../models/cart.dart';

class CartProvider with ChangeNotifier {
  Map<String, Cart> _cartItems = {};

  Map<String, Cart> get getCartItems {
    return {..._cartItems};
  }

  int get getCartItemCount{
    return _cartItems.length;
  }
double get getTotalPrice{
  double totalPrice = 0.0;
  _cartItems.values.forEach((item) => totalPrice += item.price * item.quantity);
    return totalPrice; 
  }
  void addToCartItems(
    String productId,
    String title,
    double price,
  ) {
    if (_cartItems.containsKey(productId)) {
      _cartItems.update(
        productId,
        (matchedItem) => Cart(
          id: matchedItem.id,
          title: matchedItem.title,
          quantity: matchedItem.quantity + 1,
          price: matchedItem.price,
        ),
      );
    } else {
      _cartItems.putIfAbsent(
        productId,
        () => Cart(
          id: DateTime.now().toString(),
          title: title,
          quantity: 1,
          price: price,
        ),
      );
    }
    notifyListeners();
  }

  void  removeCartItem (String productID){
     _cartItems.remove(productID);
      notifyListeners();
  }
void removeSingleCartItem (String productId){
  if (_cartItems.containsKey(productId)){
    if (_cartItems[productId].quantity > 1) {
      _cartItems.update(productId, (cartItem) => Cart(id: cartItem.id, title: cartItem.title, quantity: cartItem.quantity - 1, price: cartItem.price,));
    }else _cartItems.remove(productId);
  }else return;
}
  void clearCart(){
    _cartItems.clear();
    notifyListeners();
  }
}
