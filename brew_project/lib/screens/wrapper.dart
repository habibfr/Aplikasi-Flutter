import 'package:brew_project/models/my_user.dart';
import 'package:brew_project/screens/authenticate/authenticate.dart';
import 'package:brew_project/screens/home/home.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:provider/provider.dart';

class Wrapper extends StatefulWidget {
  const Wrapper({super.key});

  @override
  State<Wrapper> createState() => _WrapperState();
}

class _WrapperState extends State<Wrapper> {
  @override
  Widget build(BuildContext context) {
    final user = Provider.of<MyUser?>(context);

    return Authenticate();
  }
}
