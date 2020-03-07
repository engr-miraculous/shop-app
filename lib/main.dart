import 'package:flutter/material.dart';
import 'package:provider/provider.dart';



import './screens/order_screen.dart';
import './screens/user_products_screen.dart';
import './providers/products_provider.dart';
import './screens/product_details_screen.dart';
import './screens/product_overview_screen.dart';
import './providers/cart_prtovider.dart';
import './screens/cart_screen.dart';
import './providers/order_provider.dart';
import './screens/add_and_edit_user_product.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(builder: (context) => ProductProvider()),
        ChangeNotifierProvider.value(value: CartProvider()),
        ChangeNotifierProvider.value(value: OrderProvider()),
      ],
      child: MaterialApp(
        title: 'Flutter Demo',
        theme: ThemeData(
            primarySwatch: Colors.purple,
            accentColor: Colors.deepOrange,
            fontFamily: 'Lato'),
        home: ProductOverviewScreen(),
        routes: {
          ProductDetailsScreen.navName: (cntx) => ProductDetailsScreen(),
          CartScreen.navName: (cntx) => CartScreen(),
          OrderScreen.navName: (cntx) => OrderScreen(),
          UserProductsScreen.navName: (cntx) => UserProductsScreen(),
          AddAndEditUserProduct.navName: (cntx) => AddAndEditUserProduct(),
        },
      ),
    );
  }
}
