import 'package:afariat/model/filter.dart';
import 'package:get/get.dart';
import 'package:get/get_state_manager/src/simple/get_controllers.dart';

import '../networking/api/advert_api.dart';
import '../networking/json/adverts_json.dart';
import '../storage/AccountInfoStorage.dart';
import 'drawer_view_controller.dart';

class HomeViewController extends GetxController {
  DrawerViewController drawerController = DrawerViewController();
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
  }

  Future<AdvertListJson> fetchLastAds([int limit = 10]) async {
    isLoadingLastAds.value = true;
    try {
      _advertApi.url = '/api/v1/adverts?limit=' + limit.toString();
      await _advertApi.getList().then((value) {
        advertListJson = value;
      });
    } catch (error) {
      print(error);
    }
    isLoadingLastAds.value = false;

    return advertListJson;
  }

  selectCategory(id) {
    Filter.clearExcept(AccountInfoStorage.keyLocalization);
    Filter.set('category', id);
    print(Filter);
    Get.toNamed('/search');
  }
}
