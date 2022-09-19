import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

class SecureStorage extends GetxController {
  GetStorage box;

  @override
  void onInit() {
    super.onInit();
    box = GetStorage('secure');
  }

  write(String key, dynamic value) async {
    await box.write(key, value);
  }

  remove(String key) async {
    await box.remove(key);
  }

  writeSecureData(String key, String value) {
    var writeData = box.write(key, value);
    return writeData;
  }

  String readSecureData(String key) {
    String readData = box.read(key);
    return readData;
  }

  dynamic read(String key) async {
    return  await box.read(key);
  }

  Future deleteSecureData(String key) async {
    await box.remove(key);
  }

  String readImmediatlyData(String key) {
    String readData = box.read(key);
    return readData;
  }
}
