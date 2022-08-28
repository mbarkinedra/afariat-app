import '../config/app_config.dart';
import '../main_common.dart';
import 'package:flutter/material.dart';

void main() async{

  const ENV_FILE='.env.lecoinoccasion.fr';

  await mainCommon(ENV_FILE);

  var configuredApp = AppConfig(
    appName: "lecoinoccasion.fr",
    appId: 2,
    child: MyApp(),
  );

  runApp(configuredApp);
}