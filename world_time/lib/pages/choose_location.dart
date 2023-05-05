import 'package:flutter/material.dart';

class ChooseLocation extends StatefulWidget {
  const ChooseLocation({Key? key}) : super(key: key);

  @override
  State<ChooseLocation> createState() => _ChooseLocationState();
}

class _ChooseLocationState extends State<ChooseLocation> {

  int counter = 0;
  
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    print("init run");
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
