import 'package:flutter/material.dart';

class NavigationDrawer extends StatelessWidget {
  const NavigationDrawer({super.key});

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            buildHeader(context),
            buildMenuItems(context),
          ],
        ),
      ),
    );
  }

  Widget buildHeader(BuildContext context) => Container(
        padding: EdgeInsets.all(24),
      );
  Widget buildMenuItems(BuildContext context) => Wrap(
        runSpacing: 16,
        children: [
          ListTile(
            leading: Icon(Icons.home_outlined),
            title: Text('Home'),
            // onTap: () => Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (context) =)),
          ),
          ListTile(
            leading: Icon(Icons.favorite_border),
            title: Text('Favourites'),
            onTap: () {},
          ),
          ListTile(
            leading: Icon(Icons.workspaces_outline),
            title: Text('Workflow'),
            onTap: () {},
          ),
          ListTile(
            leading: Icon(Icons.update),
            title: Text('Updates'),
            onTap: () {},
          ),
          Divider(
            color: Colors.black54,
          ),
          ListTile(
            leading: Icon(Icons.account_tree_outlined),
            title: Text('Pllugins'),
            onTap: () {},
          ),
          ListTile(
            leading: Icon(Icons.alarm_outlined),
            title: Text('Notifications'),
            onTap: () {},
          ),
        ],
      );
}
