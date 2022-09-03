import '../config/app_config.dart';
import '../main_common.dart';
import 'package:flutter/material.dart';

void main() async {
  const envFile='.env.afariat.com';

  await mainCommon(envFile);

  var configuredApp = const AppConfig(
    appName: "afariat.com",
    appId: 1,
    child: MyApp(),
  );

  runApp(configuredApp);
}