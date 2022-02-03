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
  RefJson city;
  List<RefJson> towns = [];
  RefJson town;

  @override
  void onInit() {
    super.onInit();
    _cityApi.getList().then((value) {
      cities = value.data;
      // Inserez tout les villes index[0]

      cities.insert(0, RefJson(id: 0, name: "city"));
      update();
    });
  }

  clearData() {
    city = null;

    town = null;
    update();
  }

  updateCity(RefJson ci) {
    if (ci.id == 0) {
      if (Filter.data["city"] != null) {
        Filter.data.remove("city");
      }
      if (Filter.data["town"] != null) {
        Filter.data.remove("town");
      }

      tapHomeViewController.filterUpdate();
    } else {
      city = ci;
      tapPublishViewController.citie = ci;
      town = null;
      tapHomeViewController.setSearch("city", ci.id);
      tapPublishViewController.myAds["city"] = ci.id;
      tapPublishViewController.myAdsView["city"] = ci.name;
      updateTowns(ci.id);
      update();
    }
  }

  updatetown(RefJson town) {
    this.town = town;

    tapPublishViewController.town = town;
    tapHomeViewController.setSearch("town", town.id);
    tapPublishViewController.myAds["town"] = town.id;
    tapPublishViewController.myAdsView["town"] = town.name;
    update();
  }

  Future updateTowns(id) async {
    _townsApi.cityId = id.toString();
    await _townsApi.getList().then((value) {
      towns = value.data;
      update();
    });
  }

  updateCityAndTown() {
    city = null;
    tapPublishViewController.citie = null;
    tapPublishViewController.town = null;
    town = null;

    update();
  }
}
