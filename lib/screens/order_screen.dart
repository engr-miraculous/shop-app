import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../widgets/main_drawer.dart';
import '../providers/order_provider.dart';
import '../widgets/order_item.dart';

class OrderScreen extends StatelessWidget {
  static const navName = '/order-screen';
  @override
  Widget build(BuildContext context) {
    var orders = Provider.of<OrderProvider>(context).getOrders;
    return Scaffold(
      appBar: AppBar(title: Text('Your Orders')),
      drawer: MainDrawer(),
      body: ListView.builder(
        itemCount: orders.length,
        itemBuilder: (cntx, i) => OrderItem(orders[i]),
      ),
    );
  }
}
