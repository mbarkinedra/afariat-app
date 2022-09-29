import 'package:afariat/networking/api/favorite_api.dart';
import 'package:afariat/networking/json/favorite_json.dart';
import 'package:afariat/storage/AccountInfoStorage.dart';
import 'package:get/get.dart';

class FavoriteViewController extends GetxController {
  final FavoriteApi _favoriteApi = FavoriteApi();

  FavoriteJson favoriteJson;
  int idItemDelete;

  @override
  void onInit() {
    getFavorite();
    super.onInit();
  }

  @override
  void dispose() {
    super.dispose();
  }

  ///Add favovorite advert from homescrenn and advertDetails
  addToMyFavorite(id) {
    _favoriteApi.postResource(dataToPost: {"id": id}).then((value) {
      getFavorite();
    });
  }

  ///get List of favorite adverts
  Future getFavorite() async {
    if (Get.find<AccountInfoStorage>().isLoggedIn()) {
      await _favoriteApi.secureGet().then((value) {
        //Get.find<TapHomeViewController>().favorites.clear();
        favoriteJson = FavoriteJson.fromJson(value.data);
        favoriteJson.eEmbedded.favorites.forEach((element) {
          //Get.find<TapHomeViewController>().favorites.add(element.advert.id);
        });
        //Get.find<TapHomeViewController>().update();
      });
      update();
    }
  }

  /// Delete Favorite by advert
  deleteFavoriteByAdvert(int advertId) async {
    //Get.find<TapHomeViewController>().favorites.remove(advertId);
    await _favoriteApi.deleteByAdvertId(advertId.toString()).then((value) {
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
    deleteFastFromList(id);
    //Get.find<TapHomeViewController>().deleteFromFavoritesList(id);
    await _favoriteApi.deleteResource(id.toString()).then((value) {
      Get.find<FavoriteViewController>().idItemDelete = null;
    });
    update();
  }
}
