import 'dart:async';

import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:get/get.dart';
class NetWorkController extends GetxController{
  var connectionStatus=false.obs;
  final Connectivity _connectivity=Connectivity();
  StreamSubscription<ConnectivityResult>_connectivitysubscription;
  @override
  void onInit() {
    super.onInit();

    initConnctivity();
    _connectivitysubscription=_connectivity.onConnectivityChanged.listen((_updateConnectionStatus ));



  }

  Future<void>   initConnctivity()async {


    ConnectivityResult result;
    try{

      _connectivity.checkConnectivity().then((value) {

        _updateConnectionStatus(value);

      });
    }catch(e){
      print(e.toString());
    }


  }

  _updateConnectionStatus(ConnectivityResult value) {


    switch(value){
      case ConnectivityResult.wifi:
        connectionStatus.value=true;
        break;
      case ConnectivityResult.mobile:
        connectionStatus.value=true;
        break;
      case ConnectivityResult.none:
        connectionStatus.value=false;
        break;
    }
  }
}













