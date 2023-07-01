import 'package:flutter/material.dart';
import 'package:ionicons/ionicons.dart';
import 'package:provider/provider.dart';
import 'package:shoes_store_app/controllers/product_provider.dart';
import 'package:shoes_store_app/models/sneaker_model.dart';
import 'package:shoes_store_app/views/shared/appstyle.dart';
import 'package:shoes_store_app/views/shared/new_shoes.dart';
import 'package:shoes_store_app/views/shared/product_card.dart';
import 'package:shoes_store_app/views/ui/product_by_cat.dart';
import 'package:shoes_store_app/views/ui/product_page.dart';

class HomeWidget extends StatelessWidget {
  const HomeWidget({
    super.key,
    required Future<List<Sneakers>> shoes,
    required this.tabIndex,
  }) : _shoes = shoes;

  final int tabIndex;
  final Future<List<Sneakers>> _shoes;

  @override
  Widget build(BuildContext context) {
    var productNotifier = Provider.of<PorductNotifier>(context);

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
                // print(snapshot.error);
                return Text("Error ${snapshot.error}");
              } else {
                final shoes = snapshot.data;
                return ListView.builder(
                  itemCount: shoes!.length,
                  scrollDirection: Axis.horizontal,
                  itemBuilder: (context, index) {
                    final shoe = snapshot.data![index];

                    return GestureDetector(
                      onTap: () {
                        productNotifier.shoeSizes = shoe.sizes;
                        // print(productNotifier.shoeSizes);
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => ProductPage(
                                id: shoe.id, category: shoe.category),
                          ),
                        );
                      },
                      child: ProductCard(
                        price: "\$${shoe.price}",
                        category: shoe.category,
                        id: shoe.id,
                        name: shoe.name,
                        image: shoe.imageUrl[0],
                      ),
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
                  GestureDetector(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) =>
                              ProductByCat(tabIndex: tabIndex),
                        ),
                      );

                      // print(tabIndex);
                    },
                    child: Row(
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
