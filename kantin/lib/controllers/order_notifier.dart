import 'package:flutter/material.dart';
import 'package:kantin/models/cart_model.dart';

class OrderNotifier extends ChangeNotifier {
  int _quantity = 1;
  double _total = 0.0;
  double _grandTotal = 0.0;

  int get quantity => _quantity;

  set quantity(int qty) {
    _quantity = qty;
    notifyListeners();
  }

  double get total => _total;

  set total(double total) {
    _total = total;
    notifyListeners();
  }

  // void toggleCheck(int index) {
  //   for (var i = 0; i < _shoeSizes.length; i++) {
  //     if (i == index) {
  //       _shoeSizes[i]["isSelected"] = !_shoeSizes[i]["isSelected"];
  //     }
  //   }
  //   notifyListeners();
  // }

  // List<String> get sizes => _sizes;

  // set sizes(List<String> newSizes) {
  //   _sizes = newSizes;
  //   notifyListeners();
  // }

  void increment() {
    _quantity++;
    notifyListeners();
  }

  void decrement() {
    _quantity--;
    notifyListeners();
  }

  List<Map<String, dynamic>> _orders = [];
  List<Map<String, dynamic>> get orders => _orders;

  set orders(List<Map<String, dynamic>> newOrder) {
    _orders = newOrder;
    notifyListeners();
  }

  void toggleCheck(int index) {
    for (var i = 0; i < _orders.length; i++) {
      if (i == index) {
        orders[i]["isSelected"] = !_orders[i]["isSelected"];
      }
    }
    notifyListeners();
  }

  void hitungrandTotal() {
    for (var i = 0; i < _orders.length; i++) {
      _grandTotal += _orders[i]['total'];
    }
    notifyListeners();
  }

  double get grandTotal => _grandTotal;

  set grandTotal(double newGrandTotal) {
    _grandTotal = newGrandTotal;
    notifyListeners();
  }

  void updateTambahOrder(List<Map<String, dynamic>> orders, int index) {
    orders[index]['qty']++;
    orders[index]['total'] += orders[index]['unit_price'];

    notifyListeners();
  }

  void updateKurangOrder(List<Map<String, dynamic>> orders, int index) {
    orders[index]['qty']--;
    orders[index]['total'] -= orders[index]['unit_price'];

    notifyListeners();
  }

  List<Map<String, dynamic>> _history = [];
  List<Map<String, dynamic>> get history => _history;

  set history(List<Map<String, dynamic>> newHistory) {
    _orders = history;
    notifyListeners();
  }

  int _idHistory = 0;
  int get idHistory => _idHistory;
  set idHistory(int newId) {
    _idHistory = newId;
  }

  void incrementIdHistory() {
    _idHistory++;
  }
}
