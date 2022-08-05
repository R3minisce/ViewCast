import 'package:flutter/material.dart';

class Menu extends StatelessWidget {
  const Menu({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Expanded(
      flex: 1,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: const [
          SizedBox(
            width: 40,
            height: 40,
          ),
          ButonCustom(),
          SizedBox(
            width: 40,
            height: 40,
          ),
          Text(
            "ViewCast",
            style: TextStyle(color: Colors.black, fontSize: 20.0),
          ),
        ],
      ),
    );
  }
}

class ButonCustom extends StatelessWidget {
  const ButonCustom({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return IconButton(
      onPressed: () {
        Scaffold.of(context).openDrawer();
      },
      icon: const Icon(
        Icons.menu,
        color: Colors.black,
      ),
    );
  }
}

class CustomDrawer extends StatelessWidget {
  const CustomDrawer({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Drawer(
      // Add a ListView to the drawer. This ensures the user can scroll
      // through the options in the drawer if there isn't enough vertical
      // space to fit everything.
      child: ListView(
        // Important: Remove any padding from the ListView.
        padding: EdgeInsets.zero,
        children: [
          DrawerHeader(
            decoration: BoxDecoration(
              color: Colors.white.withOpacity(0),
            ),
            child: const Text(""),
          ),
          ListTile(
            title: const Text("dashboard"),
            onTap: () {
              Navigator.pushNamed(context, '/dashboard');
            },
          ),
          ListTile(
            title: const Text('live stream'),
            onTap: () {
              Navigator.pushNamed(context, '/live');
            },
          ),
          ListTile(
            title: const Text('users management'),
            onTap: () {
              Navigator.pushNamed(context, '/usermgmt');
            },
          ),
          ListTile(
            title: const Text('groups management'),
            onTap: () {
              Navigator.pushNamed(context, '/groupmgmt');
            },
          ),
          ListTile(
            title: const Text('topics management'),
            onTap: () {
              Navigator.pushNamed(context, '/topicmgmt');
            },
          ),
          ListTile(
            title: const Text('logout'),
            onTap: () {
              Navigator.pushNamed(context, '/');
            },
          ),
        ],
      ),
    );
  }
}
