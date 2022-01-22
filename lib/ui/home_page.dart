import 'package:adam_kraken_task/models/order_item.dart';
import 'package:adam_kraken_task/ui/order_item_tile.dart';
import 'package:adam_kraken_task/viewmodels/home_view_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';

class HomePage extends StatefulWidget {
  HomePage({Key? key}) : super(key: key);

  final viewModel = HomeViewModel();

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  void initState() {
    super.initState();
    widget.viewModel.init();
  }

  @override
  void dispose() {
    widget.viewModel.close();
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
            Expanded(child: _ordersList(widget.viewModel.buyItems)),
            Expanded(child: _ordersList(widget.viewModel.sellItems)),
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
        return OrderItemTile(item: item, onTap: () => widget.viewModel.onItemTap(item));
      },
    );
  }

  Widget _quantityField() {
    return TextField(
      decoration: const InputDecoration(labelText: 'Quantity'),
      controller: widget.viewModel.quantityTextController,
      keyboardType: TextInputType.number,
    );
  }
}
