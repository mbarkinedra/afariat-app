import 'package:afariat/controllers/category_and_subcategory.dart';
import 'package:afariat/controllers/loc_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class TapPublishViewController extends GetxController {
  final categoryAndSubcategory =Get.find<CategoryAndSubcategory>();
  final locController =Get.find<LocController>();

  TextEditingController title=TextEditingController();
  TextEditingController description=TextEditingController();
  TextEditingController price=TextEditingController();

  bool  lights = false;
  List<Widget> radiolist = [];


updatLight(v){
  lights=v;
  update();
}
}