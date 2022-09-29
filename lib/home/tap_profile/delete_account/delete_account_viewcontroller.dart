import 'package:afariat/networking/api/user.dart';
import 'package:afariat/storage/AccountInfoStorage.dart';
import 'package:get/get.dart';

import '../../main_view_controller.dart';

class DeleteAccountViewController extends GetxController{
  UserApi _userApi = UserApi();

  AccountInfoStorage accountInfoStorage = AccountInfoStorage();

  deleteUser() {
    _userApi.id = Get.find<AccountInfoStorage>().readUserId();
    _userApi
        .deleteResource(Get.find<AccountInfoStorage>().readUserId())
        .then((value) {
      Get.find<AccountInfoStorage>().logout();
      Get.find<MainViewController>().changeItemFilter(0);
      Get.back();
    });
  }
}