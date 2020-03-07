import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../providers/products_provider.dart';
import '../widgets/product_item.dart';

class GridBuilder extends StatelessWidget {
  final bool showFavorite;
  
  GridBuilder(this.showFavorite);


  @override
  Widget build(BuildContext context) {
    var providerProductsObject = Provider.of<ProductProvider>(context);
    var providerProducts = showFavorite ? providerProductsObject.favoriteItems : providerProductsObject.items;
    return GridView.builder(
        padding: EdgeInsets.all(10),
        itemCount: providerProducts.length,
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          childAspectRatio: 3 / 2,
          mainAxisSpacing: 10,
          crossAxisSpacing: 10,
        ),
        itemBuilder: (context, index) {
          return ChangeNotifierProvider.value(
            value: providerProducts[index],
                      child: ProductItem(
              // providerProducts[index].id,
              // providerProducts[index].title,
              // providerProducts[index].imageUrl,
            ),
          );
        });
  }
}
