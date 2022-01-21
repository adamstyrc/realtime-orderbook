import 'package:json_annotation/json_annotation.dart';
import 'dart:convert';

part 'orderbook_message.g.dart';

@JsonSerializable()
class OrderbookMessage {
  final String event;
  final String feed;
  @JsonKey(name: 'product_ids')
  final List<String> productIds;

  OrderbookMessage({
    required this.event,
    required this.feed,
    required this.productIds,
  });

  factory OrderbookMessage.fromJson(Map<String, dynamic> json) => _$OrderbookMessageFromJson(json);

  Map<String, dynamic> toJson() => _$OrderbookMessageToJson(this);

  String toEncodedJson() => json.encode(this);
}
