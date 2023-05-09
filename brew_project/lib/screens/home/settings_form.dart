import 'package:brew_project/models/my_user.dart';
import 'package:brew_project/screens/services/database.dart';
import 'package:brew_project/shared/constants.dart';
import 'package:brew_project/shared/loading.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:brew_project/screens/services/database.dart';

class SettingsForm extends StatefulWidget {
  const SettingsForm({super.key});

  @override
  State<SettingsForm> createState() => _SettingsFormState();
}

class _SettingsFormState extends State<SettingsForm> {
  final _formKey = GlobalKey<FormState>();
  final List<String> sugars = ['0', '1', "2", '3', '4', '5'];

  final List<String> newSugars = ['1', "2", '3', '4', '5'];

  var _currentName;
  var _currentStrength = 100.0;
  var _currentSugars;

  @override
  Widget build(BuildContext context) {
    final user = Provider.of<MyUser>(context);
    // print(user.uid);

    return StreamBuilder<UserData>(
        stream: DatabaseService(uid: user?.uid).userData,
        builder: (context, snapshot) {
          // print(snapshot.hasData);
          if (snapshot.hasData) {
            UserData userData = snapshot.data!;
            // print(userData);
            return Form(
              key: _formKey,
              child: Column(
                children: [
                  Text("Setting your brew"),
                  SizedBox(
                    height: 20.0,
                  ),
                  TextFormField(
                    initialValue: userData.name,
                    decoration: inputDecoration.copyWith(
                        label: Text('Name'), hintText: ""),
                    validator: (value) =>
                        value!.isEmpty ? "please input name value" : null,
                    onChanged: (value) {
                      setState(() {
                        _currentName = value;
                      });
                    },
                  ),
                  SizedBox(
                    height: 20.0,
                  ),
                  DropdownButtonFormField(
                      decoration:
                          inputDecoration.copyWith(label: Text("Sugar")),
                      value: _currentSugars ?? userData.sugars,
                      items: sugars.map((sugar) {
                        return DropdownMenuItem(
                            value: sugar, child: Text('$sugar sugar'));
                      }).toList(),
                      onChanged: (value) {
                        setState(() {
                          _currentSugars = value!;
                        });
                      }),
                  SizedBox(height: 20.0),
                  Slider(
                    activeColor: Colors
                        .brown[_currentStrength.round() ?? userData.strength],
                    inactiveColor: Colors.brown,
                    min: 100.0,
                    max: 900.0,
                    onChanged: (newRating) {
                      setState(() => _currentStrength = newRating);
                    },
                    divisions: 8,
                    value: _currentStrength ?? userData.strength.toDouble(),
                    label: _currentStrength.round().toString(),
                  ),
                  ElevatedButton(
                      onPressed: () async {
                        if (_formKey.currentState!.validate()) {
                          await DatabaseService(uid: user!.uid).updateUser(
                              _currentSugars ?? userData.sugars,
                              _currentName ?? userData.name,
                              _currentStrength.toInt() ?? userData.strength);
                          Navigator.pop(context);
                        }
                      },
                      child: Text("Update"))
                ],
              ),
            );
          } else {
            return Loading();
          }
        });
  }
}
