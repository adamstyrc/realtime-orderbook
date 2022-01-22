import 'dart:convert';

import 'package:flutter/widgets.dart';
import 'package:json_annotation/json_annotation.dart';

part 'order_item.g.dart';

@JsonSerializable()
class OrderItem {
  final String feed;

  @JsonKey(name: 'product_id')
  final String productId;
  final Side side;

  final int seq;

  final double price;

  @JsonKey(name: 'qty')
  final double quantity;

  OrderItem({
    required this.feed,
    required this.productId,
    required this.side,
    required this.seq,
    required this.price,
    required this.quantity,
  });

  String get displayedPrice => price.toStringAsFixed(2);
  String get displayQuantity => quantity.toStringAsFixed(3);

  static OrderItem? fromData(data) {
    try {
      return OrderItem.fromJson(json.decode(data));
    } catch (e) {
      debugPrint('OrderItem: Parsing problem with: $data');
      return null;
    }
  }

  factory OrderItem.fromJson(Map<String, dynamic> json) => _$OrderItemFromJson(json);

  Map<String, dynamic> toJson() => _$OrderItemToJson(this);
}

enum Side {
  buy,
  sell,
}

