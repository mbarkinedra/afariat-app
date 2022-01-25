import 'package:afariat/config/filter.dart';
import 'package:afariat/home/tap_home/tap_home_viewcontroller.dart';
import 'package:afariat/home/tap_publish/tap_publish_viewcontroller.dart';
import 'package:get/get.dart';
import 'package:afariat/networking/api/ref_api.dart';
import 'package:afariat/networking/json/ref_json.dart';

class LocController extends GetxController {
  final tapHomeViewController = Get.find<TapHomeViewController>();
  final tapPublishViewController = Get.find<TapPublishViewController>();
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

  clearData() {
    citie = null;

    town = null;
    update();
  }

  updatecitie(RefJson ci) {
    citie = ci;
    tapPublishViewController.citie = ci;
    town = null;
    tapHomeViewController.setsearch("city", ci.id);
    tapPublishViewController.myAds["city"] = ci.id;
    tapPublishViewController.myAdsview["city"] = ci.name;
    updateTowns(ci.id);
    update();
  }

  updatetown(RefJson town) {
    this.town = town;

    tapPublishViewController.town = town;
    tapHomeViewController.setsearch("town", town.id);
    tapPublishViewController.myAds["town"] = town.id;
    tapPublishViewController.myAdsview["town"] = town.name;
    update();
  }

  Future updateTowns(id) async {
    _townsApi.cityId = id.toString();
    await _townsApi.getList().then((value) {
      towns = value.data;
      update();
    });
  }

  updatecitieAndTowen() {
    citie = null;
    tapPublishViewController.citie = null;
    tapPublishViewController.town = null;
    town = null;

    update();
  }
}
