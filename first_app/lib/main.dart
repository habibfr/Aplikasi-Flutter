import 'package:flutter/material.dart';

void main() {
  runApp(const MaterialApp(
    home: Home(),
  ));
}

class Home extends StatelessWidget {
  const Home({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("my first app"),
        centerTitle: true,
        backgroundColor: Colors.red[600],
      ),
      body: Row(
        children: <Widget>[
          Expanded(
            flex: 3,
            child: Image.asset("assets/nino-1.jfif"),
          ),
          Expanded(
            flex: 1,
            child: Container(
              child: Text("first"),
              color: Colors.red,
              padding: EdgeInsets.all(20.0),
            ),
          ),
          Expanded(
            flex: 1,
            child: Container(
              child: Text("second"),
              color: Colors.green,
              padding: EdgeInsets.all(20.0),
            ),
          ),
          Expanded(
            flex: 1,
            child: Container(
              child: Text("third"),
              color: Colors.blue,
              padding: EdgeInsets.all(20.0),
            ),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {},
        child: const Text("+"),
        backgroundColor: Colors.red[600],
      ),
    );
  }
}
