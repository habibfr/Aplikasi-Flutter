import 'package:flutter/material.dart';

import '../services/auth.dart';
import "../../shared/constants.dart";

class Register extends StatefulWidget {
  final toggleView;
  const Register({super.key, this.toggleView});

  @override
  State<Register> createState() => _RegisterState();
}

class _RegisterState extends State<Register> {
  final AuthService _auth = AuthService();
  final _formKey = GlobalKey<FormState>();

  String email = '';
  String password = "";
  String error = '';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.brown[100],
        appBar: AppBar(
            title: Text("Sign Up"),
            elevation: 0.0,
            backgroundColor: Colors.brown[400],
            actions: [
              TextButton.icon(
                  onPressed: () {
                    widget.toggleView();
                  },
                  icon: Icon(Icons.person),
                  label: Text("Login"))
            ]),
        body: Container(
          padding: EdgeInsets.fromLTRB(20.0, 10.0, 20.0, 0.0),
          child: Form(
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: <Widget>[
                SizedBox(
                  height: 20.0,
                ),
                TextFormField(
                  decoration: inputDecoration.copyWith(
                    label: Text("Email"),
                    hintText: "habib@gmail.com",
                  ),
                  validator: (value) => (value!.isEmpty || !value.contains("@"))
                      ? "email not valid"
                      : null,
                  onChanged: (value) {
                    setState(() {
                      email = value;
                    });
                  },
                ),
                SizedBox(
                  height: 20.0,
                ),
                TextFormField(
                  decoration: inputDecoration,
                  obscureText: true,
                  validator: (value) => value!.length < 6 || value.contains(" ")
                      ? "password not valid, min 6 char"
                      : null,
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
                    child: Text("Register"),
                    onPressed: () async {
                      if (_formKey.currentState!.validate()) {
                        dynamic result = await _auth
                            .registerWithEmailAndPassword(email, password);
                        if (result == null) {
                          setState(() {
                            error =
                                "register fail, please fill field a valid value";
                          });
                        }
                      }
                    }),
                SizedBox(
                  height: 12.0,
                ),
                Text(
                  error,
                  style: TextStyle(color: Colors.redAccent),
                )
              ],
            ),
          ),
        ));
  }
}
