

import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

class SecureStorage extends GetxService{
  String  key_email = 'username';
  String  key_wsse = 'wsse';
  String key_hashPassword = 'hashedPassword';

  final box = GetStorage();

  Future writeSecureData(String key, String value)  async {


    var writeData = await box.write( key,value);
    return writeData;
  }
  String readSecureData(String key)   {

    var readData =   box.read( key);
    return readData;
  }
  Future deleteSecureData(String key) async{

    var deleteData = await box.remove( key);
    return deleteData;
  }
}