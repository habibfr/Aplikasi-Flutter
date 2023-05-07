import 'package:brew_project/screens/services/auth.dart';
import 'package:flutter/material.dart';

class SigIn extends StatefulWidget {
  final toggleView;
  const SigIn({super.key, this.toggleView});

  @override
  State<SigIn> createState() => _SigInState();
}

class _SigInState extends State<SigIn> {
  final AuthService _auth = AuthService();

  String email = '';
  String password = "";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.brown[100],
        appBar: AppBar(
          title: Text("Sign In"),
          elevation: 0.0,
          backgroundColor: Colors.brown[400],
          actions: [
            TextButton.icon(
                onPressed: () {
                  setState(() {
                    widget.toggleView();
                  });
                },
                icon: Icon(Icons.person_add_alt_1),
                label: Text("Register"))
          ],
        ),
        body: Container(
          padding: EdgeInsets.fromLTRB(20.0, 10.0, 20.0, 0.0),
          child: Form(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: <Widget>[
                SizedBox(
                  height: 20.0,
                ),
                Text("email : "),
                TextFormField(
                  onChanged: (value) {
                    setState(() {
                      email = value;
                    });
                  },
                ),
                SizedBox(
                  height: 20.0,
                ),
                Text("Password : "),
                TextFormField(
                  obscureText: true,
                  onChanged: (value) {
                    setState(() {
                      password = value;
                    });
                  },
                ),
                SizedBox(
                  height: 20.0,
                ),
                ElevatedButton(
                    onPressed: () async {
                      print(email);
                      print(password);
                    },
                    child: Text("Sign in"))
              ],
            ),
          ),
        ));
  }
}
