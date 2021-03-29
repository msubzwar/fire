


import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';

class Alerts{
  String event;
  String building;
  String level;

  Alerts(@required this.event, @required this.level, @required this.building);

  CollectionReference alerts = FirebaseFirestore.instance.collection("Alerts");
  Future<void> addAlert(){
    return alerts.add(
      {
        'name': this.event,
        'building': this.building,
        'level': this.level
      }
    );
  }

  void addALertToDB(){
    print("Addedd to db");
  }
}