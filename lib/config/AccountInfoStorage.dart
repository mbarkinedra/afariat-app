import 'package:afariat/config/storage.dart';
import 'package:afariat/home/home_view_controller.dart';
import 'package:get/get.dart';

class AccountInfoStorage extends GetxController {
  static const _key_email = 'username';
  static const _key_hashedPassword = 'hashedPassword';
  static const _key_user_id = 'user_id';
  static const _key_name = 'name';
  static const _key_password = 'password';

  static const _key_phone = 'phone';
  SecureStorage _secureStorage = SecureStorage();

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

  String readEmail() {
    return _secureStorage.readSecureData(_key_email);
  }

  String readName() {
    return _secureStorage.readSecureData(_key_name);
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

  /// Removes the hashed password from the secure storage, so user is no longer loggen in.
   removeHashedPassword() {
    return _secureStorage.deleteSecureData(_key_hashedPassword);
  }

  logout() {
    _secureStorage.deleteSecureData(_key_email);
    _secureStorage.deleteSecureData(_key_phone);
    _secureStorage.deleteSecureData(_key_user_id);
    _secureStorage.deleteSecureData(_key_name);
    Get.find<HomeViwController>(). updatelist();
  }

  bool isLoggedIn() {
    var hashedPassword = _secureStorage.readImmediatlyData(_key_hashedPassword);
    if ((hashedPassword ?? '') == '') {
      return false;
    }
    return true;
  }
}
