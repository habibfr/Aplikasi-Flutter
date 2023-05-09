import 'package:brew_project/shared/constants.dart';
import 'package:flutter/material.dart';

class SettingsForm extends StatefulWidget {
  const SettingsForm({super.key});

  @override
  State<SettingsForm> createState() => _SettingsFormState();
}

class _SettingsFormState extends State<SettingsForm> {
  final _formKey = GlobalKey<FormState>();
  final List<String> sugars = ['1', "2", '3', '4', '5'];

  var _currentName = '';
  var _currentStrength = 100;
  var _currentSugars = "100";

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: Column(
        children: [
          Text("Setting your brew"),
          SizedBox(
            height: 20.0,
          ),
          TextFormField(
            decoration:
                inputDecoration.copyWith(label: Text('Name'), hintText: ""),
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
          DropdownButtonFormField<String>(
              decoration: inputDecoration.copyWith(label: Text("Sugar")),
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
            value: _currentStrength.toDouble(),
            min: 100.0,
            max: 900.0,
            divisions: 8,
            activeColor: Colors.brown[_currentStrength],
            inactiveColor: Colors.brown,
            onChanged: (value) {
              setState(() {
                _currentStrength = value.round();
              });
            },
          ),
          ElevatedButton(
              onPressed: () async {
                print(_currentName);
                print(_currentStrength);
                print(_currentSugars);
              },
              child: Text("Update"))
        ],
      ),
    );
  }
}
