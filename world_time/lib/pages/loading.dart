import 'package:flutter/material.dart';
import 'package:http/http.dart';
import 'dart:convert';
import 'package:world_time/services/world_time.dart';

class Loading extends StatefulWidget {
  const Loading({Key? key}) : super(key: key);

  @override
  State<Loading> createState() => _LoadingState();
}

class _LoadingState extends State<Loading> {

  String time = "loading...";

  void setWorldTime() async{
    WorldTime instance = WorldTime(location: "Berlin", flag: "berlin.jpg", url: "Asia/Jakarta");
    await instance.getTime();

    setState(() {
      time = instance.time;
    });
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    setWorldTime();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: EdgeInsets.all(50.0),
        child: Text(
          time,
        ),
      )
    );
  }
}
