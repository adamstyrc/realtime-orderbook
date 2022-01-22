import 'dart:async';

import 'package:adam_kraken_task/models/order_item.dart';
import 'package:adam_kraken_task/repositories/order_repository.dart';
import 'package:flutter/material.dart';
import 'package:mobx/mobx.dart';

part 'home_view_model.g.dart';

class HomeViewModel = HomeViewModelBase with _$HomeViewModel;

abstract class HomeViewModelBase with Store {
  static const orderItemsMaxSize = 50;
  final OrderRepository orderRepository;

  @observable
  var sellItems = List<OrderItem>.of([]);
  @observable
  var buyItems = List<OrderItem>.of([]);

  StreamSubscription? subscription;

  final quantityTextController = TextEditingController();

  HomeViewModelBase(this.orderRepository);

  void init() {
    _observeOrders();
  }

  void close() {
    subscription?.cancel();
  }

  void resume() {
    debugPrint('resume');
    _observeOrders();
  }

  void pause() {
    debugPrint('pause');
    subscription?.cancel();
  }

  void onItemTap(OrderItem orderItem) {
    quantityTextController.text = orderItem.displayQuantity;
  }

  void _observeOrders() {
    subscription?.cancel();
    final ordersStream = orderRepository.getOrdersStream();
    subscription = ordersStream.listen((orderItem) {
      _addOrderItem(orderItem);
    });
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

  List<OrderItem> _generateNewList(List<OrderItem> currentList, OrderItem newItem) {
    final newList = [newItem, ...currentList];
    return (newList.length > orderItemsMaxSize) ? newList.sublist(0, orderItemsMaxSize) : newList;
  }
}
