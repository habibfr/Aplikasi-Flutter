import 'package:flutter/material.dart';
import 'package:world_time/services/world_time.dart';

class ChooseLocation extends StatefulWidget {
  const ChooseLocation({Key? key}) : super(key: key);

  @override
  State<ChooseLocation> createState() => _ChooseLocationState();
}

class _ChooseLocationState extends State<ChooseLocation> {
  int counter = 0;

  List<WorldTime> locations = [
    WorldTime(location: "Indonesia", flag: "id.png", url: "Asia/Jakarta"),
    WorldTime(location: "Cairo", flag: "eg.png", url: "Africa/Cairo"),
    WorldTime(location: "Madrid", flag: "es.png", url: "Europe/Madrid"),
    WorldTime(location: "London", flag: "gb.png", url: "Europe/London"),
    WorldTime(location: "Tokyo", flag: "jp.png", url: "Asia/Tokyo"),
    WorldTime(location: "Seoul", flag: "kr.png", url: "Asia/Seoul"),
    WorldTime(
        location: "Kuala Lumpur", flag: "my.png", url: "Asia/Kuala_Lumpur"),
    WorldTime(location: "Amsterdam", flag: "nl.png", url: "Europe/Amsterdam"),
    WorldTime(location: "Lisbon", flag: "pt.png", url: "Europe/Lisbon"),
    WorldTime(
        location: "Los Angeles", flag: "us.png", url: "America/Los_Angeles"),
  ];

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  void updateLocation(index) async {
    WorldTime instance = locations[index];
    await instance.getTime();

    Navigator.pop(context, {
      'location': instance.location,
      'time': instance.time,
      'flag': instance.flag,
      'isDayTime': instance.isDayTime
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.grey[200],
        appBar: AppBar(
          title: Text("Choose Location"),
          centerTitle: true,
          backgroundColor: Colors.blue[900],
          elevation: 0,
        ),
        body: ListView.builder(
          itemCount: locations.length,
          itemBuilder: (context, index) {
            return Padding(
              padding: EdgeInsets.symmetric(vertical: 1.0, horizontal: 4.0),
              child: Card(
                  color: Colors.grey[200],
                  child: ListTile(
                    onTap: () {
                      updateLocation(index);
                    },
                    leading: CircleAvatar(
                      backgroundImage:
                          AssetImage('assets/${locations[index].flag}'),
                    ),
                    title: Text(locations[index].location),
                  )),
            );
          },
        ));
  }
}
