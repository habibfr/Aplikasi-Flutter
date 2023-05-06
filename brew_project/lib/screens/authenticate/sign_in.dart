import 'package:brew_project/screens/services/auth.dart';
import 'package:flutter/material.dart';

class SigIn extends StatefulWidget {
  const SigIn({super.key});

  @override
  State<SigIn> createState() => _SigInState();
}

class _SigInState extends State<SigIn> {
  final AuthService _auth = AuthService();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.brown[100],
      appBar: AppBar(
        title: Text("Sign In"),
        elevation: 0.0,
        backgroundColor: Colors.brown[400],
      ),
      body: Container(
        padding: EdgeInsets.symmetric(vertical: 20.0, horizontal: 50.0),
        child: ElevatedButton(
          child: Text('Sign in anonim'),
          onPressed: () async {
            dynamic result = await _auth.signInAnonim();
            if (result == null) {
              print("error");
            } else {
              print("sign in");
              print(result);
            }
          },
          style: ElevatedButton.styleFrom(
            backgroundColor: Colors.brown[400],
          ),
        ),
      ),
    );
  }
}
