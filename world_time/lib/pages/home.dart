import 'package:flutter/material.dart';

class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  Map data = {};
  String bgImage = '';
  @override
  Widget build(BuildContext context) {
    data = ModalRoute.of(context)!.settings.arguments as Map;

    bgImage = data['isDayTime'] ? 'day-3.jfif' : 'night-1.jfif';
    Color? bgColor = data['isDayTime'] ? Colors.blue[400] : Colors.indigo[800];

    return Scaffold(
      backgroundColor: bgColor,
      body: SafeArea(
        child: Container(
          decoration: BoxDecoration(
            image: DecorationImage(
              image: AssetImage('assets/${bgImage}'),
              fit: BoxFit.cover
            )
          ),
          child: Padding(
            padding: const EdgeInsets.only(top: 100.0),
            child: Column(
              children: [
                TextButton.icon(
                  onPressed: () {
                    Navigator.pushNamed(context, '/chooseLocation');
                  },
                  icon: Icon(
                    Icons.location_on,
                    color: Colors.grey[300],
                  ),
                  label: Text(
                    "Edit Location",
                    style: TextStyle(color: Colors.grey[300]),
                  ),
                ),
                SizedBox(
                  height: 20.0,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Text(
                      data['location'],
                      style: TextStyle(fontSize: 28.0, letterSpacing: 2.0, color: Colors.white),
                    ),
                  ],
                ),
                SizedBox(
                  height: 20.0,
                ),
                Text(
                  data['time'],
                  style: TextStyle(
                    fontSize: 66.0,
                    color: Colors.white
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
