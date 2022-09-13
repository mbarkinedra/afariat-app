import 'package:flutter/foundation.dart';
import 'package:get/get.dart';

import '../networking/api/preference_api.dart';
import '../networking/json/preference_json.dart';
import '../storage/AccountInfoStorage.dart';

class NotificationSettingsViewController extends GetxController {
  final PreferenceApi _api = PreferenceApi();
  PreferenceJson preference = PreferenceJson();
  bool loading = true;

  RxBool optinLight = false.obs;

  RxBool messageLight = false.obs;
  RxBool statisticsLight = false.obs;
  RxBool advertStatusLight = false.obs;
  RxBool canalSmsLight = false.obs;
  RxBool canalPhoneLight = false.obs;
  RxBool canalEmailLight = false.obs;
  RxBool canalAppLight = false.obs;

  @override
  void onInit() {
    fetchData();
    super.onInit();
  }

  Future<NotificationSettingsViewController> fetchData() async {
    try {
      var response = await _api.getData();
      if (response != null) {
        preference = PreferenceJson.fromJson(response.data);
        await Get.find<AccountInfoStorage>().savePreference(preference);
        initLights();
        update();
      }
    } catch (e) {
      if (kDebugMode) {
        print(e);
      }
    }
    loading = false;
    return this;
  }

  initLights() {
    if(preference == null){
      return ;
    }
    optinLight.value = preference.optin;
    messageLight.value = preference.notifyOnMessage;
    statisticsLight.value = preference.notifyForStatistics;
    advertStatusLight.value = preference.notifyForAdvertStatusChange;
    canalSmsLight.value = preference.canalSms;
    canalPhoneLight.value = preference.canalPhone;
    canalEmailLight.value = preference.canalEmail;
    canalAppLight.value = preference.canalApp;
  }

  updateData(int id, bool value) async {
    if(!Get.find<AccountInfoStorage>().isLoggedIn()){
      Get.snackbar("Erreur", "Veuillez vous connecter pour mette à joru vos notifications");
      return ;
    }
    var response;
    switch (id) {
      case 1:
        optinLight.value = preference.optin = value;
        break;
      case 2:
        messageLight.value = preference.notifyOnMessage = value;
        break;
      case 3:
        statisticsLight.value = preference.notifyForStatistics = value;
        break;
      case 4:
        advertStatusLight.value =
            preference.notifyForAdvertStatusChange = value;
        break;
      case 5:
        canalSmsLight.value = preference.canalSms = value;
        break;
      case 6:
        canalPhoneLight.value = preference.canalPhone = value;
        break;
      case 7:
        canalEmailLight.value = preference.canalEmail = value;
        break;
      case 8:
        canalAppLight.value = preference.canalApp = value;
        break;
      default:
        return;
    }
    response = await _api.putResource(
        dataToPost: preference.toJson(),
        queryParams: {'id': id.toString(), 'value': value.toString()});

    if (response.statusCode == 204) {
      await Get.find<AccountInfoStorage>().savePreference(preference);
    }
  }
}
