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
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          Text("hello"),
          ElevatedButton(
            onPressed: () {},
            child: Text("click"),
            style: ElevatedButton.styleFrom(backgroundColor: Colors.red[600]),
          ),
          Container(
            color: Colors.cyan,
            child: Text("hello world"),
            padding: EdgeInsets.all(20.0),
          )
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
