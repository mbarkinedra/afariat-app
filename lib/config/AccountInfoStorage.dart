import 'package:afariat/config/storage.dart';

class AccountInfoStorage {
  static const _key_email = 'username';
  static const _key_hashedPassword = 'hashedPassword';
  static const _key_user_id = 'user_id';
  static const _key_name = 'name';
  static const _key_phone = 'phone';

  static saveEmail(String email) async {
    SecureStorage.writeSecureData(_key_email, email);
  }

  static saveHashedPassword(String hashedPassword) async {
    SecureStorage.writeSecureData(_key_hashedPassword, hashedPassword);
  }

  static saveUserId(String userId) async {
    SecureStorage.writeSecureData(_key_user_id, userId);
  }

  static Future<String> readEmail() async {
    return await SecureStorage.readSecureData(_key_email);
  }

  static Future<String> readHashedPassword() async {
    return await SecureStorage.readSecureData(_key_hashedPassword);
  }

  static Future<String> readUserId() async {
    return await SecureStorage.readSecureData(_key_user_id);
  }

  /// Removes the hashed password from the secure storage, so user is no longer loggen in.
  static Future<String> removeHashedPassword() async {
    return await SecureStorage.deleteSecureData(_key_hashedPassword);
  }

  static bool isLoggedIn() {
    var hashedPassword = SecureStorage.readImmediatlyData(_key_hashedPassword);
    if ((hashedPassword ?? '') == '') {
      return false;
    }
    return true;
  }
}
