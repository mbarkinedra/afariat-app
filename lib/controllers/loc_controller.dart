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
  int index = 0;

  @override
  void onInit() {
    super.onInit();
    _cityApi.getList().then((value) {
      cities = value.data;

      cities.insert(0, RefJson(id: 0, name: ""));
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
      town = null;
      tapHomeViewController.filterUpdate();
    } else {
      city = ci;
      tapPublishViewController.citie = ci;
      town = null;
      tapHomeViewController.setSearch("city", ci.id);
      tapPublishViewController.myAds["city"] = ci.id;
      tapPublishViewController.myAdsView["city"] = ci.name;
      tapHomeViewController.searchAddLinke =
          tapHomeViewController.searchAddLinke + "city=${ci.id}&";

      updateTowns(ci.id);
      update();
    }
  }

  updateTown(RefJson town) {
    if (town.id == 0) {
      if (Filter.data["town"] != null) {
        Filter.data.remove("town");
      }
      town = null;
      tapHomeViewController.filterUpdate();
    } else {
      this.town = town;
      tapHomeViewController.searchAddLinke =
          tapHomeViewController.searchAddLinke + "town=${town.id}&";
      tapPublishViewController.town = town;
      tapHomeViewController.setSearch("town", town.id);
      tapPublishViewController.myAds["town"] = town.id;
      tapPublishViewController.myAdsView["town"] = town.name;
      update();
    }
  }

  Future updateTowns(id) async {
    _townsApi.cityId = id.toString();
    await _townsApi.getList().then((value) {
      towns = value.data;
      if (index == 0) {
        towns.insert(0, RefJson(id: 0, name: ""));
      }

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
