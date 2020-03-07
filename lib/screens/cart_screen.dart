import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shop_app/providers/order_provider.dart';

import '../providers/cart_prtovider.dart';
import '../widgets/cart_item.dart';

class CartScreen extends StatelessWidget {
  static const navName = '/cart';
  @override
  Widget build(BuildContext context) {
    var cartProvider = Provider.of<CartProvider>(context, listen: false);
    return Scaffold(
      appBar: AppBar(title: Text('Your Cart')),
      body: Column(
        children: <Widget>[
          Card(
            margin: EdgeInsets.all(15),
            child: Padding(
              padding: EdgeInsets.all(8),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  Text(
                    'Total',
                    style: TextStyle(fontSize: 20),
                  ),
                  Spacer(),
                  Chip(
                    label: Text(
                      '\$${cartProvider.getTotalPrice.toStringAsFixed(2)}',
                      style: TextStyle(
                          color: Theme.of(context).textTheme.title.color),
                    ),
                    backgroundColor: Theme.of(context).primaryColor,
                  ),
                  FlatButton(
                    onPressed: () {
                      Provider.of<OrderProvider>(context).addOrder(
                        cartProvider.getCartItems.values.toList(),
                        cartProvider.getTotalPrice,
                      );
                      cartProvider.clearCart();
                    },
                    child: Text('Place Order'),
                  ),
                ],
              ),
            ),
          ),
          Expanded(
            child: ListView.builder(
                itemCount: cartProvider.getCartItemCount,
                itemBuilder: (cntx, i) {
                  var currentItem =
                      cartProvider.getCartItems.values.toList()[i];
                  return CartItem(
                    id: currentItem.id,
                    productId: cartProvider.getCartItems.keys.toList()[i],
                    title: currentItem.title,
                    price: currentItem.price,
                    quantity: currentItem.quantity,
                  );
                }),
          ),
        ],
      ),
    );
  }
}
