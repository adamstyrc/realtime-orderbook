import 'package:adam_kraken_task/home_page.dart';
import 'package:adam_kraken_task/order_repository.dart';
import 'package:flutter/material.dart';

Future<void> main() async {
  runApp(const MyApp());

  final orderRepository = OrderRepository();
  final ordersStream = orderRepository.getOrdersStream();

  final subscription = ordersStream.listen((orderItem) {
    print('OrderItem: ${orderItem.toJson()}');
  });

  await Future.delayed(const Duration(seconds: 2));
  subscription.cancel();
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
