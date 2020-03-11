import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/order_provider.dart';

import '../providers/cart_prtovider.dart';
import '../widgets/cart_item.dart';

class CartScreen extends StatelessWidget {
  static const navName = '/cart';
  @override
  Widget build(BuildContext context) {
    var cartProvider = Provider.of<CartProvider>(
      context,
    );
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
                  OrderButton(cartProvider: cartProvider),
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

class OrderButton extends StatefulWidget {
  const OrderButton({
    Key key,
    @required this.cartProvider,
  }) : super(key: key);

  final CartProvider cartProvider;

  @override
  _OrderButtonState createState() => _OrderButtonState();
}

class _OrderButtonState extends State<OrderButton> {
  var _isLoading = false;
  @override
  Widget build(BuildContext context) {
    return FlatButton(
      onPressed: widget.cartProvider.getCartItems.isEmpty
          ? null
          : () async {
              setState(() {
                _isLoading = true;
              });
              try {
                await Provider.of<OrderProvider>(context).addOrder(
                  widget.cartProvider.getCartItems.values.toList(),
                  widget.cartProvider.getTotalPrice,
                );
              } catch (e) {
                Scaffold.of(context).showSnackBar(SnackBar(
                  content: Text(
                      'Unable to place order, please check your network or contact support'),
                ));
                setState(() {
                  _isLoading = false;
                });
                return;
              }

              setState(() {
                widget.cartProvider.clearCart();
                _isLoading = false;
              });
            },
      child: _isLoading ? CircularProgressIndicator() : Text('Place Order'),
    );
  }
}
