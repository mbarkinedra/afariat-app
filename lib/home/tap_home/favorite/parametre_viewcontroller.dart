import 'package:get/get_state_manager/src/simple/get_controllers.dart';

class ParametreViewContoller extends GetxController {
  bool lights = false;


  updateLight(v){
    lights=v;
    update();
  }
}