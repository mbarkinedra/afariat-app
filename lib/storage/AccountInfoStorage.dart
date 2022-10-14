import 'package:afariat/home/main_view_controller.dart';
import 'package:afariat/storage/storage.dart';
import 'package:flutter/foundation.dart';
import 'package:get/get.dart';

import '../networking/api/abstract_user_api.dart';
import '../networking/json/preference_json.dart';
import '../persistent_tab_manager.dart';

@deprecated
@Deprecated('Create a static class that does not depend on Getx')
class AccountInfoStorage extends GetxController {
  static const _keyEmail = 'username';
  static const _keyHashedPassword = 'hashedPassword';
  static const _keyUserId = 'user_id';
  static const _keyName = 'name';
  static const _keyPassword = 'password';
  static const _keyIntro = 'intro';
  static const _keyPhone = 'phone';
  static const _keyPreference = 'preference';
  static const keyLocalization = 'localisation';

  SecureStorage _secureStorage = Get.find<SecureStorage>();

  saveEmail(String email) {
    _secureStorage.writeSecureData(_keyEmail, email);
  }

  saveHashedPassword(String hashedPassword) async {
    await _secureStorage.writeSecureData(_keyHashedPassword, hashedPassword);
  }

  savePassword(String password) {
    _secureStorage.writeSecureData(_keyPassword, password);
  }

  saveUserId(String userId) {
    _secureStorage.writeSecureData(_keyUserId, userId);
  }

  saveName(String name) {
    _secureStorage.writeSecureData(_keyName, name);
  }

  savePhone(String phone) {
    _secureStorage.writeSecureData(_keyPhone, phone);
  }

  saveIntro(String intro) {
    _secureStorage.writeSecureData(_keyIntro, intro);
  }

  savePreference(PreferenceJson preference) async {
    await _secureStorage.write(_keyPreference, preference);
  }

  saveLocalization(Map<String, dynamic> localizationList) async {
    await _secureStorage.write(keyLocalization, localizationList);
  }

  String readEmail() {
    String email = _secureStorage.readSecureData(_keyEmail);

    return email;
  }

  String readName() {
    return _secureStorage.readSecureData(_keyName);
  }

  String readIntro() {
    return _secureStorage.readSecureData(_keyIntro);
  }

  String readPassword() {
    return _secureStorage.readSecureData(_keyPassword);
  }

  String readPhone() {
    return _secureStorage.readSecureData(_keyPhone);
  }

  String readHashedPassword() {
    return _secureStorage.readSecureData(_keyHashedPassword);
  }

  String readUserId() {
    return _secureStorage.readSecureData(_keyUserId);
  }

  Future<dynamic> readPreference() async {
    return await _secureStorage.read(_keyPreference);
  }

  Future<dynamic> readLocalization() async {
    return _secureStorage.read(keyLocalization);
  }

  /// Removes the hashed password from the secure storage, so user is no longer loggen in.
  removeHashedPassword() {
    return _secureStorage.deleteSecureData(_keyHashedPassword);
  }

  logout() {
    //try to logout from server
    LogoutApi _logoutApi = LogoutApi();
    try {
      _logoutApi.logout();
    } catch (e) {
      if (kDebugMode) {
        print(e);
      }
    }

    removeUserData();

    PersistentTabManager.updateScreens();
    PersistentTabManager.changePage(0);
    Get.find<MainViewController>().update();
  }

  removeLocalization() async {
    await _secureStorage.remove(keyLocalization);
  }

  removeUserData() {
    //Now remove everything in the local storage
    _secureStorage.deleteSecureData(_keyEmail);
    _secureStorage.deleteSecureData(_keyPhone);
    _secureStorage.deleteSecureData(_keyUserId);
    _secureStorage.deleteSecureData(_keyName);
    _secureStorage.deleteSecureData(_keyPassword);
    _secureStorage.deleteSecureData(_keyHashedPassword);
    _secureStorage.deleteSecureData(_keyPreference);
  }

  removeAll() {
    removeUserData();
    _secureStorage.deleteSecureData(keyLocalization);
  }

  bool isLoggedIn() {
    var hashedPassword = _secureStorage.readImmediatlyData(_keyHashedPassword);
    if ((hashedPassword ?? '') == '') {
      return false;
    }
    return true;
  }
}
