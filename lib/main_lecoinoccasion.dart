import '../config/app_config.dart';
import '../main_common.dart';
import 'package:flutter/material.dart';

void main() async{

  const envFile='.env.lecoinoccasion.fr';

  await mainCommon(envFile);

  var configuredApp = const AppConfig(
    appName: "lecoinoccasion.fr",
    appId: 2,
    child: MyApp(),
  );

  runApp(configuredApp);
}