import 'package:brew_project/screens/authenticate/register.dart';
import 'package:brew_project/screens/authenticate/sign_in.dart';
import 'package:flutter/material.dart';

class Authenticate extends StatefulWidget {
  const Authenticate({super.key});

  @override
  State<Authenticate> createState() => _AuthenticateState();
}

class _AuthenticateState extends State<Authenticate> {
  bool isLogin = true;

  void toggleView() {
    setState(() => isLogin = !isLogin);
  }

  @override
  Widget build(BuildContext context) {
    if (isLogin) {
      return SigIn(toggleView: toggleView);
    } else {
      return Register(toggleView: toggleView);
    }
  }
}
