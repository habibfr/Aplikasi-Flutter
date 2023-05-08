import 'package:brew_project/models/brew.dart';
import 'package:brew_project/screens/home/settings_form.dart';
import 'package:brew_project/screens/services/auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import '../services/database.dart';
import 'package:provider/provider.dart';
import 'brew_list.dart';

class Home extends StatelessWidget {
  const Home({super.key});

  @override
  Widget build(BuildContext context) {
    final AuthService _auth = AuthService();

    void _showSettingPanel() {
      showModalBottomSheet(
          context: context,
          builder: (context) {
            return Container(
              padding: EdgeInsets.symmetric(vertical: 20.0, horizontal: 60),
              child: SettingsForm(),
            );
          });
    }

    return StreamProvider<List<Brew>?>.value(
      initialData: [],
      value: DatabaseService().brews,
      child: Scaffold(
        backgroundColor: Colors.brown[100],
        appBar: AppBar(
          backgroundColor: Colors.brown[400],
          title: Text('Brew crew'),
          elevation: 0.0,
          actions: <Widget>[
            TextButton.icon(
                onPressed: () async {
                  await _auth.userSignOut();
                },
                icon: Icon(
                  Icons.output_sharp,
                  color: Colors.white,
                ),
                label: Text(
                  'Logout',
                  style: TextStyle(color: Colors.white),
                )),
            TextButton.icon(
                onPressed: _showSettingPanel,
                icon: Icon(
                  Icons.settings,
                  color: Colors.white,
                ),
                label: Text(
                  "Setting",
                  style: TextStyle(color: Colors.white),
                ))
          ],
        ),
        body: BrewList(),
      ),
    );
  }
}
