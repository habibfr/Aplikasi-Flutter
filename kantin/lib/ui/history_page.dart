import 'package:flutter/material.dart';
import 'package:kantin/controllers/order_notifier.dart';
import 'package:kantin/shared/app_style.dart';
import 'package:provider/provider.dart';

class HistoryPage extends StatefulWidget {
  const HistoryPage({super.key});

  @override
  State<HistoryPage> createState() => _HistoryPageState();
}

class _HistoryPageState extends State<HistoryPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("History Order"),
        backgroundColor: Colors.red,
      ),
      body: Consumer<OrderNotifier>(
        builder: (context, orderNotifier, child) {
          // print(orderNotifier.history);
          return Stack(
            children: [
              Container(
                padding: EdgeInsets.fromLTRB(16, 10, 0, 0),
                height: MediaQuery.of(context).size.height * 0.15,
                decoration: BoxDecoration(
                    image: DecorationImage(
                        image: AssetImage("assets/images/banner.png"),
                        fit: BoxFit.fill)),
              ),
              Padding(
                padding: EdgeInsets.only(top: 110, left: 15, right: 10),
                child: Column(
                  children: [
                    Row(
                      // crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        ElevatedButton(
                          onPressed: () {},
                          child: Text("Export"),
                          style: ElevatedButton.styleFrom(
                              backgroundColor: Colors.red),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              Padding(
                padding: EdgeInsets.only(top: 155, left: 15, right: 10),
                child: Column(
                  children: [
                    Text(
                      "Total Order : ${orderNotifier.history.length}",
                      style: appStyle(20, Colors.black, FontWeight.bold),
                    ),
                  ],
                ),
              ),
              Padding(
                padding: EdgeInsets.only(top: 175, left: 15, right: 10),
                child: Column(
                  children: [
                    Divider(
                      color: Colors.red,
                      height: 20,
                      thickness: 3,
                    ),
                    SizedBox(
                      height: MediaQuery.of(context).size.height * 0.59,
                      width: MediaQuery.of(context).size.width,
                      child: ListView.builder(
                          padding: const EdgeInsets.symmetric(
                              vertical: 10.0, horizontal: 8.0),
                          shrinkWrap: true,
                          itemCount: orderNotifier.history.length,
                          itemBuilder: (context, index) {
                            return Column(
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text("Order ${index + 1}"),
                                SizedBox(
                                  height: 5,
                                ),
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text(
                                      "Jumlah Item : ${orderNotifier.history[index]['qty']}",
                                      style: appStyle(
                                          14, Colors.black, FontWeight.bold),
                                    ),
                                    Text(
                                      "Total Harga : Rp. ${orderNotifier.history[index]['total']}",
                                      style: appStyle(
                                          16, Colors.black, FontWeight.w600),
                                    )
                                  ],
                                ),
                                Divider(
                                  height: 30,
                                  color: Colors.red,
                                  thickness: 2,
                                ),
                              ],
                            );
                          }),
                    )
                  ],
                ),
              ),
            ],
          );
        },
      ),
    );
  }
}
