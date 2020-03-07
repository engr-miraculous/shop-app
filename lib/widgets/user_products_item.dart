import 'package:flutter/material.dart';
import 'package:shop_app/screens/add_and_edit_user_product.dart';

class UserProductsItem extends StatelessWidget {
  final String id;
  final String imgUrl;
  final String title;
  final Function deleteProduct;

  UserProductsItem(this.id, this.title, this.imgUrl, this.deleteProduct);
  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: CircleAvatar(
        backgroundImage: NetworkImage(imgUrl),
      ),
      title: Text(title),
      trailing: Container(
        width: 100,
        child: Row(
          children: <Widget>[
            IconButton(
              icon: Icon(Icons.edit),
              onPressed: () {
                Navigator.of(context).pushNamed(
                  AddAndEditUserProduct.navName,
                  arguments: id,
                );
              },
              color: Theme.of(context).primaryColor,
            ),
            IconButton(
              icon: Icon(Icons.delete),
              onPressed: () {deleteProduct(id);},
              color: Theme.of(context).errorColor,
            ),
          ],
        ),
      ),
    );
  }
}
