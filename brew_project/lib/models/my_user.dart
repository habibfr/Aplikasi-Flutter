import 'package:firebase_auth/firebase_auth.dart';

class MyUser {
  final String? uid;

  MyUser({this.uid});
}

class UserData {
  final String uid;
  final String name;
  final int strength;
  final String sugars;

  UserData(
      {required this.uid,
      required this.name,
      required this.strength,
      required this.sugars});
}
