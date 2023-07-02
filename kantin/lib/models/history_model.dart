import 'package:meta/meta.dart';
import 'dart:convert';

List<History> historyFromJson(String str) =>
    List<History>.from(json.decode(str).map((x) => History.fromJson(x)));

class History {
  final String id;
  final int qty;
  final int total;

  History({
    required this.id,
    required this.qty,
    required this.total,
  });

  factory History.fromJson(Map<String, dynamic> json) => History(
        id: json["id"],
        qty: json["qty"],
        total: json["total"],
      );
}
