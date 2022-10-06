import 'package:get/get.dart';
import '../../../Common/abstract_paginated_view_controller.dart';
import '../../../model/favorite_list.dart';
import '../../../networking/api/favorite_api.dart';
import '../../../networking/json/favorite_json.dart';

class FavoriteViewController
    extends AbstractPaginatedViewController<FavoriteJson> {
  FavoriteListJson favoriteListJson;
  RxMap<int, bool> deleteStatusList = <int, bool>{}.obs;

  @override
  void onInit() {
    super.onInit();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  FavoriteApi apiInstance() {
    return FavoriteApi();
  }

  Future<void> fetchInitialData() async {
    if (accountInfoStorage.isLoggedIn()) {
      fetchPage();
    }
  }

  @override
  Future<void> onSwipeUp() async {
    await fetchPage(favoriteListJson.links.nextUrl);
  }

  @override
  Future<void> onSwipeDown() async {
    await fetchPage(favoriteListJson.links.firstUrl);
  }

  @override
  bool hasNextResults() => favoriteListJson.links.next != null;

  @override
  onFetchApiSuccess(value) {
    favoriteListJson = value;
    pagingController.appendLastPage(favoriteListJson.favorites());
  }

  // Delete fast from list favorite
  removeFavoriteAdvert(FavoriteJson element, int index) async {
    deleteStatusList[index] = true;
    try {
      await api.deleteResource(element.id.toString()).then((value) {
        favoriteListJson.remove(element);
        pagingController.itemList?.clear();
        pagingController.appendLastPage(favoriteListJson.favorites());
      });
    } catch (error) {
      print(error);
    }
    deleteStatusList[index] = false;
  }

  addAdvertToFavorites(int advertId) async {
    try {
      await apiInstance().addAdvert(advertId).then((value) {
        FavoriteList.add(advertId);
        swipeDown();
      });
    } catch (error) {
      print(error);
    }
  }

  removeAdvertFromFavorite(int advertId) async {
    try {
      await apiInstance().deleteByAdvertId(advertId).then((value) {
        FavoriteList.remove(advertId);
        swipeDown();
      });
    } catch (error) {
      print(error);
    }
  }
}
