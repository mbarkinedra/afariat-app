import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'bindings/bindings.dart';
import 'home/home_view.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key  key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp( debugShowCheckedModeBanner: false, initialBinding: AllBindings(),

      theme: ThemeData(

        primarySwatch: Colors.orange,
      ),
      home:    Home(),
    );
  }
}


