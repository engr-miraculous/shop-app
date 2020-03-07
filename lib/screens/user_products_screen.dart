import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../widgets/main_drawer.dart';
import '../providers/products_provider.dart';
import '../widgets/user_products_item.dart';
import '../screens/add_and_edit_user_product.dart';

class UserProductsScreen extends StatelessWidget {
  static const navName = '/user-products';
  @override
  Widget build(BuildContext context) {
    var userProducts = Provider.of<ProductProvider>(context).items;
    var productProvider = Provider.of<ProductProvider>(context);
    return Scaffold(
      appBar: AppBar(
        title: Text('Your Products'),
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.add),
            onPressed: () => Navigator.of(context).pushNamed(
              AddAndEditUserProduct.navName,
            ),
          )
        ],
      ),
      drawer: MainDrawer(),
      body: Padding(
        padding: EdgeInsets.all(8),
        child: ListView.builder(
          itemCount: userProducts.length,
          itemBuilder: (cntx, i) => Column(
            children: <Widget>[
              UserProductsItem(
                userProducts[i].id,
                userProducts[i].title,
                userProducts[i].imageUrl,
                productProvider.deletProduct,

              ),
              Divider(),
            ],
          ),
        ),
      ),
    );
  }
}
