import 'package:flutter/material.dart';
import 'package:http/http.dart';
import 'dart:convert';

class WorldTime{
  String location;
  String flag;
  String url;
  String time = "";

  WorldTime({required this.location, required this.flag, required this.url});

  Future<void> getTime() async {
    Response response = await get(Uri.parse('https://timeapi.io/api/Time/current/zone?timeZone=$url'));
    Map data = jsonDecode(response.body);
    // print(data);
    String dateTime = data['dateTime'];
    // print(dateTime);

    DateTime now = DateTime.parse(dateTime);

    time = now.toString();
  }
}

