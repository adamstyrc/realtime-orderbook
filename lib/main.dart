import 'package:adam_kraken_task/di/service_locator.dart';
import 'package:adam_kraken_task/ui/home_page.dart';
import 'package:flutter/material.dart';

Future<void> main() async {
  DependencyRegistry().register();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: HomePage(),
    );
  }
}
