import 'package:flutter/material.dart';

class OrderNotifier extends ChangeNotifier {
  int _quantity = 0;
  double _total = 0.0;

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
}
