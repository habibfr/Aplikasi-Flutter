import 'package:flutter/material.dart';
import 'package:ionicons/ionicons.dart';
import 'package:kantin/models/cart_model.dart';
import 'package:kantin/services/helper.dart';
import 'package:kantin/shared/app_style.dart';
import 'package:kantin/ui/home_page.dart';
import 'package:provider/provider.dart';

import '../controllers/order_notifier.dart';

class CartPage extends StatefulWidget {
  const CartPage({super.key});

  @override
  State<CartPage> createState() => _CartPageState();
}

class _CartPageState extends State<CartPage> {
  String? payment = "OVO";
  late Future<List<Order>> _order;

  void getOrders() {
    _order = Helper().getOrders();
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getOrders();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Order"),
        backgroundColor: Colors.red,
      ),
      body: Consumer<OrderNotifier>(
        builder: (context, orderNotifier, child) {
          DateTime now = DateTime.now();
          DateTime date = DateTime(now.year, now.month, now.day);
          String tgl = date.toString().replaceAll("00:00:00.000", "");
          // print(orderNotifier.orders);
          return FutureBuilder<List<Order>>(
            future: _order,
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return CircularProgressIndicator();
              } else if (snapshot.hasError) {
                // print(snapshot.error);
                return Text("Error ${snapshot.error}");
              } else {
                final orders = snapshot.data;
                double grandtotal = 0.0;
                for (var order in orders!) {
                  grandtotal += order.total;
                }

                // print(shoes);
                return Stack(
                  children: [
                    Container(
                      padding: EdgeInsets.fromLTRB(16, 10, 0, 0),
                      height: MediaQuery.of(context).size.height * 0.15,
                      decoration: BoxDecoration(
                          image: DecorationImage(
                              image: AssetImage("assets/images/banner.png"),
                              fit: BoxFit.fill)),
                      child: Container(
                        padding: EdgeInsets.only(left: 5, bottom: 15),
                        width: MediaQuery.of(context).size.width,
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.only(top: 110, left: 15, right: 15),
                      child: Column(
                        children: [
                          Text(
                            "Checkout",
                            style: appStyle(20, Colors.black, FontWeight.bold),
                          ),
                          Column(
                            children: [
                              Text("Order ${tgl} "),
                              Divider(
                                color: Colors.red,
                                height: 10,
                              ),

                              // list order
                              SizedBox(
                                height:
                                    MediaQuery.of(context).size.height * 0.355,
                                child: ListView.builder(
                                  itemCount: orderNotifier.orders.length,
                                  scrollDirection: Axis.vertical,
                                  itemBuilder: (context, index) {
                                    final order = orderNotifier.orders[index];

                                    return Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.center,
                                      children: [
                                        Row(
                                          children: [
                                            Image.asset(
                                              order['imageUrl'],
                                              height: 70,
                                              width: 70,
                                            ),
                                            SizedBox(
                                              width: 20,
                                            ),
                                            Column(
                                              children: [
                                                Text(order['name']),
                                                Row(
                                                  children: [
                                                    InkWell(
                                                      onTap: () {
                                                        if (orderNotifier
                                                                    .orders[
                                                                index]['qty'] !=
                                                            1) {
                                                          orderNotifier
                                                              .updateKurangOrder(
                                                                  orderNotifier
                                                                      .orders,
                                                                  index);
                                                        } else {
                                                          orderNotifier.orders
                                                              .removeAt(index);
                                                        }
                                                        orderNotifier
                                                            .grandTotal = 0;
                                                        orderNotifier
                                                            .hitungrandTotal();
                                                      },
                                                      child: Icon(Ionicons
                                                          .remove_circle),
                                                    ),
                                                    Container(
                                                        margin: EdgeInsets
                                                            .symmetric(
                                                                horizontal: 10),
                                                        child: Text(order['qty']
                                                            .toString())),
                                                    InkWell(
                                                      onTap: () {
                                                        orderNotifier
                                                            .updateTambahOrder(
                                                                orderNotifier
                                                                    .orders,
                                                                index);

                                                        orderNotifier
                                                            .grandTotal = 0;
                                                        orderNotifier
                                                            .hitungrandTotal();
                                                      },
                                                      child: Icon(
                                                          Ionicons.add_circle),
                                                    ),
                                                  ],
                                                ),
                                              ],
                                            ),
                                          ],
                                        ),
                                        Container(
                                          margin: EdgeInsets.symmetric(
                                              horizontal: 20),
                                          child: Text(
                                            "Rp. ${order['total'].toString()}",
                                            style: appStyle(16, Colors.black,
                                                FontWeight.bold),
                                          ),
                                        ),
                                      ],
                                    );
                                  },
                                ),
                              ),
                            ],
                          ),
                          Divider(
                            color: Colors.red,
                            height: 10,
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                            children: [
                              Text(
                                "Items ${orderNotifier.orders.length}",
                                style:
                                    appStyle(16, Colors.black, FontWeight.bold),
                              ),
                              Text(
                                "Total Rp. ${orderNotifier.grandTotal}",
                                style:
                                    appStyle(18, Colors.black, FontWeight.bold),
                              ),
                            ],
                          ),
                          SizedBox(
                            height: 40,
                          ),
                          Row(
                            children: [
                              Text(
                                "Payment",
                                style:
                                    appStyle(18, Colors.black, FontWeight.bold),
                              ),
                              SizedBox(
                                height: 20,
                              ),
                            ],
                          ),
                          RadioListTile(
                            title: Text("Ovo"),
                            value: payment,
                            groupValue: payment,
                            onChanged: (value) {
                              setState(() {
                                payment = value.toString();
                              });
                            },
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.end,
                            children: [
                              ElevatedButton(
                                onPressed: () {
                                  orderNotifier.history.add({
                                    "id": orderNotifier.idHistory,
                                    "qty": orderNotifier.orders.length,
                                    "total": orderNotifier.grandTotal
                                  });

                                  orderNotifier.incrementIdHistory();

                                  _showSimpleModalDialog(context);
                                  orderNotifier.grandTotal = 0.0;
                                  orderNotifier.orders.clear();
                                },
                                child: Text("Bayar"),
                                style: ElevatedButton.styleFrom(
                                    backgroundColor: Colors.red),
                              )
                            ],
                          )
                        ],
                      ),
                    ),
                  ],
                );
              }
            },
          );
        },
      ),
    );
  }

  _showSimpleModalDialog(context) {
    showDialog(
        barrierLabel: "Status Order",
        barrierDismissible: false,
        useRootNavigator: false,
        context: context,
        builder: (BuildContext context) {
          return Dialog(
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10.0)),
            child: Container(
              constraints: BoxConstraints(maxHeight: 350),
              child: Padding(
                padding: const EdgeInsets.all(12.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Text(
                      "STATUS ORDER",
                      style: appStyle(20, Colors.black, FontWeight.bold),
                    ),
                    Divider(
                      height: 10,
                      color: Colors.black,
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Icon(
                          Ionicons.heart_circle,
                          color: Colors.green,
                          size: 100,
                        ),
                        SizedBox(
                          height: 20,
                        ),
                        Text(
                          "Transaksi Berhasil",
                          style: appStyle(30, Colors.red, FontWeight.bold),
                        ),
                        SizedBox(
                          height: 40,
                        ),
                        ElevatedButton(
                          onPressed: () {
                            Navigator.pop(context);
                            Navigator.pushReplacement(
                                context,
                                MaterialPageRoute(
                                  builder: (context) =>
                                      HomePage(username: "Habib"),
                                ));
                          },
                          child: Text("Oke"),
                          style: ElevatedButton.styleFrom(
                              backgroundColor: Colors.red),
                        )
                      ],
                    ),
                  ],
                ),
              ),
            ),
          );
        });
  }
}
