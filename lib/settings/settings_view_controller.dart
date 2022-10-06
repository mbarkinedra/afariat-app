import 'package:get/get_state_manager/src/simple/get_controllers.dart';

class SettingsViewController extends GetxController {
  bool lights = false;

  updateLight(v){
    lights=v;
    update();
  }
}