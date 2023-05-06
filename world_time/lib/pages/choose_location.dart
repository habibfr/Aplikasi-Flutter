import 'package:flutter/material.dart';

class ChooseLocation extends StatefulWidget {
  const ChooseLocation({Key? key}) : super(key: key);

  @override
  State<ChooseLocation> createState() => _ChooseLocationState();
}

class _ChooseLocationState extends State<ChooseLocation> {

  int counter = 0;

  void getData() async {
    String username = await Future.delayed(Duration(seconds: 3), (){
      return "yoshi";
    });

    String bio = await Future.delayed(Duration(seconds: 2), (){
      return "game, fun, hapyy";
    });

    print("${username} - ${bio}");

  }
  
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    print("init run");
    getData();
  }

  @override
  Widget build(BuildContext context) {
    print("build run");
    return Scaffold(
      backgroundColor: Colors.grey[200],
      appBar: AppBar(
        title: Text("Choose Location"),
        centerTitle: true,
        backgroundColor: Colors.blue[900],
        elevation: 0,
      ),
      body: ElevatedButton(
        onPressed: (){
          setState(() {
            counter += 1;
          });
        },
        child: Text("counter ${counter}"),
      ),
    );
  }
}
