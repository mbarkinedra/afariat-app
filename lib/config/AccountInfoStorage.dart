
import 'package:afariat/config/storage.dart';

class AccountInfoStorage {
  static const String _key_email = 'username';
  static const String _key_wsse = 'wsse';
  static const String _key_hashPassword = 'hashedPassword';

  final SecureStorage secureStorage = SecureStorage();

  AccountInfoStorage saveEmail(String email) {
    secureStorage.writeSecureData(_key_email, email);
    return this;
  }

  AccountInfoStorage saveWsse(String wsse) {
    secureStorage.writeSecureData(_key_wsse, wsse);
    return this;
  }

  AccountInfoStorage saveHashPassword(String hashedPassword) {
    secureStorage.writeSecureData(_key_hashPassword, hashedPassword);

    return this;
  }

  Future<String> readEmail() async {
    return await secureStorage.readSecureData(_key_email);
  }

  Future<String> readhashedPassword() async {
    return await secureStorage.readSecureData(_key_hashPassword);
  }

  Future<String> readWsse() async {
    return await secureStorage.readSecureData(_key_wsse);
  }
}
