import 'dart:async';

import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/foundation.dart';
import 'package:get/get.dart';

class Network {
  static RxBool status = true.obs;
  static final Connectivity _connectivity = Connectivity();
  static StreamSubscription<ConnectivityResult> connectivitySubscription;

  static setup() {
    connectivitySubscription =
        _connectivity.onConnectivityChanged.listen((_updateConnectionStatus));
    try {
      _connectivity.checkConnectivity().then((value) {
        _updateConnectionStatus(value);
      });

    } catch (e) {
      if (kDebugMode) {
        print('Connection error: ');
        print(e);
      }
    }
  }

  static _updateConnectionStatus(ConnectivityResult value) {
    switch (value) {
      case ConnectivityResult.wifi:
      case ConnectivityResult.mobile:
      case ConnectivityResult.bluetooth:
      case ConnectivityResult.ethernet:
        status.value = true;
        break;
      case ConnectivityResult.none:
        status.value = false;
        break;
    }
  }

  static close() {
    if (connectivitySubscription != null) {
      connectivitySubscription.cancel();
    }
  }
}
