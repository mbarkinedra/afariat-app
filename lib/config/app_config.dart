import 'package:flutter/material.dart';

class AppConfig extends InheritedWidget {
  AppConfig({this.appName,this.appId,
    Widget child}):super(child: child);

  final String appName;
  final int appId;

  static AppConfig of(BuildContext context) {
    return context.dependOnInheritedWidgetOfExactType<AppConfig>();
  }

  @override
  bool updateShouldNotify(InheritedWidget oldWidget) => false;

}