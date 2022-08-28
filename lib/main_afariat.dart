import '../config/app_config.dart';
import '../main_common.dart';
import 'package:flutter/material.dart';

void main() async {
  const ENV_FILE='.env.afariat.com';

  await mainCommon(ENV_FILE);

  var configuredApp = AppConfig(
    appName: "afariat.com",
    appId: 1,
    child: MyApp(),
  );

  runApp(configuredApp);
}