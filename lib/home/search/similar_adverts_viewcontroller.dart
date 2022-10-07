import 'package:get/get.dart';

import '../../Common/abstract_paginated_view_controller.dart';
import '../../config/settings_app.dart';
import '../../model/favorite_list.dart';
import '../../model/filter.dart';
import '../../networking/api/advert_api.dart';
import '../../networking/api/advert_details_api.dart';
import '../../networking/json/advert_details_json.dart';
import '../../networking/json/advert_list_json.dart';
import '../../networking/json/advert_minimal_json.dart';

class SimilarAdvertsViewController
    extends AbstractPaginatedViewController<AdvertMinimalJson> {
  AdvertListJson advertListJson;
  RxBool isGrid = true.obs;
  String advertId;
  AdvertDetailsJson advert;
  final AdvertDetailsApi _advertDetailsApi = AdvertDetailsApi();
  static const double kToolbarHeight = 60;
  static const double expandedHeight = 250;
  static const double expandedMaxImgHeight = 200;

  RxBool isSliverAppBarCollapsed = false.obs;
  RxDouble imgWidth = expandedMaxImgHeight.obs;
  RxDouble imgHeight = expandedMaxImgHeight.obs;

  @override
  void onInit() {
    advertId = Get.parameters['id'];
    scrollController.addListener(() {
      isSliverAppBarCollapsed.value = scrollController.hasClients &&
          (scrollController.offset - expandedHeight > 0);
      if (isSliverAppBarCollapsed.value) {
        imgWidth.value = 0;
        imgHeight.value = 0;
      } else {
        if (scrollController.offset <= 0) {
          imgWidth.value = expandedMaxImgHeight;
          imgHeight.value = expandedMaxImgHeight;
        } else {
          double _w = expandedMaxImgHeight - scrollController.offset;
          double _h = expandedMaxImgHeight - scrollController.offset;
          if (_w <= 0 || _h <= 0) { // if negative values set 0
            _w = _h = 0;
          }
          imgWidth.value = _w;
          imgHeight.value = _h;
        }
      }

      print('Width: ' + imgWidth.value.toString());
      print('height: ' + imgHeight.value.toString());
    });
    super.onInit();
  }

  @override
  Future<dynamic> fetchInitialData() async {
    advert = await _advertDetailsApi.getAdvert(advertId);
    String _url = SettingsApp.similarAdvert + '/' + advertId.toString();
    fetchPage(_url);
    return advert;
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  AdvertApi apiInstance() {
    if (api == null) {
      return AdvertApi();
    }
    return api;
  }

  @override
  Future<void> onSwipeUp() async {
    await fetchPage(advertListJson.links.nextUrl);
  }

  @override
  Future<void> onSwipeDown() async {
    await fetchPage(advertListJson.links.firstUrl);
  }

  @override
  bool hasNextResults() => advertListJson.links.next != null;

  @override
  onFetchApiSuccess(value) {
    advertListJson = value;
    pagingController.appendLastPage(advertListJson.adverts());
    _setFavorites();
  }

  _setFavorites() {
    advertListJson?.adverts()?.forEach((advert) {
      if (advert.isFavorite == true) {
        FavoriteList.add(advert.id);
      }
    });
  }
}
