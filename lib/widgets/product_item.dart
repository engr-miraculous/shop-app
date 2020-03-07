import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../screens/product_details_screen.dart';
import '../providers/product_provider.dart';
import '../providers/cart_prtovider.dart';

class ProductItem extends StatelessWidget {
  // final String id;
  // final String title;
  // final String imgUrl;

  // ProductItem(this.id, this.title, this.imgUrl);

  @override
  Widget build(BuildContext context) {
    //print('General build called');
    var productProvider = Provider.of<Product>(
      context,
      listen: false,
    );
    var cartProvider = Provider.of<CartProvider>(
      context,
      listen: false,
    );
    return ClipRRect(
      borderRadius: BorderRadius.circular(10),
      child: GridTile(
        child: GestureDetector(
          onTap: () => Navigator.of(context).pushNamed(
            ProductDetailsScreen.navName,
            arguments: productProvider.id,
          ),
          child: Image.network(
            productProvider.imageUrl,
            fit: BoxFit.cover,
          ),
        ),
        footer: GridTileBar(
          backgroundColor: Colors.black87,
          leading: Consumer<Product>(
            builder: (cntx, product, child) => IconButton(
              icon: Icon(
                product.isFavorite ? Icons.favorite : Icons.favorite_border,
                color: Theme.of(context).accentColor,
              ),
              onPressed: () => productProvider.toggleIsFavorite(),
            ),
          ),
          title: Text(
            productProvider.title,
            textAlign: TextAlign.center,
          ),
          trailing: IconButton(
            icon: Icon(
              Icons.shopping_cart,
              color: Theme.of(context).accentColor,
            ),
            onPressed: () {
              cartProvider.addToCartItems(
                productProvider.id,
                productProvider.title,
                productProvider.price,
              );
              Scaffold.of(context).hideCurrentSnackBar();
              Scaffold.of(context).showSnackBar(SnackBar(
                content: Text('The Product have been added to cart'),
                duration: Duration(seconds: 2),
                action: SnackBarAction(
                  label: 'Undo',
                  onPressed: () =>
                      cartProvider.removeSingleCartItem(productProvider.id),
                ),
              ));
            },
          ),
        ),
      ),
    );
  }
}
