import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';

import '../../../model/favorite_list.dart';
import '../../../networking/api/favorite_api.dart';
import '../../../networking/json/favorite_json.dart';

class FavoriteViewController extends GetxController {
  final PagingController<int, FavoriteJson> pagingController =
      PagingController(firstPageKey: 0);
  final FavoriteApi _api = FavoriteApi();
  ScrollController scrollController = ScrollController();
  FavoriteListJson favoriteListJson;
  RxBool isLoadingMore = false.obs;
  RxBool isDeleting = false.obs;

  @override
  void onInit() {
    fetchPage();
    scrollController.addListener(() {
      if (scrollController.position.atEdge) {
        if (scrollController.offset >=
            scrollController.position.maxScrollExtent) {
          onSwipeUp();
        }
      }
    });
    super.onInit();
  }

  @override
  void dispose() {
    pagingController.dispose();
    scrollController.dispose();
    super.dispose();
  }

  /// fetch page
  Future<void> fetchPage([String url]) async {
    try {
      _api.url = url;
      await _api.secureGetList().then((value) {
        favoriteListJson = value;
      });

      pagingController.appendLastPage(favoriteListJson.favorites());
    } catch (error) {
      print(error);
      pagingController.error = error;
    }
  }

  Future<void> onSwipeUp() async {
    isLoadingMore.value = true;
    if (favoriteListJson.links.next == null) {
      await fetchPage(favoriteListJson.links.lastUrl);
    } else {
      await fetchPage(favoriteListJson.links.nextUrl);
      isLoadingMore.value = false;
    }
  }

  Future<void> swipeDown() async {
    pagingController.itemList?.clear();

    if (favoriteListJson.links.previous == null) {
      await fetchPage(favoriteListJson.links.firstUrl);
    } else {
      await fetchPage(favoriteListJson.links.previousUrl);
    }
  }

  // Delete fast from list favorite
  removeFavoriteAdvert(FavoriteJson element, int index) async {
    isDeleting.value = true;
    try {
      await _api.deleteResource(element.id.toString()).then((value) {
        favoriteListJson.remove(element);
        pagingController.itemList?.clear();
        pagingController.appendLastPage(favoriteListJson.favorites());
      });
    } catch (error) {
      print(error);
    }
    isDeleting.value = false;
  }

  addAdvertToFavorites(int advertId) async {
    print('add');
    try {
      await _api.addAdvert(advertId).then((value) {
        FavoriteList.add(advertId);
      });
    } catch (error) {
      print(error);
    }
  }

  removeAdvertFromFavorite(int advertId) async {
    print('remove');
    try {
      await _api.deleteByAdvertId(advertId).then((value) {
        FavoriteList.remove(advertId);
      });
    } catch (error) {
      print(error);
    }
  }
}
