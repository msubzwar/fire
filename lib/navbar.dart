import 'package:flutter/material.dart';
import 'package:notification/check.dart';

class navbar extends StatelessWidget {
  String username = "asd";
  String email = "asx@gma";

  @override
  Widget build(BuildContext context) {
    return Drawer(
        child: ListView(
      children: [
        UserAccountsDrawerHeader(
          accountName: Text(username),
          accountEmail: Text("Username@xyz.com"),
          currentAccountPicture: CircleAvatar(
            child: ClipOval(
              child: Icon(Icons.account_circle),
            ),
          ),
          decoration: BoxDecoration(
            color: Colors.blueGrey,
          ),
        ),
        ListTile(
          leading: Icon(Icons.favorite),
          title: Text("Notification"),
          onTap: () => null,
        ),
        ListTile(
          leading: Icon(Icons.favorite),
          title: Text("Past Alerts"),
          onTap: () => null,
        ),
        ListTile(
          leading: Icon(Icons.settings),
          title: Text("Buildings"),
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => Check(),
              ),
            );
          },
        ),
      ],
    ));
  }
}
