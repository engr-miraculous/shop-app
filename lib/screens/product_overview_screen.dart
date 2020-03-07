import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../providers/cart_prtovider.dart';
import '../widgets/grid_builder.dart';
import '../screens/cart_screen.dart';
import '../widgets/badge.dart';
import '../widgets/main_drawer.dart';

enum FilterOption {
  ShowFavorites,
  ShowAll,
}

class ProductOverviewScreen extends StatefulWidget {
  @override
  _ProductOverviewScreenState createState() => _ProductOverviewScreenState();
}

class _ProductOverviewScreenState extends State<ProductOverviewScreen> {
  var showFavorite = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Shop app'),
        actions: <Widget>[
          PopupMenuButton(
              icon: Icon(
                Icons.more_vert,
              ),
              onSelected: (FilterOption favoriteSelector) {
                setState(() {
                  if (favoriteSelector == FilterOption.ShowFavorites) {
                    showFavorite = true;
                  } else {
                    showFavorite = false;
                  }
                });
              },
              itemBuilder: (cntx) => [
                    PopupMenuItem(
                        child: Text('Show Favorites'),
                        value: FilterOption.ShowFavorites),
                    PopupMenuItem(
                        child: Text('Show All'), value: FilterOption.ShowAll)
                  ]),
          Consumer<CartProvider>(
            builder: (cntx, cart, _child) => Badge(
              child: _child,
              value: cart.getCartItemCount.toString(),
            ),
            child: IconButton(
              icon: Icon(Icons.shopping_cart),
              onPressed: () => Navigator.of(context).pushNamed(
                CartScreen.navName,
              ),
            ),
          )
        ],
      ),
      drawer: MainDrawer(),
      body: GridBuilder(showFavorite),
    );
  }
}
