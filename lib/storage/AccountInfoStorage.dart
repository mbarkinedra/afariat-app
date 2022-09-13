import 'package:afariat/home/home_view_controller.dart';
import 'package:afariat/storage/storage.dart';
import 'package:get/get.dart';

import '../networking/json/preference_json.dart';

class AccountInfoStorage extends GetxController {
  static const _key_email = 'username';
  static const _key_hashedPassword = 'hashedPassword';
  static const _key_user_id = 'user_id';
  static const _key_name = 'name';
  static const _key_password = 'password';
  static const _key_intro = 'intro';
  static const _key_phone = 'phone';
  static const _key_preference = 'preference';

  SecureStorage _secureStorage = Get.find<SecureStorage>();

  saveEmail(String email) {
    _secureStorage.writeSecureData(_key_email, email);
  }

  saveHashedPassword(String hashedPassword) {
    _secureStorage.writeSecureData(_key_hashedPassword, hashedPassword);
  }

  savePassword(String password) {
    _secureStorage.writeSecureData(_key_password, password);
  }

  saveUserId(String userId) {
    _secureStorage.writeSecureData(_key_user_id, userId);
  }

  saveName(String name) {
    _secureStorage.writeSecureData(_key_name, name);
  }

  savePhone(String phone) {
    _secureStorage.writeSecureData(_key_phone, phone);
  }

  saveIntro(String intro) {
    _secureStorage.writeSecureData(_key_intro, intro);
  }

  savePreference(PreferenceJson preference) async {
    await _secureStorage.write(_key_preference, preference);
  }

  String readEmail() {
    String email = _secureStorage.readSecureData(_key_email);

    return email;
  }

  String readName() {
    return _secureStorage.readSecureData(_key_name);
  }

  String readIntro() {
    return _secureStorage.readSecureData(_key_intro);
  }

  String readPassword() {
    return _secureStorage.readSecureData(_key_password);
  }

  String readPhone() {
    return _secureStorage.readSecureData(_key_phone);
  }

  String readHashedPassword() {
    return _secureStorage.readSecureData(_key_hashedPassword);
  }

  String readUserId() {
    return _secureStorage.readSecureData(_key_user_id);
  }

  Future<dynamic> readPreference() async {
    return await _secureStorage.read(_key_preference);
  }

  /// Removes the hashed password from the secure storage, so user is no longer loggen in.
  removeHashedPassword() {
    return _secureStorage.deleteSecureData(_key_hashedPassword);
  }

  logout() {
    _secureStorage.deleteSecureData(_key_email);
    _secureStorage.deleteSecureData(_key_phone);
    _secureStorage.deleteSecureData(_key_user_id);
    _secureStorage.deleteSecureData(_key_name);
    _secureStorage.deleteSecureData(_key_password);
    _secureStorage.deleteSecureData(_key_hashedPassword);
    _secureStorage.deleteSecureData(_key_preference);
    Get.find<HomeViewController>().updateList();
    Get.find<HomeViewController>().update();
  }

  bool isLoggedIn() {
    var hashedPassword = _secureStorage.readImmediatlyData(_key_hashedPassword);
    if ((hashedPassword ?? '') == '') {
      return false;
    }
    return true;
  }
}
