import 'dart:async';

import 'package:adam_kraken_task/models/order_item.dart';
import 'package:adam_kraken_task/order_repository.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:mobx/mobx.dart';

part 'home_view_model.g.dart';

class HomeViewModel = HomeViewModelBase with _$HomeViewModel;

abstract class HomeViewModelBase with Store {

  static const orderItemsMaxSize = 30;

  @observable
  var sellItems = List<OrderItem>.of([]);
  @observable
  var buyItems = List<OrderItem>.of([]);

  StreamSubscription? subscription;

  final quantityTextController = TextEditingController();

  void init() {
    final orderRepository = OrderRepository();
    final ordersStream = orderRepository.getOrdersStream();

    subscription = ordersStream.listen((orderItem) {
      _addOrderItem(orderItem);
      debugPrint('OrderItem: ${orderItem.toJson()}');
    });
  }

  void close() {
    subscription?.cancel();
  }

  @action
  void _addOrderItem(OrderItem orderItem) {
    switch (orderItem.side) {
      case Side.sell:
        sellItems = _generateNewList(sellItems, orderItem);
        break;
      case Side.buy:
        buyItems = _generateNewList(buyItems, orderItem);
        break;
    }
  }

  void onItemTap(OrderItem orderItem) {
    quantityTextController.text = orderItem.displayQuantity;
  }

  List<OrderItem> _generateNewList(List<OrderItem> currentList, OrderItem newItem) {
    final newList = [newItem, ...currentList];
    return (newList.length > orderItemsMaxSize) ? newList.sublist(0, orderItemsMaxSize) : newList;
  }
}
