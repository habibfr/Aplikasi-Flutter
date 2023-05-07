import 'package:brew_project/screens/services/auth.dart';
import 'package:brew_project/shared/loading.dart';
import 'package:flutter/material.dart';
import '../../shared/constants.dart';

class SigIn extends StatefulWidget {
  final toggleView;
  const SigIn({super.key, this.toggleView});

  @override
  State<SigIn> createState() => _SigInState();
}

class _SigInState extends State<SigIn> {
  final AuthService _auth = AuthService();
  final _formKey = GlobalKey<FormState>();

  String email = '';
  String password = "";
  String error = '';
  bool loading = false;

  @override
  Widget build(BuildContext context) {
    return loading
        ? Loading()
        : Scaffold(
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
                      validator: (value) =>
                          (value!.isEmpty || !value.contains("@"))
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
                      validator: (value) =>
                          value!.length < 6 || value.contains(" ")
                              ? "password not valid, min 6 char"
                              : null,
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
                          if (_formKey.currentState!.validate()) {
                            setState(() {
                              loading = true;
                            });
                            dynamic result = await _auth
                                .signInWithEmailAndPassword(email, password);
                            if (result == null) {
                              setState(() {
                                error =
                                    "login fail, please fill field a valid value";
                                loading = false;
                              });
                            }
                          }
                        },
                        child: Text("Sign in")),
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
