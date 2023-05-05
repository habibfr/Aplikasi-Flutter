import 'package:flutter/material.dart';

void main() {
  runApp(MaterialApp(
    home: NinjaProject(),
  ));
}

class NinjaProject extends StatefulWidget {
  const NinjaProject({Key? key}) : super(key: key);

  @override
  State<NinjaProject> createState() => _NinjaProjectState();
}

class _NinjaProjectState extends State<NinjaProject> {

  int levelNinja = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[850],
      appBar: AppBar(
        title: Text("Net Ninja Card"),
        centerTitle: true,
        backgroundColor: Colors.grey[900],
        elevation: 0.0,
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          setState(() {
            levelNinja += 1;
          });
        },
        child: Icon(
          Icons.add
        ),
        backgroundColor: Colors.grey[800],
      ),
      body: Padding(
        padding: EdgeInsets.fromLTRB(30.0, 40.0, 30.0, 0.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Center(
              child: CircleAvatar(
                backgroundImage: AssetImage("assets/nino-2.jfif"),
                radius: 50.0,
              ),
            ),
            Divider(
              height: 90.0,
              color: Colors.grey[800],
            ),
            Text(
              "NAME",
              style: TextStyle(
                color: Colors.grey,
                letterSpacing: 2.0,
              ),
            ),
            SizedBox(height: 10.0),
            Text(
              "Nakano Nino",
              style: TextStyle(
                color: Colors.amberAccent[200],
                letterSpacing: 2.0,
                fontSize: 28.0,
                fontWeight: FontWeight.bold
              ),
            ),
            SizedBox(height: 30.0),
            Text(
              "CURRENT LEVEL NINJA",
              style: TextStyle(
                color: Colors.grey,
                letterSpacing: 2.0,
              ),
            ),
            SizedBox(height: 10.0),
            Text(
              "$levelNinja",
              style: TextStyle(
                color: Colors.amberAccent[200],
                letterSpacing: 2.0,
                fontSize: 28.0,
                fontWeight: FontWeight.bold
              ),
            ),
            SizedBox(height: 30.0),
            Row(
              children: <Widget>[
                Icon(
                  Icons.email,
                  color: Colors.grey[400],
                ),
                SizedBox(width: 10.0),
                Text(
                  "nino-nakano25@gmail.com",
                  style: TextStyle(
                    fontSize: 18.0,
                    letterSpacing: 1.0,
                    color: Colors.grey[400]
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

