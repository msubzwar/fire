import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:notification/FirstPage.dart';
import 'package:notification/notification.dart';
import 'auth_main.dart';

void main() async {
  final Future<FirebaseApp> _initialization =
  Firebase.initializeApp().whenComplete(() {
    notificationService ns = new notificationService();
    ns.test();
    ns.firebaseMessagingBackgroundHandler();
  });
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(AuthExampleApp());
}
