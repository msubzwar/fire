

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:notification/model/alerts.dart';
import 'package:notification/navbar.dart';

class Check extends StatelessWidget {
  CollectionReference users = FirebaseFirestore.instance.collection('Alerts');
  @override
  Widget build(BuildContext context) {
  return Scaffold(
    appBar: AppBar(
        backgroundColor: Color(0xFFBA0167),
        title: new Center(
          child: Text("Admin",textAlign: TextAlign.center,),
      ),
    ),
    endDrawer: navbar(),
    body:
      StreamBuilder<QuerySnapshot>(
      stream: users.snapshots(),
      builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
        if (snapshot.hasError) {
          return Text('Something went wrong');
        }
        if (snapshot.connectionState == ConnectionState.waiting) {
          return Text("Loading");
        }
        if (!snapshot.hasData) {
          return Text("No Data");
        }
        else {
          print("Testing");
          return new ListView(
            children: snapshot.data.docs.map((DocumentSnapshot document) {
              return new ListTile(
                title: new Text(document.data()["name"] + " | " + document.data()['building']),
                subtitle: new Text(document.data()['level']),
              );
            }).toList(),
          );
        }
      },
      ),
    );
  }
}