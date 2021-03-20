import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';

class notificationService {
  FirebaseMessaging messaging = FirebaseMessaging.instance;

  Future test() async {
    NotificationSettings settings = await messaging.requestPermission(
      alert: true,
      announcement: false,
      badge: true,
      carPlay: false,
      criticalAlert: false,
      provisional: false,
      sound: true,
    );

    if (settings.authorizationStatus == AuthorizationStatus.authorized) {
      print('User granted permission');
    } else if (settings.authorizationStatus ==
        AuthorizationStatus.provisional) {
      print('User granted provisional permission');
    } else {
      print('User declined or has not accepted permission');
    }
    print('User granted permission: ${settings.authorizationStatus}');
  }

  Future<void> firebaseMessagingBackgroundHandler() async {
    FirebaseMessaging.onMessage.listen((RemoteMessage message) {
      print('Got a m)ssage whilst in the foreground!');
      print('Message data: ${message.data}');

      if (message.notification != null) {
        print('Message also contained a notification: ${message.notification}');
        print("Handling a background message: ${message.messageId}");
      }
    });
    await Firebase.initializeApp();
  }
}
