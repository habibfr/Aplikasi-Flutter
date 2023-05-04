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
      body: Padding(
        padding: EdgeInsets.all(20.0),
        child: Text("hello"),
      ),
      // Container(
      //   color: Colors.grey,
      //   // margin: EdgeInsets.all(10.0),
      //   // padding: EdgeInsets.all(20.0),
      //   // padding: EdgeInsets.fromLTRB(10.0, 20.0, 10.0, 20.0),
      //   padding: EdgeInsets.symmetric(horizontal: 20.0, vertical: 10.0),
      //   child: Text("hello"),
      // ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {},
        child: const Text("+"),
        backgroundColor: Colors.red[600],
      ),
    );
  }
}
