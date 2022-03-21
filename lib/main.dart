import 'package:animated_splash_screen/animated_splash_screen.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'bindings/bindings.dart';
import 'controllers/network_controller.dart';
import 'home/home_view.dart';


void main() async {
  await GetStorage.init();
  WidgetsFlutterBinding.ensureInitialized();

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key key}) : super(key: key);

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
          splash: Image.asset("assets/images/Splash_1.png"),
          nextScreen: Home(),//
          splashTransition: SplashTransition.slideTransition,
          //   pageTransitionType: PageTransitionType.,
          backgroundColor: Colors.deepOrange),
    );
  }
}
