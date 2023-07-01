import 'package:flutter/material.dart';
import 'package:ionicons/ionicons.dart';
import 'package:kantin/controllers/order_notifier.dart';
import 'package:kantin/models/product_model.dart';
import 'package:kantin/services/helper.dart';
import 'package:kantin/shared/app_style.dart';
import 'package:kantin/shared/floating_btn.dart';
import 'package:kantin/ui/cart_page.dart';
import 'package:provider/provider.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key, required this.username});

  final String username;

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> with TickerProviderStateMixin {
  late final TabController _tabController =
      TabController(length: 3, vsync: this);

  final List<Map> myProduct = List.generate(
      8,
      (index) => {
            "id": index,
            "qty": 0,
            "price": 0,
            "name": "product ${index}"
          }).toList();

  num _total_price = 0;

  void _refreh_price() {
    _total_price += 500;
  }

  void _refreh_min_price() {
    _total_price -= 500;
  }

  late Future<List<Product>> _products;

  void getProducts() {
    _products = Helper().getProducts();
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    // _refreh_price();
    getProducts();
    // print(_products);
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<OrderNotifier>(builder: (context, orderNotifier, child) {
      // print(orderNotifier.quantity);
      return Scaffold(
        appBar: AppBar(
          title: Text("Home"),
          backgroundColor: Colors.red,
        ),
        drawer: NavigationDrawer(),
        backgroundColor: Color(0xFFE2e2e2),
        body: Container(
          child: SizedBox(
            height: MediaQuery.of(context).size.height,
            child: Stack(
              children: [
                Container(
                  padding: EdgeInsets.fromLTRB(16, 10, 0, 0),
                  height: MediaQuery.of(context).size.height * 0.25,
                  decoration: BoxDecoration(
                      image: DecorationImage(
                          image: AssetImage("assets/images/banner.png"),
                          fit: BoxFit.fill)),
                  child: Container(
                    padding: EdgeInsets.only(left: 5, bottom: 15),
                    width: MediaQuery.of(context).size.width,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "Delicious Foods",
                          style: appStyle(33, Colors.white, FontWeight.bold),
                        ),
                        Text(
                          "Menu",
                          style: appStyle(33, Colors.white, FontWeight.bold),
                        ),
                        TabBar(
                            padding: EdgeInsets.zero,
                            indicatorSize: TabBarIndicatorSize.label,
                            indicatorColor: Colors.transparent,
                            controller: _tabController,
                            isScrollable: true,
                            labelColor: Colors.white,
                            labelStyle:
                                appStyle(16, Colors.white, FontWeight.bold),
                            unselectedLabelColor: Colors.grey.withOpacity(0.3),
                            tabs: const [
                              Tab(
                                text: "All",
                              ),
                              Tab(
                                text: "Crispy Chicken",
                              ),
                              Tab(
                                text: "Rice",
                              )
                            ]),
                      ],
                    ),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.only(
                      top: MediaQuery.of(context).size.height * 0.25),
                  child: Container(
                    padding: EdgeInsets.only(left: 12),
                    child: TabBarView(
                      controller: _tabController,
                      children: [
                        FutureBuilder<List<Product>>(
                            future: _products,
                            builder: (context, snapshot) {
                              if (snapshot.connectionState ==
                                  ConnectionState.waiting) {
                                return CircularProgressIndicator();
                              } else if (snapshot.hasError) {
                                return Text("Error ${snapshot.error}");
                              } else {
                                final products = snapshot.data;
                                // print(products);
                                return Column(
                                  children: [
                                    SizedBox(
                                      height:
                                          MediaQuery.of(context).size.height *
                                              0.5,
                                      child: GridView.builder(
                                        gridDelegate:
                                            SliverGridDelegateWithMaxCrossAxisExtent(
                                                maxCrossAxisExtent: 120,
                                                childAspectRatio: 2 / 3,
                                                crossAxisSpacing: 1,
                                                mainAxisSpacing: 1),
                                        itemCount: products!.length,
                                        scrollDirection: Axis.vertical,
                                        itemBuilder: (context, index) {
                                          final product = products[index];
                                          // print(product);
                                          //  product = myProduct[index];
                                          return Column(
                                            // crossAxisAlignment: CrossAxisAlignment.center,
                                            mainAxisAlignment:
                                                MainAxisAlignment.start,
                                            children: [
                                              Container(
                                                  margin: EdgeInsets.all(10),
                                                  // decoration: BoxDecoration(
                                                  //     border:
                                                  //         Border.all(color: Colors.red)),
                                                  // height: 50,
                                                  child: Image.asset(
                                                      product.imageUrl)
                                                  // Center(child: Text(myProduct[index]['name'])),
                                                  // child: Text(product.),
                                                  ),
                                              Text(product.name),
                                              Text(
                                                  "Rp. ${product.price.toString()}"),
                                              Row(
                                                mainAxisAlignment:
                                                    MainAxisAlignment.center,
                                                children: [
                                                  InkWell(
                                                      onTap: () {
                                                        setState(() {
                                                          if (myProduct[index]
                                                                  ['qty'] ==
                                                              0) {
                                                            return;
                                                          } else {
                                                            myProduct[index]
                                                                ['qty'] -= 1;
                                                            // myProduct[index]['price'] -=
                                                            //     500;
                                                            _refreh_min_price();
                                                          }
                                                        });
                                                      },
                                                      child: Icon(Ionicons
                                                          .remove_circle)),
                                                  Container(
                                                    margin:
                                                        EdgeInsets.symmetric(
                                                            horizontal: 10),
                                                    child: Text(myProduct[index]
                                                            ['qty']
                                                        .toString()),
                                                  ),
                                                  InkWell(
                                                      onTap: () {
                                                        setState(() {
                                                          myProduct[index]
                                                              ['qty'] += 1;
                                                          orderNotifier
                                                              .increment();
                                                          // myProduct[index]['price'] +=
                                                          //     500;
                                                        });
                                                        _refreh_price();
                                                      },
                                                      child: Icon(
                                                          Ionicons.add_circle)),
                                                ],
                                              )
                                            ],
                                          );

                                          //       );
                                        },
                                      ),
                                    ),
                                    CheckoutButton(
                                        onTap: () {
                                          // print(_products);
                                          Navigator.push(
                                              context,
                                              MaterialPageRoute(
                                                builder: (context) =>
                                                    CartPage(),
                                              ));
                                        },
                                        label:
                                            "Quantity ${orderNotifier.quantity}  Checkout ${_total_price}")
                                  ],
                                );
                              }
                            }),
                        Text("Ini Crispy"),
                        Text("Ini Rice"),
                      ],
                    ),
                  ),
                )
              ],
            ),
          ),
        ),
      );
    });
  }
}

