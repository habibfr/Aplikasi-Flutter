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
      body: Column(
        mainAxisAlignment: MainAxisAlignment.end,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: <Widget>[
          Container(
            child: Text("first"),
            padding: EdgeInsets.all(20.0),
            color: Colors.red,
            margin: EdgeInsets.fromLTRB(0, 20.0, 0, 0),
          ),
          Container(
            child: Text("second"),
            padding: EdgeInsets.all(25.0),
            color: Colors.green,
          ),
          Container(
            child: Text("third"),
            padding: EdgeInsets.all(40.0),
            color: Colors.blue,
            margin: EdgeInsets.only(bottom: 10.0),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            crossAxisAlignment: CrossAxisAlignment.end,
            children: <Widget>[
              Container(
                child: Text("row1"),
                color: Colors.amber,
                padding: EdgeInsets.all(20.0),
              ),
              Container(
                child: Text("row2"),
                color: Colors.cyanAccent,
                padding: EdgeInsets.all(30.0),
              ),
            ],
          ),
          Container(
            child: Text("first"),
            padding: EdgeInsets.all(20.0),
            color: Colors.red,
            margin: EdgeInsets.fromLTRB(0, 10.0, 0, 0),
          ),
          Container(
            child: Text("second"),
            padding: EdgeInsets.all(25.0),
            color: Colors.green,
          ),
          Container(
            child: Text("third"),
            padding: EdgeInsets.all(40.0),
            color: Colors.blue,
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
