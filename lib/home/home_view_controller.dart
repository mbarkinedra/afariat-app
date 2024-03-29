import 'package:afariat/config/app_routing.dart';
import 'package:afariat/home/tap_profile/notification/notification_view_controller.dart';
import 'package:afariat/model/filter.dart';
import 'package:flutter/foundation.dart';
import 'package:get/get.dart';

import '../networking/api/advert_api.dart';
import '../networking/json/advert_list_json.dart';
import '../networking/json/categories_grouped_json.dart';
import '../storage/AccountInfoStorage.dart';
import 'drawer_view_controller.dart';

class HomeViewController extends GetxController {
  DrawerViewController drawerController = DrawerViewController();
  NotificationViewController notificationController =
      Get.find<NotificationViewController>();
  AdvertListJson advertListJson = AdvertListJson();

  final AdvertApi _advertApi = AdvertApi();
  RxBool isLoadingLastAds = false.obs;
  List<dynamic> topCategories = [
    {'id': 8, 'label': 'Ameublement', 'image': 'canapé.webp'},
    {'id': 24, 'label': 'Téléphonie', 'image': 'iphone.webp'},
    {'id': 11, 'label': 'Vêtements', 'image': 'clothes.webp'},
    {'id': 1, 'label': 'Voitures', 'image': 'cars.webp'},
    {'id': 7, 'label': 'Electroménager', 'image': 'cuisine.webp'},
    {'id': 26, 'label': 'Informatique', 'image': 'mac.webp'},
    {'id': 19, 'label': 'Livres', 'image': 'books.webp'},
  ];

  @override
  Future<void> onInit() async {
    super.onInit();
    //init filter from storage
    await Filter.loadFromStorage();
  }

  Future<AdvertListJson> fetchLastAds([int limit = 10]) async {
    isLoadingLastAds.value = true;
    try {
      _advertApi.url =
          '/api/v1/adverts?onlyPhoto=true&limit=' + limit.toString();
      await _advertApi.getList().then((value) {
        advertListJson = value;
      });
    } catch (error) {
      if (kDebugMode) {
        print(error);
      }
    }
    isLoadingLastAds.value = false;
    return advertListJson;
  }

  selectCategory(id) {


    dynamic selectedCategory =
        topCategories.firstWhereOrNull((element) => element['id'] == id);

    if (selectedCategory != null) {
      Filter.clear(exceptLocalization: true);
      Filter.category.value =
          SubCategoryJson(id: id, name: selectedCategory['label']);
    }
    Get.toNamed(AppRouting.search);
  }
}
