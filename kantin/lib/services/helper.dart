import 'package:flutter/services.dart' as the_bundle;
import 'package:kantin/models/cart_model.dart';
import 'package:kantin/models/product_model.dart';

class Helper {
  Future<List<Product>> getProducts() async {
    final data =
        await the_bundle.rootBundle.loadString("assets/json/product.json");
    final products = productFromJson(data);

    return products;
  }

  Future<Product> getProductById(String id) async {
    final data =
        await the_bundle.rootBundle.loadString("assets/json/men_shoes.json");
    final product = productFromJson(data);
    final sneaker = product.firstWhere((product) => product.id == id);

    return sneaker;
  }

  Future<List<Order>> getOrders() async {
    final data =
        await the_bundle.rootBundle.loadString("assets/json/order.json");
    final orders = orderFromJson(data);

    return orders;
  }

  Future<Order> getOrderById(String id) async {
    final data =
        await the_bundle.rootBundle.loadString("assets/json/order.json");
    final orders = orderFromJson(data);
    final order = orders.firstWhere((order) => order.id == id);

    return order;
  }
}
