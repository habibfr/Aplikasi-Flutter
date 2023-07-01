import 'dart:convert';

import 'package:flutter/material.dart';

List<Order> orderFromJson(String str) =>
    List<Order>.from(json.decode(str).map((x) => Order.fromJson(x)));

class Order {
  final String id;
  final String idProduct;
  final int qty;
  final String name;
  final String imageUrl;
  final int unitPrice;
  final int total;

  Order({
    required this.id,
    required this.idProduct,
    required this.name,
    required this.qty,
    required this.imageUrl,
    required this.unitPrice,
    required this.total,
  });

  factory Order.fromJson(Map<String, dynamic> json) => Order(
        id: json["id"],
        idProduct: json["id_product"],
        name: json['name'],
        qty: json["qty"],
        imageUrl: json["imageUrl"],
        unitPrice: json["unit_price"],
        total: json["total"],
      );
}
