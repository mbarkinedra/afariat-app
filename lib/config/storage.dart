import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

class SecureStorage extends GetxController {
  var box  ;

  @override
  void onInit() {
super.onInit();
box = GetStorage('secure');
  }

  writeSecureData(String key, String value) {
    var writeData = box.write(key, value);
   // return writeData;
  }

  String readSecureData(String key) {
    String readData = box.read(key);
    return readData;
  }

 Future deleteSecureData(String key) async{
  await  box.remove(key);
    // return deleteData;
  }

  String readImmediatlyData(String key) {
    String readData = box.read(key);
    return readData;
  }
}
