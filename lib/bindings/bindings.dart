

import 'package:afariat/controllers/category_and_subcategory.dart';
import 'package:afariat/controllers/loc_controller.dart';
import 'package:afariat/home/home_view_controller.dart';
import 'package:afariat/home/tap_home/tap_home_viewcontroller.dart';
import 'package:get/get.dart';


class AllBindings extends Bindings{
  @override
  void dependencies() {
    // Get.put(() => Tab4Profile() );
    Get.lazyPut(() => TapHomeViewController() );
    Get.lazyPut(() => HomeViwController() ,fenix: true);

    Get.lazyPut(() => CategoryAndSubcategory() ,fenix: true);
    Get.lazyPut(() => LocController() ,fenix: true);


  }

}