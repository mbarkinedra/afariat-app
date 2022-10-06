import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';

import '../../../home/tap_profile/notification/notification_view.dart';

Future<void> _firebaseMessagingBackgroundHandler(RemoteMessage message) async {
  if (kDebugMode) {
    print("Handling a background message: ${message.messageId}");
  }
}

class PushNotification {
  PushNotification({
    this.title,
    this.body,
  });

  String title;
  String body;
}

class Messaging {
  static String token;

  static void registerNotification() async {
    FirebaseMessaging _messaging = FirebaseMessaging.instance;
    if (kDebugMode) {
      print('start register messages for app: ' +
          _messaging.app.options.projectId);
    }
    if (kDebugMode) {
      print("APP: " + _messaging.app.toString());
      print(_messaging.app.options);
    }
    _messaging.getToken().then((token) {
      Messaging.token = token;
      if (kDebugMode) {
        print("Firebase Token: " + Messaging.token);
      }
    });
    // ARegister the background
    FirebaseMessaging.onBackgroundMessage(_firebaseMessagingBackgroundHandler);

    // 3. On iOS, this helps to take the user permissions
    NotificationSettings settings = await _messaging.requestPermission(
      alert: true,
      badge: true,
      provisional: false,
      sound: true,
    );

    if (settings.authorizationStatus == AuthorizationStatus.authorized) {
      if (kDebugMode) {
        print('User granted permission');
      }

      // For handling the received notifications
      FirebaseMessaging.onMessage.listen((RemoteMessage message) {
        // Parse the message received
        PushNotification notification = PushNotification(
          title: message.notification?.title,
          body: message.notification?.body,
        );

        if (kDebugMode) {
          print('Notification title: ' + message.notification.title);
          print('Notification Body: ' + message.notification.body);
          print('Notification image URL: ' +
              message.notification.android.imageUrl);
          print('Message ID: ' + message.messageId);
          print('Message DATA: ' + message.data.toString());
        }

        //update the notifcation count in profile's notifications
        // show a notification in snackbar
        Get.snackbar(notification.title, notification.body,
            colorText: Colors.white,
            backgroundColor: Colors.teal.shade700,
            duration: const Duration(seconds: 3));
      });

      // For handling notification when the app is in background
      // but not terminated
      FirebaseMessaging.onMessageOpenedApp.listen((RemoteMessage message) {
        PushNotification notification = PushNotification(
          title: message.notification?.title,
          body: message.notification?.body,
        );
        //open the notification page
        // TODO: insert the notification inside the notification src if offline mode ?
        Get.to(() => NotificationView());
      });
    } else if (settings.authorizationStatus ==
        AuthorizationStatus.provisional) {
      if (kDebugMode) {
        print('User granted provisional permission');
      }
    } else {
      if (kDebugMode) {
        print('User declined or has not accepted permission');
      }
    }
  }
}
