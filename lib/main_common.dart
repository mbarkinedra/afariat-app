import 'package:afariat/config/app_routing.dart';
import 'package:afariat/config/utility.dart';
import 'package:animated_splash_screen/animated_splash_screen.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'bindings/bindings.dart';
import 'config/app_config.dart';
import 'home/main_view.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';

Future<void> mainCommon(String fileEnv) async {
  // Here would be background init code, if any
  WidgetsFlutterBinding.ensureInitialized();
  await dotenv.load(fileName: fileEnv);
  await GetStorage.init();
}

class MyApp extends StatelessWidget {
  const MyApp({Key key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    var appConfig = AppConfig.of(context);
    return GestureDetector(
        onTap: () {
          FocusManager.instance.primaryFocus?.unfocus();
        },
        child: GetMaterialApp(
          debugShowCheckedModeBanner: false,
          initialBinding: AllBindings(),
          theme: ThemeData(
            primaryColor: Colors.deepOrange,
            primarySwatch: Colors.deepOrange,
          ),
          home: AnimatedSplashScreen(
              duration: 3000,
              splashIconSize: 130,
              splash: Image.asset(
                  "assets/images/" + appConfig.appName + "/splash.png"),
              nextScreen: const MainView(),
              splashTransition: SplashTransition.slideTransition,
              backgroundColor: framColor
          ),
          getPages: AppRouting.pages,
          //routes: AppRouting.routes,
        ),
    );
  }
}
