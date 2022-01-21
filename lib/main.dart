import 'package:adam_kraken_task/home_page.dart';
import 'package:adam_kraken_task/models/order_item.dart';
import 'package:adam_kraken_task/order_repository.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());

  final orderRepository = OrderRepository();
  orderRepository.observeOrders().listen((data) {
    final orderItem = OrderItem.fromData(data);
    if (orderItem != null) {
      print(orderItem.toJson());
    }
  });
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const HomePage(title: 'Flutter Demo Home Page'),
    );
  }
}
