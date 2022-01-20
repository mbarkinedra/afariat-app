import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

class SecureStorage extends GetxController {
  // static final SecureStorage _singleton = SecureStorage._internal();
  //
  // factory SecureStorage() {
  //   return _singleton;
  // }
  //
  // SecureStorage._internal();

  final box = GetStorage('secure');

  writeSecureData(String key, String value) {
    var writeData = box.write(key, value);
    return writeData;
  }

  String readSecureData(String key) {
    var readData = box.read(key);
    return readData;
  }

  deleteSecureData(String key) {
    var deleteData = box.remove(key);
    // return deleteData;
  }

  String readImmediatlyData(String key) {
    String readData = box.read(key);
    return readData;
  }
}
