import 'package:flutter/material.dart';
import 'package:kantin/shared/app_style.dart';
import 'package:kantin/sql/sql_helper.dart';
import 'package:kantin/ui/home_page.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final TextEditingController _usernameController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  List<Map<String, dynamic>> _users = [];

  void _refreshUsers() async {
    final data = await SQLHelper.getUsers();

    setState(() {
      _users = data;
      // _isLoading = false;
    });

    print(_users);
  }

  Future<void> _addUser() async {
    await SQLHelper.createUser(
        _usernameController.text, _passwordController.text);
    ScaffoldMessenger.of(context)
        .showSnackBar(SnackBar(content: Text('Successfully add a user')));
    _refreshUsers();
  }

  bool _login(String username, String password) {
    // if (id != null) {
    final dataUser = _users.firstWhere((element) =>
        (element['username'] == username) && (element['password'] == password));

    if ((dataUser['username'] != _usernameController.text) &&
        (dataUser['password'] != _passwordController.text)) {
      return false;
    } else {
      return true;
    }
  }

  @override
  void initState() {
    super.initState();
    _refreshUsers();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      resizeToAvoidBottomInset: false,
      body: Padding(
        padding: EdgeInsets.symmetric(vertical: 120, horizontal: 40),
        child: Container(
          padding: EdgeInsets.all(50),
          decoration: BoxDecoration(
            border: Border.all(color: Colors.red),
          ),
          child: Center(
              child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "M-Kantin",
                style: appStyle(40, Colors.black, FontWeight.bold),
              ),

              Text(
                "Food Court Menara Satu Piza",
                style: appStyle(20, Colors.black, FontWeight.bold),
              ),
              SizedBox(
                height: 40,
              ),
              Padding(
                padding: const EdgeInsets.all(0),
                child: Text(
                  "Welcome to Modern Kantin",
                  style: appStyle(
                      16, Color.fromARGB(255, 15, 5, 5), FontWeight.normal),
                ),
              ),

              SizedBox(
                height: 30,
              ),

              SizedBox(
                height: 50,
                child: TextField(
                  controller: _usernameController,
                  decoration: InputDecoration(
                    hintText: 'username',
                    focusedBorder: UnderlineInputBorder(
                      borderSide: BorderSide(color: Colors.red),
                    ),
                  ),
                ),
              ),
              const SizedBox(
                height: 10,
              ),
              TextField(
                controller: _passwordController,
                decoration: InputDecoration(
                  hintText: 'password',
                  focusedBorder: UnderlineInputBorder(
                    borderSide: BorderSide(color: Colors.red),
                  ),
                ),
              ),
              // ignore: prefer_const_constructors
              SizedBox(
                height: 10,
              ),

              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  ElevatedButton(
                    onPressed: () async {
                      try {
                        bool result = await _login(
                            _usernameController.text, _passwordController.text);
                        if (result) {
                          Navigator.pushReplacement(
                              context,
                              MaterialPageRoute(
                                builder: (context) => HomePage(
                                    username: _usernameController.text),
                              ));
                        }
                      } catch (e) {
                        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                            content: Text(
                                'Failed login, username or password wrong!')));
                      }

                      _usernameController.text = '';
                      _passwordController.text = '';
                    },
                    style:
                        ElevatedButton.styleFrom(backgroundColor: Colors.red),
                    child: Text("Login"),
                  ),
                  SizedBox(
                    width: 20,
                  ),
                  ElevatedButton(
                    onPressed: () async {
                      try {
                        _addUser();
                      } catch (e) {
                        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                            content: Text(
                                'Failed login, username or password wrong!')));
                      }

                      _usernameController.text = '';
                      _passwordController.text = '';
                    },
                    style:
                        ElevatedButton.styleFrom(backgroundColor: Colors.green),
                    child: Text("Sign Up"),
                  ),
                ],
              ),
            ],
          )),
        ),
      ),
    );
  }
}
