import 'package:flutter/material.dart';
import 'package:http/http.dart';
import 'dart:convert';
import 'package:intl/intl.dart';

class WorldTime{
  String location;
  String flag;
  String url;
  String time = "";

  WorldTime({required this.location, required this.flag, required this.url});


  Future<void> getTime() async {

    try{
      Response response = await get(Uri.parse('https://timeapi.io/api/Time/current/zone?timeZone=$url'));
      Map data = jsonDecode(response.body);

      String dateTime = data['dateTime'];

      DateTime now = DateTime.parse(dateTime);


      time = DateFormat.jm().format(now);
    }catch(e){
      time = "could not get time data!";
    }


  }
}

