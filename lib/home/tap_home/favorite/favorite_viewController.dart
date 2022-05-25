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
  List<int> favorites = [];
  FavoriteJson favoriteJson;

  @override
  void onInit() {
    super.onInit();
    getFavorite();
  }

  addToMyFavorite(id) {
    _favoriteApi.securePost(dataToPost: {"id": id}).then((value) {
      getFavorite();
      Get.find<TapHomeViewController>().update();
    });
  }

  getFavorite() {
    _favoriteApi.secureGet().then((value) {
      favoriteJson = FavoriteJson.fromJson(value.data);
      favoriteJson.eEmbedded.favorites.forEach((element) {
        favorites.add(element.advert.id);
      });
      update();
    });
  }

  deleteFavoriteByAdvert(int id) {
    //  favorites.removeAt(index);

    _deleteFavoriteByAdvert.IdAdvert = id.toString();
    _deleteFavoriteByAdvert.deleteData().then((value) {
      getFavorite();
      Get.find<TapHomeViewController>().update();
    });
  }

  deleteFavorite(int id) {
    //  favorites.removeAt(index);

    _deleteFavoriteApi.id = id.toString();
    _deleteFavoriteApi.deleteData().then((value) {
      getFavorite();
    });
  }
}
