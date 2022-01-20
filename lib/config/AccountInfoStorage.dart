import 'package:afariat/config/storage.dart';
import 'package:get/get.dart';

class AccountInfoStorage extends GetxController {
  static const _key_email = 'username';
  static const _key_hashedPassword = 'hashedPassword';
  static const _key_user_id = 'user_id';
  static const _key_name = 'name';
  static const _key_phone = 'phone';
  SecureStorage _secureStorage = SecureStorage();

  saveEmail(String email) {
    _secureStorage.writeSecureData(_key_email, email);
  }

  saveHashedPassword(String hashedPassword) {
    _secureStorage.writeSecureData(_key_hashedPassword, hashedPassword);
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
  String removeHashedPassword() {
    return _secureStorage.deleteSecureData(_key_hashedPassword);
  }

  logout() {
    print(" iiiii");
    _secureStorage.deleteSecureData(_key_email);
    _secureStorage.deleteSecureData(_key_phone);
    _secureStorage.deleteSecureData(_key_user_id);
    _secureStorage.deleteSecureData(_key_name);
  }

  bool isLoggedIn() {
    var hashedPassword = _secureStorage.readImmediatlyData(_key_hashedPassword);
    if ((hashedPassword ?? '') == '') {
      return false;
    }
    return true;
  }
}
