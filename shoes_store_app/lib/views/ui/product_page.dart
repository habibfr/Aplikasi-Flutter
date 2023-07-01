import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:hive/hive.dart';
import 'package:ionicons/ionicons.dart';
import 'package:provider/provider.dart';
import 'package:shoes_store_app/controllers/product_provider.dart';
import 'package:shoes_store_app/services/helper.dart';
import 'package:shoes_store_app/views/shared/appstyle.dart';

import '../../models/sneaker_model.dart';
import '../shared/checkout_btn.dart';

class ProductPage extends StatefulWidget {
  const ProductPage({super.key, required this.id, required this.category});

  final String id;
  final String category;

  @override
  State<ProductPage> createState() => _ProductPageState();
}

class _ProductPageState extends State<ProductPage> {
  final PageController pageController = PageController();
  final _cartBox = Hive.box('cart_box');

  late Future<Sneakers> _sneaker;

  void getShoes() {
    if (widget.category == "Men's Running") {
      _sneaker = Helper().getMaleSneakerById(widget.id);
    } else if (widget.category == "Women's Running") {
      _sneaker = Helper().getFemaleSneakerById(widget.id);
    } else {
      _sneaker = Helper().getKidSneakerById(widget.id);
    }
  }

  Future<void> _createCart(Map<String, dynamic> newCart) async {
    await _cartBox.add(newCart);
  }

