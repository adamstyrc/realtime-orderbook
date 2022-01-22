import 'package:adam_kraken_task/di/service_locator.dart';
import 'package:adam_kraken_task/models/order_item.dart';
import 'package:adam_kraken_task/order_repository.dart';
import 'package:adam_kraken_task/ui/order_item_tile.dart';
import 'package:adam_kraken_task/viewmodels/home_view_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';

class HomePage extends StatefulWidget {
  HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final viewModel = HomeViewModel(getIt<OrderRepository>());

  @override
  void initState() {
    super.initState();
    viewModel.init();
  }

  @override
  void dispose() {
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
