import 'package:flutter/material.dart';
import 'package:http/http.dart';
import 'dart:convert';

class Loading extends StatefulWidget {
  const Loading({Key? key}) : super(key: key);

  @override
  State<Loading> createState() => _LoadingState();
}

class _LoadingState extends State<Loading> {

  void getTime() async {
    Response response = await get(Uri.parse('https://timeapi.io/api/Time/current/zone?timeZone=Asia/jakarta'));
    Map data = jsonDecode(response.body);
    print(data);
    String dateTime = data['dateTime'];
    print(dateTime);

    DateTime now = DateTime.parse(dateTime);
    print(now);

  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getTime();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Text("loading"),
    );
  }
}
