import 'package:afariat/config/utility.dart';
import 'package:animated_splash_screen/animated_splash_screen.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'bindings/bindings.dart';
import 'home/home_view.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await GetStorage.init();

  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      initialBinding: AllBindings(),
      theme: ThemeData(
        primaryColor: Colors.deepOrange,
        primarySwatch: Colors.deepOrange,
      ),
      home: AnimatedSplashScreen(
          duration: 3000,
          splashIconSize: 200,
          splash: Image.asset("assets/images/Splash_9.png"),
          nextScreen: HomeView(),
          splashTransition: SplashTransition.slideTransition,
          backgroundColor: framColor),
    );
  }
}
