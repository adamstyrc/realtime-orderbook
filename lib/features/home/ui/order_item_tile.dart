import 'package:adam_kraken_task/models/order_item.dart';
import 'package:flutter/material.dart';

class OrderItemTile extends StatelessWidget {
  final OrderItem item;
  final VoidCallback onTap;

  const OrderItemTile({
    Key? key,
    required this.item,
    required this.onTap,
  }) : super(key: key);


  @override
  Widget build(BuildContext context) {
    return InkWell(
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Row(
          children: [
            Expanded(child: Text(item.displayQuantity)),
            Text(
              item.displayedPrice,
              style: TextStyle(
                color: item.side == Side.sell ? Colors.red : Colors.green,
              ),
            ),
          ],
        ),
      ),
      onTap: onTap,
    );
  }
}
