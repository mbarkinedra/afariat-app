import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

class SecureStorage extends GetxController {
  static final SecureStorage _singleton = SecureStorage._internal();

  factory SecureStorage() {
    return _singleton;
  }

  SecureStorage._internal();

  static final box = GetStorage('secure');

  static Future writeSecureData(String key, String value) async {
    var writeData = await box.write(key, value);
    return writeData;
  }

  static Future readSecureData(String key) async {
    var readData = await box.read(key);
    return readData;
  }

  static Future deleteSecureData(String key) async {
    var deleteData = await box.remove(key);
    return deleteData;
  }

  static String readImmediatlyData(String key) {
    String readData = box.read(key);
    return readData;
  }
}
