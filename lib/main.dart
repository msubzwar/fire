import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:notification/FirstPage.dart';
import 'package:notification/notification.dart';

void main() {
  final Future<FirebaseApp> _initialization =
  Firebase.initializeApp().whenComplete(() {
    notificationService ns = new notificationService();
    ns.test();
    ns.firebaseMessagingBackgroundHandler();
  });
  runApp(MyApp());
}
