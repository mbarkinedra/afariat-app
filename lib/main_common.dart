import 'package:afariat/config/utility.dart';
import 'package:animated_splash_screen/animated_splash_screen.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'bindings/bindings.dart';
import 'config/app_config.dart';
import 'home/home_view.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';

void mainCommon(String FileEnv) async {
  // Here would be background init code, if any
  WidgetsFlutterBinding.ensureInitialized();
  await dotenv.load(fileName: FileEnv);
  await GetStorage.init();
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    var appConfig = AppConfig.of(context);
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      initialBinding: AllBindings(),
      theme: ThemeData(
        primaryColor: Colors.deepOrange,
        primarySwatch: Colors.deepOrange,
      ),
      home: AnimatedSplashScreen(
          duration: 3000,
          splashIconSize: 130,
          splash: Image.asset("assets/images/"+appConfig.appName+"/splash.png"),
          nextScreen: HomeView(),
          splashTransition: SplashTransition.slideTransition,
          backgroundColor: framColor),
    );
  }
}
