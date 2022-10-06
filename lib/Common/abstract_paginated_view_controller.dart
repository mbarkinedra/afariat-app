import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';

import '../config/settings_app.dart';
import '../networking/api/resource_api.dart';
import '../storage/AccountInfoStorage.dart';

abstract class AbstractPaginatedViewController<T> extends GetxController {
  final PagingController<int, T> pagingController =
      PagingController(firstPageKey: 0);
  ScrollController scrollController = ScrollController();
  RxBool isLoadingMore = false.obs;
  RxBool noMoreResults = false.obs;
  ResourceApi _api;
  AccountInfoStorage accountInfoStorage = Get.find<AccountInfoStorage>();

  @override
  void onInit() {
    _api = apiInstance();
    fetchInitialData();
    scrollController.addListener(() {
      if (scrollController.position.atEdge) {
        if (scrollController.offset >=
            scrollController.position.maxScrollExtent) {
          swipeUp();
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

  ResourceApi get api => _api;

  onFetchApiSuccess(value);

  Future<void> fetchInitialData() async {
    fetchPage();
  }

  Future<void> fetchPage([String url]) async {
    try {
      String _url = url == null ? _api.baseApiUrl() : SettingsApp.baseUrl + url;
      if (accountInfoStorage.isLoggedIn()) {
        await _api.secureGetCollection(_url).then((value) {
          onFetchApiSuccess(value);
        });
      } else {
        await _api.getCollection(_url).then((value) {
          onFetchApiSuccess(value);
        });
      }
    } catch (error) {
      pagingController.error = error;
    }
  }

  Future<void> swipeUp() async {
    isLoadingMore.value = true;
    if (!hasNextResults()) {
      isLoadingMore.value = false;
      noMoreResults.value = true;
      return;
    } else {
      onSwipeUp();
      isLoadingMore.value = false;
    }
  }

  Future<void> swipeDown() async {
    pagingController.itemList?.clear();
    pagingController.refresh(); //refreshes the UI
    noMoreResults.value = false;
    onSwipeDown();
  }

  /// Get the API resource instance of the children class
  ResourceApi apiInstance();

  /// Executes the logic of onSwipeUp. UI is already set by swipeUP
  Future<void> onSwipeUp();

  Future<void> onSwipeDown();

  /// Did current resource has next results
  bool hasNextResults();
}
