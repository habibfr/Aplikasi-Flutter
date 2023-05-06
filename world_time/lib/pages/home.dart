import 'package:flutter/material.dart';

class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {

  Map data = {};


  @override
  Widget build(BuildContext context) {

    data = ModalRoute.of(context)!.settings.arguments as Map;

    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            TextButton.icon(
              onPressed: () {
                Navigator.pushNamed(context, '/chooseLocation');
              },
              icon: Icon(
                Icons.location_on
              ),
              label: Text("Choose Location"),
            ),
            Text(data['location']),
            Text(data['time']),
            Text(data['flag']),
          ],
        ),
      ),
    );
  }
}
