import 'package:adam_kraken_task/di/service_locator.dart';
import 'package:adam_kraken_task/features/home/ui/order_item_tile.dart';
import 'package:adam_kraken_task/features/home/viewmodels/home_view_model.dart';
import 'package:adam_kraken_task/models/order_item.dart';
import 'package:adam_kraken_task/repositories/order_repository.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> with WidgetsBindingObserver {
  final viewModel = HomeViewModel(getIt<OrderRepository>());

  @override
  void initState() {
    super.initState();
    viewModel.init();
    WidgetsBinding.instance?.addObserver(this);
  }

  @override
  void dispose() {
    WidgetsBinding.instance?.removeObserver(this);
    viewModel.close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        toolbarHeight: 100,
        title: Column(
          children: [
            _quantityField(),
            const SizedBox(height: 20),
          ],
        ),
      ),
      body: Observer(
        builder: (_) => Row(
          children: [
            Expanded(child: _ordersList(viewModel.buyItems)),
            Expanded(child: _ordersList(viewModel.sellItems)),
          ],
        ),
      ),
    );
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    switch (state) {
      case AppLifecycleState.resumed:
        viewModel.resume();
        break;
      case AppLifecycleState.paused:
        viewModel.pause();
        break;
      default:
        break;
    }
  }

  Widget _ordersList(List<OrderItem> items) {
    return ListView.builder(
      itemCount: items.length,
      itemBuilder: (context, index) {
        final item = items[index];
        return OrderItemTile(item: item, onTap: () => viewModel.onItemTap(item));
      },
    );
  }

  Widget _quantityField() {
    return TextField(
      decoration: const InputDecoration(labelText: 'Quantity'),
      controller: viewModel.quantityTextController,
      keyboardType: TextInputType.number,
    );
  }
}
