import 'package:firebase_core/firebase_core.dart';

import '../config/app_config.dart';
import '../main_common.dart';
import 'package:flutter/material.dart';

import 'firebase_options_afariat.dart';
import 'networking/firebase/push_notification/Messaging.dart';

void main() async {
  const envFile='.env.afariat.com';
  await mainCommon(envFile);
  await Firebase.initializeApp(
      options: DefaultFirebaseOptions.currentPlatform);
  Messaging.registerNotification();

  var configuredApp = const AppConfig(
    appName: "afariat.com",
    appId: 1,
    child: MyApp(),
  );

  runApp(configuredApp);
}