import 'dart:ffi';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:hive_flutter/adapters.dart';
// import 'package:hive/hive.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:ionicons/ionicons.dart';
import 'package:shoes_store_app/views/shared/appstyle.dart';
import 'package:shoes_store_app/views/shared/checkout_btn.dart';

class CartPage extends StatefulWidget {
  CartPage({super.key});

  @override
  State<CartPage> createState() => _CartPageState();
}

class _CartPageState extends State<CartPage> {
  final _cartBox = Hive.box('cart_box');
  int total = 0;

  @override
  Widget build(BuildContext context) {
    List<dynamic> cart = [];
    final cartData = _cartBox.keys.map((key) {
      final item = _cartBox.get(key);
      return {
        "key": key,
        "id": item['id'],
        "category": item['category'],
        "name": item['name'],
        "imageUrl": item['imageUrl'],
        "price": item['price'],
        "qty": item['qty'],
        "sizes": item['sizes'],
      };
    }).toList();
    // total = cartData.length;

    // print(cartData);
    // _cartBox.clear();

    // for (var i = 0; i < cartData.length; i++) {
    //   final data = cartData[i];
    //   total = data['qty'] + total;
    // }

    // print(total);

    cart = cartData.reversed.toList();

    return Scaffold(
      backgroundColor: Color(0xFFE2e2e2),
      body: Padding(
        padding: EdgeInsets.all(12),
        child: Stack(
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(
                  height: 20,
                ),
                // GestureDetector(
                //   onTap: () {
                //     Navigator.pop(context);
                //   },
                //   child: Icon(
                //     Ionicons.close,
                //     color: Colors.black,
                //   ),
                // ),
                Text(
                  "My Cart",
                  style: appStyle(25, Colors.black, FontWeight.bold),
                ),
                SizedBox(
                  height: 10,
                ),
                SizedBox(
                  height: MediaQuery.of(context).size.height * 0.65,
                  child: ListView.builder(
                    itemCount: cart.length,
                    padding: EdgeInsets.zero,
                    itemBuilder: (context, index) {
                      final data = cart[index];

                      // print(data);
                      return Padding(
                        padding: EdgeInsets.all(8),
                        child: ClipRRect(
                          borderRadius: BorderRadius.all(
                            Radius.circular(10),
                          ),
                          child: Slidable(
                            key: ValueKey(0),
                            endActionPane: ActionPane(
                              motion: ScrollMotion(),
                              children: [
                                SlidableAction(
                                  flex: 1,
                                  backgroundColor: Colors.black,
                                  foregroundColor: Colors.white,
                                  icon: Icons.delete,
                                  label: "Delete",
                                  onPressed: (context) {},
                                )
                              ],
                            ),
                            child: Container(
                              height: MediaQuery.of(context).size.height * 0.11,
                              width: MediaQuery.of(context).size.width,
                              decoration: BoxDecoration(
                                color: Colors.grey.shade100,
                                boxShadow: [
                                  BoxShadow(
                                    color: Colors.grey.shade500,
                                    spreadRadius: 5,
                                    blurRadius: 0,
                                    offset: Offset(0, 1),
                                  )
                                ],
                              ),
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Padding(
                                    padding: EdgeInsets.all(12),
                                    child: CachedNetworkImage(
                                      imageUrl: data['imageUrl'],
                                      fit: BoxFit.fill,
                                      // width: 70,
                                      // height: 89,
                                    ),
                                  ),
                                  Padding(
                                    padding: EdgeInsets.only(top: 12, left: 20),
                                    child: Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.start,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Container(
                                          width: 100,
                                          child: Text(
                                            data['name'],
                                            maxLines: 1,
                                            style: appStyle(12, Colors.black,
                                                FontWeight.bold),
                                          ),
                                        ),
                                        Text(
                                          data['category'],
                                          style: appStyle(
                                              10, Colors.grey, FontWeight.bold),
                                        ),
                                        Row(
                                          children: [
                                            Text(
                                              "\$${data['price']}",
                                              style: appStyle(14, Colors.black,
                                                  FontWeight.bold),
                                            ),
                                            // Text("${data['sizes']}")
                                          ],
                                        )
                                      ],
                                    ),
                                  ),
                                  Row(
                                    children: [
                                      InkWell(
                                        onTap: () {
                                          // int qtyNow =
                                          //     int.parse(data['qty']) - 1;
                                          setState(() {
                                            total--;
                                          });
                                          // data['qty'] = qtyNow.toString();
                                          // print(qtyNow);
                                          // data['price'] =
                                          //     data['price'] - data['price'];
                                        },
                                        child: Icon(
                                          Ionicons.remove_circle_sharp,
                                          color: Colors.grey,
                                        ),
                                      ),
                                      Container(
                                        margin: EdgeInsets.symmetric(
                                            horizontal: 10),
                                        child: Text(
                                          data['qty'].toString(),
                                          style: appStyle(12, Colors.black,
                                              FontWeight.bold),
                                        ),
                                      ),
                                      InkWell(
                                        onTap: () {
                                          // double qtyNow =
                                          //     double.parse(data['price']);
                                          // int a = int.parse(data['qty']);
                                          // print(data['qty'] + 10);
                                          // data['qty'] = qtyNow.toString();
                                          // print(qtyNow);
                                          // data['qty'] = data['qty'] + 1;
                                          // data['price'] =
                                          //     data['price'] + data['price'];
                                          setState(() {
                                            total = total + 1;
                                          });
                                        },
                                        child: Icon(
                                          Ionicons.add_circle_sharp,
                                          color: Colors.black87,
                                        ),
                                      ),
                                      SizedBox(
                                        width: 10,
                                      )
                                    ],
                                  )
                                ],
                              ),
                            ),
                          ),
                        ),
                      );
                    },
                  ),
                ),
              ],
            ),
            Padding(
              padding: EdgeInsets.only(bottom: 0),
              child: Align(
                alignment: Alignment.bottomCenter,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      total.toString(),
                      style: appStyle(29, Colors.black, FontWeight.bold),
                    ),
                    ElevatedButton(
                        onPressed: () {
                          setState(() {
                            total = total + 1;
                          });
                        },
                        child: Text("eeh")),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