  @override
  void initState() {
    super.initState();
    getShoes();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // backgroundColor: Colors.transparent,
      body: FutureBuilder<Sneakers>(
        future: _sneaker,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return CircularProgressIndicator();
          } else if (snapshot.hasError) {
            print(snapshot.error);
            return Text("Error ${snapshot.error}");
          } else {
            final sneaker = snapshot.data;
            return Consumer<PorductNotifier>(
              builder: (context, productNotifier, child) {
                // print(productNotifier.shoeSizes);
                return CustomScrollView(
                  slivers: [
                    SliverAppBar(
                      automaticallyImplyLeading: false,
                      leadingWidth: 0,
                      title: Padding(
                        padding: EdgeInsets.only(bottom: 10),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            GestureDetector(
                              onTap: () {
                                productNotifier.shoeSizes.clear();
                                Navigator.pop(context);
                              },
                              child: Icon(
                                Ionicons.close,
                                color: Colors.black,
                              ),
                            ),
                            GestureDetector(
                              onTap: null,
                              child: Icon(
                                Ionicons.ellipsis_horizontal,
                                color: Colors.black,
                              ),
                            ),
                          ],
                        ),
                      ),
                      pinned: true,
                      snap: false,
                      floating: true,
                      backgroundColor: Color.fromARGB(255, 228, 228, 228),
                      expandedHeight: MediaQuery.of(context).size.height,
                      flexibleSpace: FlexibleSpaceBar(
                        background: Stack(
                          children: [
                            SizedBox(
                              height: MediaQuery.of(context).size.height * 0.5,
                              width: MediaQuery.of(context).size.width,
                              child: PageView.builder(
                                scrollDirection: Axis.horizontal,
                                itemCount: sneaker!.imageUrl.length,
                                controller: pageController,
                                onPageChanged: (page) {
                                  productNotifier.activePage = page;
                                },
                                itemBuilder: (context, index) {
                                  return Stack(
                                    children: [
                                      Container(
                                        height:
                                            MediaQuery.of(context).size.height *
                                                0.39,
                                        width:
                                            MediaQuery.of(context).size.width,
                                        color: Colors.grey.shade300,
                                        child: CachedNetworkImage(
                                          imageUrl: sneaker.imageUrl[index],
                                          fit: BoxFit.contain,
                                        ),
                                      ),
                                      Positioned(
                                        top:
                                            MediaQuery.of(context).size.height *
                                                0.1,
                                        right: 16,
                                        child: Icon(
                                          Ionicons.heart_outline,
                                          color: Colors.grey,
                                        ),
                                      ),
                                      Positioned(
                                        bottom: 0,
                                        right: 0,
                                        left: 0,
                                        height:
                                            MediaQuery.of(context).size.height *
                                                0.3,
                                        child: Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.center,
                                          children: List<Widget>.generate(
                                            sneaker.imageUrl.length,
                                            (index) => Padding(
                                              padding: EdgeInsets.symmetric(
                                                  horizontal: 4),
                                              child: CircleAvatar(
                                                radius: 5,
                                                backgroundColor: productNotifier
                                                            .activePage !=
                                                        index
                                                    ? Colors.grey
                                                    : Colors.black,
                                              ),
                                            ),
                                          ),
                                        ),
                                      ),
                                    ],
                                  );
                                },
                              ),
                            ),
                            Positioned(
                              bottom: 30,
                              child: ClipRRect(
                                borderRadius: BorderRadius.only(
                                  topLeft: Radius.circular(30),
                                  topRight: Radius.circular(30),
                                ),
                                child: Container(
                                  height:
                                      MediaQuery.of(context).size.height * 0.62,
                                  width: MediaQuery.of(context).size.width,
                                  color: Colors.white,
                                  child: Padding(
                                    padding: EdgeInsets.all(12),
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          sneaker.name,
                                          style: appStyle(20, Colors.black,
                                              FontWeight.bold),
                                        ),
                                        SizedBox(
                                          height: 5,
                                        ),
                                        Row(
                                          children: [
                                            Text(
                                              sneaker.category,
                                              style: appStyle(12, Colors.grey,
                                                  FontWeight.bold),
                                            ),
                                            SizedBox(
                                              width: 22,
                                            ),
                                            RatingBar.builder(
                                              initialRating: 4,
                                              minRating: 1,
                                              direction: Axis.horizontal,
                                              allowHalfRating: true,
                                              itemCount: 5,
                                              itemSize: 10,
                                              itemPadding: EdgeInsets.symmetric(
                                                  horizontal: 1),
                                              itemBuilder: (context, index) {
                                                return Icon(Ionicons.star);
                                              },
                                              onRatingUpdate: (rating) {},
                                            )
                                          ],
                                        ),
                                        SizedBox(
                                          height: 5,
                                        ),
                                        Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          children: [
                                            Text(
                                              "\$${sneaker.price}",
                                              style: appStyle(20, Colors.black,
                                                  FontWeight.w700),
                                            ),
                                            Row(
                                              children: [
                                                Text(
                                                  "Colors",
                                                  style: appStyle(
                                                      14,
                                                      Colors.black,
                                                      FontWeight.w500),
                                                ),
                                                SizedBox(
                                                  width: 5,
                                                ),
                                                CircleAvatar(
                                                  radius: 7,
                                                  backgroundColor: Colors.black,
                                                ),
                                                CircleAvatar(
                                                  radius: 7,
                                                  backgroundColor: Colors.black,
                                                )
                                              ],
                                            ),
                                          ],
                                        ),
                                        SizedBox(
                                          height: 10,
                                        ),
                                        Column(
                                          children: [
                                            Row(
                                              children: [
                                                Text(
                                                  "Select size ",
                                                  style: appStyle(
                                                      14,
                                                      Colors.black,
                                                      FontWeight.w600),
                                                ),
                                                SizedBox(
                                                  width: 20,
                                                ),
                                                Text(
                                                  "View size guide",
                                                  style: appStyle(
                                                      14,
                                                      Colors.grey,
                                                      FontWeight.w600),
                                                )
                                              ],
                                            ),
                                            SizedBox(
                                              height: 5,
                                            ),
                                            SizedBox(
                                              height: 30,
                                              child: ListView.builder(
                                                itemCount: productNotifier
                                                    .shoeSizes.length,
                                                scrollDirection:
                                                    Axis.horizontal,
                                                padding: EdgeInsets.zero,
                                                itemBuilder: (context, index) {
                                                  // print(productNotifier
                                                  //     .sizes[index]);
                                                  final sizes = productNotifier
                                                      .shoeSizes[index];

                                                  return Container(
                                                    margin: EdgeInsets.only(
                                                        right: 5),
                                                    child: ChoiceChip(
                                                      shape:
                                                          RoundedRectangleBorder(
                                                        borderRadius:
                                                            BorderRadius
                                                                .circular(0),
                                                        side: BorderSide(
                                                            color: Colors.black,
                                                            width: 0.5,
                                                            style: BorderStyle
                                                                .solid),
                                                      ),
                                                      disabledColor:
                                                          Colors.white,
                                                      label: Text(
                                                        sizes['size'],
                                                        style: appStyle(
                                                            14,
                                                            sizes['isSelected']
                                                                ? Colors.white
                                                                : Colors
                                                                    .black38,
                                                            FontWeight.w500),
                                                      ),
                                                      selectedColor:
                                                          Colors.black,
                                                      selected:
                                                          sizes['isSelected'],
                                                      onSelected: (newState) {
                                                        if (productNotifier
                                                            .sizes
                                                            .contains(sizes[
                                                                'size'])) {
                                                          productNotifier.sizes
                                                              .remove(sizes[
                                                                  'size']);
                                                        } else {
                                                          productNotifier.sizes
                                                              .add(sizes[
                                                                  'size']);
                                                        }

                                                        // print(productNotifier
                                                        //     .sizes);

                                                        productNotifier
                                                            .toggleCheck(index);
                                                      },
                                                    ),
                                                  );
                                                },
                                              ),
                                            )
                                          ],
                                        ),
                                        SizedBox(
                                          height: 5,
                                        ),
                                        Divider(
                                          indent: 1,
                                          endIndent: 1,
                                          color: Colors.black,
                                        ),
                                        SizedBox(
                                          height: 5,
                                        ),
                                        SizedBox(
                                          // height: 5,
                                          width: MediaQuery.of(context)
                                                  .size
                                                  .width *
                                              0.8,
                                          child: Text(
                                            sneaker.title,
                                            style: appStyle(14, Colors.black,
                                                FontWeight.w700),
                                          ),
                                        ),
                                        SizedBox(
                                          height: 5,
                                        ),
                                        Text(
                                          sneaker.description,
                                          textAlign: TextAlign.justify,
                                          maxLines: 4,
                                          style: appStyle(12, Colors.grey,
                                              FontWeight.normal),
                                        ),
                                        Align(
                                          alignment: Alignment.bottomCenter,
                                          child: Padding(
                                            padding: EdgeInsets.only(top: 4),
                                            child: CheckoutButton(
                                                onTap: () async {
                                                  // productNotifier.sizes.clear();

                                                  _createCart(
                                                    {
                                                      "id": sneaker.id,
                                                      "name": sneaker.name,
                                                      "category":
                                                          sneaker.category,
                                                      "imageUrl":
                                                          sneaker.imageUrl[0],
                                                      "price": sneaker.price,
                                                      "qty": 1,
                                                      "sizes":
                                                          productNotifier.sizes,
                                                    },
                                                  );

                                                  if (productNotifier
                                                          .sizes.length >
                                                      0) {
                                                    productNotifier.sizes
                                                        .clear();
                                                  }

                                                  // print(productNotifier.sizes);
                                                  // print(productNotifier);

                                                  Navigator.pop(context);
                                                },
                                                label: "Add to Cart"),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                );
              },
            );
          }
        },
      ),
    );
  }
}
