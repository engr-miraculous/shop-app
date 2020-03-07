import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shop_app/providers/cart_prtovider.dart';

class CartItem extends StatelessWidget {
  final String id;
  final String productId;
  final String title;
  final double price;
  final int quantity;

  CartItem({this.id, this.productId, this.title, this.price, this.quantity});
  @override
  Widget build(BuildContext context) {
    return Dismissible(
      key: ValueKey(id),
      background: Container(
        padding: EdgeInsets.only(right: 20),
        color: Theme.of(context).errorColor,
        child: Icon(
          Icons.delete,
          size: 40,
          color: Colors.white,
        ),
        alignment: Alignment.centerRight,
        margin: EdgeInsets.symmetric(
          horizontal: 15,
          vertical: 4,
        ),
      ),
      direction: DismissDirection.endToStart,
      confirmDismiss: (dismissDirection) {
        return showDialog(
            context: context,
            builder: (cntx) => AlertDialog(
                  title: Text('Confirmation!'),
                  content: Text('Are you sure you want to delete it?'),
                  actions: <Widget>[
                    FlatButton(
                        onPressed: () => Navigator.of(context).pop(false),
                        child: Text('No')),
                    FlatButton(
                        onPressed: () => Navigator.of(context).pop(true),
                        child: Text('yes')),
                  ],
                ));
      },
      onDismissed: (dismissDirection) => Provider.of<CartProvider>(context, listen: false)
          .removeCartItem(productId),
      child: Card(
        margin: EdgeInsets.symmetric(
          horizontal: 15,
          vertical: 4,
        ),
        child: Padding(
          padding: EdgeInsets.all(3),
          child: ListTile(
            contentPadding: EdgeInsets.all(20),
            leading: CircleAvatar(
              backgroundColor: Theme.of(context).primaryColor,
              child: Padding(
                padding: EdgeInsets.all(5),
                child: FittedBox(
                  child: Text('\$${price * quantity}'),
                ),
              ),
            ),
            title: Text('$price'),
            subtitle: Text('x $quantity'),
            trailing: Text(title),
          ),
        ),
      ),
    );
  }
}