class NavigationDrawer extends StatelessWidget {
  const NavigationDrawer({super.key});

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            buildHeader(context),
            buildMenuItems(context),
          ],
        ),
      ),
    );
  }

  Widget buildHeader(BuildContext context) => Container(
        padding: EdgeInsets.all(24),
      );
  Widget buildMenuItems(BuildContext context) => Wrap(
        runSpacing: 16,
        children: [
          ListTile(
            leading: Icon(Icons.home_outlined),
            title: Text('Home'),
            onTap: () {
              Navigator.pop(context);
            },
            // onTap: () => Navigator.of(context).pushReplacement(
            //     MaterialPageRoute(
            //         builder: (context) => HomePage(username: "Habib"))),
          ),
          ListTile(
            leading: Icon(Icons.favorite_border),
            title: Text('My Order'),
            onTap: () {
              Navigator.pop(context);
              Navigator.push(context, MaterialPageRoute(
                builder: (context) {
                  return CartPage();
                },
              ));
            },
          ),
          ListTile(
            leading: Icon(Icons.workspaces_outline),
            title: Text('Workflow'),
            onTap: () {},
          ),
          ListTile(
            leading: Icon(Icons.update),
            title: Text('Updates'),
            onTap: () {},
          ),
          Divider(
            color: Colors.black54,
          ),
          ListTile(
            leading: Icon(Icons.account_tree_outlined),
            title: Text('Pllugins'),
            onTap: () {},
          ),
          ListTile(
            leading: Icon(Icons.alarm_outlined),
            title: Text('Notifications'),
            onTap: () {},
          ),
        ],
      );
}
