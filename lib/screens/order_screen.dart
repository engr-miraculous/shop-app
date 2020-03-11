import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../widgets/main_drawer.dart';
import '../providers/order_provider.dart';
import '../widgets/order_item.dart';

class OrderScreen extends StatefulWidget {
  static const navName = '/order-screen';

  @override
  _OrderScreenState createState() => _OrderScreenState();
}

class _OrderScreenState extends State<OrderScreen> {
  var _isLoading = false;
  @override
  void initState() {
    _isLoading = true;
    Future.delayed(Duration.zero).then((_) {
      Provider.of<OrderProvider>(context).fetchAndSetOrder().then((_) {
        setState(() {
          _isLoading = false;
        });
      });
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    var orders = Provider.of<OrderProvider>(context).getOrders;
    return Scaffold(
      appBar: AppBar(title: Text('Your Orders')),
      drawer: MainDrawer(),
      body: _isLoading
          ? Center(child: CircularProgressIndicator())
          : ListView.builder(
              itemCount: orders.length,
              itemBuilder: (cntx, i) => OrderItem(orders[i]),
            ),
    );
  }
}
