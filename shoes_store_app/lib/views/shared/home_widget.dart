import 'package:flutter/material.dart';
import 'package:ionicons/ionicons.dart';
import 'package:shoes_store_app/models/sneaker_model.dart';
import 'package:shoes_store_app/views/shared/appstyle.dart';
import 'package:shoes_store_app/views/shared/new_shoes.dart';
import 'package:shoes_store_app/views/shared/product_card.dart';

class HomeWidget extends StatelessWidget {
  const HomeWidget({
    super.key,
    required Future<List<Sneakers>> shoes,
  }) : _shoes = shoes;

  final Future<List<Sneakers>> _shoes;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SizedBox(
          height: MediaQuery.of(context).size.height * 0.405,
          child: FutureBuilder<List<Sneakers>>(
            future: _shoes,
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return CircularProgressIndicator();
              } else if (snapshot.hasError) {
                print(snapshot.error);
                return Text("Error ${snapshot.error}");
              } else {
                final shoes = snapshot.data;
                return ListView.builder(
                  itemCount: shoes!.length,
                  scrollDirection: Axis.horizontal,
                  itemBuilder: (context, index) {
                    final shoe = snapshot.data![index];

                    return ProductCard(
                      price: shoe.price,
                      category: shoe.category,
                      id: shoe.id,
                      name: shoe.name,
                      image: shoe.imageUrl[0],
                    );
                  },
                );
              }
            },
          ),
        ),
        Column(
          children: [
            Padding(
              padding: const EdgeInsets.fromLTRB(5, 10, 6, 10),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    "Latest shoes",
                    style: appStyle(18, Colors.black, FontWeight.bold),
                  ),
                  Row(
                    children: [
                      Text(
                        "Show all",
                        style: appStyle(
                          18,
                          Colors.black,
                          FontWeight.w500,
                        ),
                      ),
                      Icon(
                        Ionicons.caret_forward,
                        size: 22,
                      )
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
        SizedBox(
          height: MediaQuery.of(context).size.height * 0.11,
          child: ListView.builder(
            itemCount: 6,
            scrollDirection: Axis.horizontal,
            itemBuilder: (context, index) {
              return Padding(
                padding: const EdgeInsets.all(8.0),
                child: SizedBox(
                  width: MediaQuery.of(context).size.width,
                  height: MediaQuery.of(context).size.height * 0.15,
                  child: FutureBuilder<List<Sneakers>>(
                    future: _shoes,
                    builder: (context, snapshot) {
                      if (snapshot.connectionState == ConnectionState.waiting) {
                        return CircularProgressIndicator();
                      } else if (snapshot.hasError) {
                        // print(snapshot.error);
                        return Text("Error ${snapshot.error}");
                      } else {
                        final male = snapshot.data;
                        return ListView.builder(
                          itemCount: male!.length,
                          scrollDirection: Axis.horizontal,
                          itemBuilder: (context, index) {
                            final shoe = snapshot.data![index];

                            return Container(
                              margin: const EdgeInsets.only(right: 10),
                              child: NewShoes(imageUrl: shoe.imageUrl[1]),
                            );
                          },
                        );
                      }
                    },
                  ),
                ),
              );
            },
          ),
        )
      ],
    );
  }
}
