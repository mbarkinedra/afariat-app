import 'dart:async';

import 'package:afariat/home/tap_home/tap_home_viewcontroller.dart';
import 'package:afariat/home/tap_publish/tap_publish_viewcontroller.dart';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:get/get.dart';

import 'category_and_subcategory.dart';
import 'loc_controller.dart';

class NetWorkController extends GetxController {
  var connectionStatus = false.obs;
  final Connectivity _connectivity = Connectivity();
  StreamSubscription<ConnectivityResult> connectivitysubscription;

  @override
  void onInit() {
    super.onInit();

    initConnectivity();
    connectivitysubscription =
        _connectivity.onConnectivityChanged.listen((_updateConnectionStatus));
  }

  Future<void> initConnectivity() async {
    // ConnectivityResult result;
    try {
      _connectivity.checkConnectivity().then((value) {
        _updateConnectionStatus(value);
      });
    } catch (e) {}
  }

  _updateConnectionStatus(ConnectivityResult value) {
    TapHomeViewController tapHomeViewController =
        Get.find<TapHomeViewController>();
    switch (value) {
      case ConnectivityResult.wifi:
        connectionStatus.value = true;
        tapHomeViewController.getAllAds();
        Get.find<TapPublishViewController>().getMileages();
        Get.find<TapPublishViewController>().getYearsModels();
        Get.find<TapPublishViewController>().getRoomsNumber();
        Get.find<LocController>().getCitylist();
        Get.find<CategoryAndSubcategory>().getCategoryGrouppedApi();
        break;
      case ConnectivityResult.mobile:
        connectionStatus.value = true;
        tapHomeViewController.getAllAds();
        Get.find<TapPublishViewController>().getRoomsNumber();
        Get.find<TapPublishViewController>().getMileages();
        Get.find<TapPublishViewController>().getYearsModels();
        Get.find<LocController>().getCitylist();
        Get.find<CategoryAndSubcategory>().getCategoryGrouppedApi();

        break;
      case ConnectivityResult.bluetooth:
        break;
      case ConnectivityResult.ethernet:
        break;
      case ConnectivityResult.none:
        connectionStatus.value = false;
        break;
    }
  }

  @override
  void onClose() {
    super.onClose();
    connectivitysubscription.cancel();
  }
}
