import 'package:afariat/home/tap_publish/tap_publish_viewcontroller.dart';
import 'package:get/get.dart';
import 'package:afariat/networking/api/ref_api.dart';
import 'package:afariat/networking/json/ref_json.dart';
import 'package:afariat/model/filter.dart';
import '../networking/network.dart';

class LocController extends GetxController {
  //final tapHomeViewController = Get.find<TapHomeViewController>();
  final tapPublishViewController = Get.find<TapPublishViewController>();
  final CityApi _cityApi = CityApi();
  final TownApi _townsApi = TownApi();
  List<RefJson> cities = [];
  RefJson city;
  List<RefJson> towns = [];
  RefJson town;
  int index = 0;
  bool getCity = true;

  @override
  Future<void> onInit() async {
    super.onInit();
    await getCityListSelected();
  }

  /// GET all data from api
  getCityListSelected() {
    if (Network.status.value) {
      _cityApi.getList().then((value) {
        cities = value.data;

        cities.insert(0, RefJson(id: 0, name: ""));
        towns = [];
        town = null;
        getCity = false;
        update();
      });
    }
  }

  /// Update city from dropDown
  updateCity(RefJson selectedCity) {
    city = selectedCity;

    if (selectedCity.id == 0) {
      Filter.remove("city");
      Filter.remove("town");
      town = null;
      update();
    } else {
      city = selectedCity;
      Filter.set("city", selectedCity.id);
      tapPublishViewController.citie = selectedCity;
      town = null;
      tapPublishViewController.myAds["city"] = selectedCity.id;
      tapPublishViewController.myAdsView["city"] = selectedCity.name;
      getTowListSelected(selectedCity.id);
      update();
    }
  }

  /// Update city from dropDown
  updateTown(RefJson town) {
    if (town.id == 0) {
      Filter.remove("town");
      town = null;
      update();
    } else {
      Filter.set("town", town.id);
      this.town = town;
      tapPublishViewController.town = town;
      tapPublishViewController.myAds["town"] = town.id;
      tapPublishViewController.myAdsView["town"] = town.name;
      update();
    }
  }

  // Get all data of twon from api
  Future getTowListSelected(id) async {
    tapPublishViewController.town = null;
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

  /// Clear all data of city and twon (EXP:lorsque on cliq sur l icone + de publir l annonce data de city et town sont supprimées)
  clearDataCityAndTown() {
    city = null;
    town = null;
    update();
  }
}
