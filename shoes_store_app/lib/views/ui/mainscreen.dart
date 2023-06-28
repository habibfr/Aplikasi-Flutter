import 'package:flutter/material.dart';
import 'package:ionicons/ionicons.dart';
import 'package:provider/provider.dart';
import 'package:shoes_store_app/controllers/mainscreen_provider.dart';
import 'package:shoes_store_app/views/shared/bottom_nav_bar.dart';
import 'package:shoes_store_app/views/ui/cartpage.dart';
import 'package:shoes_store_app/views/ui/homepage.dart';
import 'package:shoes_store_app/views/ui/profile.dart';
import 'package:shoes_store_app/views/ui/searchpage.dart';

import '../shared/bottom_nav_widget.dart';
// import 'package:shoes_store_app/views/shared/appstyle.dart';

class MainScreen extends StatelessWidget {
  MainScreen({super.key});

  List<Widget> pageList = const [
    HomePage(),
    SearchPage(),
    HomePage(),
    CartPage(),
    ProfilPage()
  ];

  @override
  Widget build(BuildContext context) {
    return Consumer<MainScreenNotifier>(
      builder: (context, mainScreenNotifier, child) {
        return Scaffold(
          backgroundColor: Color(0xFFE2e2e2),
          body: pageList[mainScreenNotifier.pageIndex],
          bottomNavigationBar: const BottomNavBar(),
        );
        ;
      },
    );
  }
}
