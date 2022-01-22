import 'dart:async';

import 'package:adam_kraken_task/api/api_config.dart';
import 'package:adam_kraken_task/models/order_item.dart';
import 'package:adam_kraken_task/api/messages/orderbook_message.dart';
import 'package:flutter/foundation.dart';
import 'package:web_socket_channel/io.dart';

class OrderRepository {
  Stream<OrderItem> getOrdersStream() {
    return _createOrderSteamController().stream;
  }

  StreamController<OrderItem> _createOrderSteamController() {
    final streamController = StreamController<OrderItem>();
    return streamController
      ..onListen = () {
        debugPrint('[OrderRepository] onListen');

        final channel = IOWebSocketChannel.connect(Uri.parse(ApiConfig.krakenWebsocketUrl));
        channel.sink.add(OrderbookMessage(
          event: 'subscribe',
          feed: 'book',
          productIds: ['PI_XBTUSD'],
        ).toEncodedJson());

        channel.stream.listen((data) {
          final orderItem = OrderItem.fromData(data);
          if (orderItem != null) {
            streamController.sink.add(orderItem);
          }
        });

        streamController.onCancel = () {
          debugPrint('[OrderRepository] onCancel');
          channel.sink.close();
        };
      };
  }
}
