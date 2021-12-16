import 'package:afariat/config/filter.dart';
import 'package:afariat/home/tap_home/tap_home_viewcontroller.dart';
import 'package:get/get.dart';
import 'package:afariat/networking/api/ref_api.dart';
import 'package:afariat/networking/json/ref_json.dart';

class LocController extends GetxController {
  final tapHomeViewController = Get.find<TapHomeViewController>();
  final CityApi _cityApi = CityApi();
  final TownApi _townsApi = TownApi();
  List<RefJson> cities = [];
  RefJson citie;
  List<RefJson> towns = [];
  RefJson town;

  @override
  void onInit() {
    super.onInit();
    _cityApi.getList().then((value) {
      cities = value.data;
      update();
    });
  }

  updatecitie(RefJson ci) {
    citie = ci;
    town = null;
    tapHomeViewController.setsearch("city", ci.id);
    updateTowns(ci.id.toString());
    update();
  }

  updatetown(RefJson tow) {
    town = tow;
    tapHomeViewController.setsearch("town", tow.id);
    update();
  }

  updateTowns(id) {
    Filter.Id = id.toString();
    _townsApi.getList().then((value) {
      towns = value.data;
      update();
      Filter.Id = null;
    });
  }
}
