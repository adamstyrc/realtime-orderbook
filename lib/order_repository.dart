import 'dart:async';

import 'package:adam_kraken_task/environment.dart';
import 'package:adam_kraken_task/models/orderbook_message.dart';
import 'package:web_socket_channel/io.dart';

class OrderRepository {
  IOWebSocketChannel? channel;

  final ordersStream = StreamController(
    onListen: () {},
  );

  OrderRepository();

  Stream observeOrders() {
    final channel = IOWebSocketChannel.connect(Uri.parse(Environment.websocketUrl));
    channel.sink.add(OrderbookMessage(
      event: 'subscribe',
      feed: 'book',
      productIds: ['PI_XBTUSD'],
    ).toEncodedJson());

    this.channel = channel;
    return channel.stream;
  }
}
