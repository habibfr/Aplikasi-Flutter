import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:ionicons/ionicons.dart';
import 'package:shoes_store_app/models/sneaker_model.dart';
import 'package:shoes_store_app/services/helper.dart';
import 'package:shoes_store_app/views/shared/stagger_tile.dart';

import '../shared/appstyle.dart';
import '../shared/latest_shoes.dart';
import '../shared/product_card.dart';

class ProductByCat extends StatefulWidget {
  const ProductByCat({super.key});

  @override
  State<ProductByCat> createState() => _ProductByCatState();
}

class _ProductByCatState extends State<ProductByCat>
    with TickerProviderStateMixin {
  late final TabController _tabController =
      TabController(length: 3, vsync: this);

  late Future<List<Sneakers>> _male;
  late Future<List<Sneakers>> _female;
  late Future<List<Sneakers>> _kids;

  void getMale() {
    _male = Helper().getMaleSneakers();
  }

  void getFemale() {
    _female = Helper().getFemaleSneakers();
  }

  void getKids() {
    _kids = Helper().getKidSneakers();
  }

  @override
  void initState() {
    super.initState();
    getMale();
    getFemale();
    getKids();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFFE2e2e2),
      body: SizedBox(
        height: MediaQuery.of(context).size.height,
        child: Stack(
          children: [
            Container(
              padding: EdgeInsets.fromLTRB(16, 30, 0, 0),
              height: MediaQuery.of(context).size.height * 0.4,
              decoration: BoxDecoration(
                image: DecorationImage(
                    image: AssetImage("assets/images/top_image.png"),
                    fit: BoxFit.fill),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: EdgeInsets.fromLTRB(6, 0, 16, 0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        GestureDetector(
                          onTap: () {
                            Navigator.pop(context);
                          },
                          child: Icon(
                            Ionicons.close,
                            color: Colors.white,
                          ),
                        ),
                        GestureDetector(
                          onTap: () {
                            // Navigator.pop(context);
                          },
                          child: Icon(
                            Ionicons.options,
                            color: Colors.white,
                          ),
                        ),
                      ],
                    ),
                  ),
                  TabBar(
                    padding: EdgeInsets.zero,
                    indicatorSize: TabBarIndicatorSize.label,
                    indicatorColor: Colors.transparent,
                    controller: _tabController,
                    isScrollable: true,
                    labelColor: Colors.white,
                    labelStyle: appStyle(16, Colors.white, FontWeight.bold),
                    unselectedLabelColor: Colors.grey.withOpacity(0.3),
                    tabs: const [
                      Tab(
                        text: "Men Shoes",
                      ),
                      Tab(
                        text: "Women Shoes",
                      ),
                      Tab(
                        text: "Kids Shoes",
                      )
                    ],
                  ),
                ],
              ),
            ),
            Padding(
              padding: EdgeInsets.only(
                  top: MediaQuery.of(context).size.height * 0.15,
                  left: 16,
                  right: 12),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(12),
                child: TabBarView(
                  controller: _tabController,
                  children: [
                    LatestShoes(shoes: _male),
                    LatestShoes(shoes: _female),
                    LatestShoes(shoes: _kids),
                  ],
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
