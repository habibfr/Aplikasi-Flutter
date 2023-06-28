import 'package:flutter/material.dart';
import 'package:shoes_store_app/views/shared/appstyle.dart';
// import 'package:shoes_store_app/views/shared/appstyle.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> with TickerProviderStateMixin {
  late final TabController _tabController =
      TabController(length: 3, vsync: this);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SizedBox(
        height: MediaQuery.of(context).size.height,
        child: Stack(
          children: [
            Container(
              padding: EdgeInsets.fromLTRB(16, 45, 0, 0),
              height: MediaQuery.of(context).size.height * 0.4,
              decoration: BoxDecoration(
                  image: DecorationImage(
                      image: AssetImage("assets/images/top_image.png"),
                      fit: BoxFit.fill)),
              child: Container(
                padding: EdgeInsets.only(left: 5, bottom: 15),
                width: MediaQuery.of(context).size.width,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Athletics Shoes",
                      style: appStyleWithHt(
                          38, Colors.white, FontWeight.bold, 1.2),
                    ),
                    Text(
                      "Collection",
                      style: appStyleWithHt(
                          36, Colors.white, FontWeight.bold, 1.2),
                    ),
                    TabBar(
                        indicatorSize: TabBarIndicatorSize.label,
                        indicatorColor: Colors.transparent,
                        controller: _tabController,
                        isScrollable: true,
                        labelColor: Colors.white,
                        labelStyle: appStyle(16, Colors.white, FontWeight.bold),
                        unselectedLabelColor: Colors.grey.withOpacity(0.3),
                        tabs: [
                          Tab(
                            text: "Men Shoes",
                          ),
                          Tab(
                            text: "Women Shoes",
                          ),
                          Tab(
                            text: "Kids Shoes",
                          )
                        ]),
                  ],
                ),
              ),
            ),
            Padding(
              padding: EdgeInsets.only(
                  top: MediaQuery.of(context).size.height * 0.285),
              child: TabBarView(controller: _tabController, children: [
                Column(
                  children: [
                    Container(
                      height: MediaQuery.of(context).size.height * 0.405,
                      color: Colors.amber,
                    ),
                  ],
                ),
                Column(
                  children: [
                    Container(
                      height: MediaQuery.of(context).size.height * 0.405,
                      color: Colors.green,
                    ),
                  ],
                ),
                Column(
                  children: [
                    Container(
                      height: MediaQuery.of(context).size.height * 0.405,
                      color: Colors.amber,
                    ),
                  ],
                ),
              ]),
            )
          ],
        ),
      ),
    );
  }
}
