import 'package:afariat/networking/api/delete_favorite.dart';
import 'package:afariat/networking/api/delete_favoriteByAdvert_api.dart';
import 'package:afariat/networking/api/favorite_api.dart';
import 'package:afariat/networking/json/favorite_json.dart';
import 'package:get/get.dart';
import 'package:get/get_state_manager/src/simple/get_controllers.dart';

import '../tap_home_viewcontroller.dart';

class FavoriteViewController extends GetxController {
  FavoriteApi _favoriteApi = FavoriteApi();
  DeleteFavoriteApi _deleteFavoriteApi = DeleteFavoriteApi();
  DeleteFavoriteByAdvert _deleteFavoriteByAdvert = DeleteFavoriteByAdvert();

  FavoriteJson favoriteJson;
  int idItemDelete;

  @override
  void onInit() {
    super.onInit();
    getFavorite();
  }

  ///Add favovorite advert from homescrenn and advertDetails
  addToMyFavorite(id) {
    _favoriteApi.securePost(dataToPost: {"id": id}).then((value) {
      getFavorite();
    });
  }

  ///get List of favorite adverts
  Future getFavorite() async {
    await _favoriteApi.secureGet().then((value) {
      Get.find<TapHomeViewController>().favorites.clear();
      favoriteJson = FavoriteJson.fromJson(value.data);
      favoriteJson.eEmbedded.favorites.forEach((element) {
        Get.find<TapHomeViewController>().favorites.add(element.advert.id);
      });
      Get.find<TapHomeViewController>().update();
    });
    update();
  }

  /// Delete Favorite by advert
  deleteFavoriteByAdvert(int id) async {
    _deleteFavoriteByAdvert.IdAdvert = id.toString();
    Get.find<TapHomeViewController>().favorites.remove(id);
    await _deleteFavoriteByAdvert.deleteData().then((value) {
      getFavorite();
    });
  }

  // Delete fast from list favorite
  deleteFastFromList(int id) {
    favoriteJson.eEmbedded.favorites.removeWhere((element) => element.id == id);
  }

  /// Delete favorite advert from list favorite
  deleteFavorite(int id) async {
    update();
    _deleteFavoriteApi.id = id.toString();
    deleteFastFromList(id);
    Get.find<TapHomeViewController>().deleteFromFavoritesList(id);
    await _deleteFavoriteApi.deleteData().then((value) {
      Get.find<FavoriteViewController>().idItemDelete = null;
    });
    update();
  }
}
