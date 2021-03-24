import 'package:flutter/material.dart';

class navbar extends StatelessWidget{

  @override
  Widget build(BuildContext context){
    return Drawer(
      child: ListView(
        children: [
          UserAccountsDrawerHeader(
              accountName: Text("UserName"),
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
            onTap: ()=>null,
          ),
          ListTile(
            leading: Icon(Icons.favorite),
            title: Text("Past Alerts"),
            onTap: ()=>null,
          ),
          ListTile(
            leading: Icon(Icons.settings),
            title: Text("Setting"),
            onTap: ()=>null,
          ),
        ],
      )

    );
  }
}