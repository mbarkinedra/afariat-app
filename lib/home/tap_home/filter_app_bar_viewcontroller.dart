import 'package:afariat/config/Environment.dart';
import 'package:get/get.dart';
import 'package:get/get_state_manager/src/simple/get_controllers.dart';

import '../../networking/json/localization_json.dart';
import '../../storage/AccountInfoStorage.dart';

class FilterAppBarViewController extends GetxController {
  final AccountInfoStorage accountInfoStorage = Get.find<AccountInfoStorage>();
  RxString localizationLabel = Environment.allCountryLabel.obs;

  @override
  void onInit() async {
    setLocalizationLabel();
    super.onInit();
  }

  Future<RxString> setLocalizationLabel() async {
    dynamic json = await accountInfoStorage.readLocalization();
    if (json != null) {
      LocalizationListJson localizationsJsonList =
          LocalizationListJson.fromJson(json);
      switch (localizationsJsonList.count()) {
        case 0:
          localizationLabel.value = Environment.allCountryLabel;
          break;
        case 1:
          localizationLabel.value = localizationsJsonList.toList().first.name;
          break;
        default:
          localizationLabel.value = localizationsJsonList.toList().first.name +
              ' +' + ( localizationsJsonList.count() -1 ).toString();
          break;
      }
    }
    return localizationLabel;
  }
}
