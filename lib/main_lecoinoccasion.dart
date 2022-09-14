import 'package:afariat/networking/firebase/push_notification/Messaging.dart';
import 'package:firebase_core/firebase_core.dart';

import '../config/app_config.dart';
import '../main_common.dart';
import 'package:flutter/material.dart';

import 'firebase_options_lecoinoccasion.dart';

void main() async {
  const envFile = '.env.lecoinoccasion.fr';
  await mainCommon(envFile);
  await Firebase.initializeApp(
          //name: 'lecoinoccasion',
          options: DefaultFirebaseOptions.currentPlatform);

  Messaging.registerNotification();

  var configuredApp = const AppConfig(
    appName: "lecoinoccasion.fr",
    appId: 2,
    child: MyApp(),
  );

  runApp(configuredApp);
}
