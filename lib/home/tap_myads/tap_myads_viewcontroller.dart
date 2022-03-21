import 'package:afariat/config/AccountInfoStorage.dart';
import 'package:afariat/config/storage.dart';
import 'package:afariat/controllers/network_controller.dart';
import 'package:afariat/networking/api/delete_ads.dart';
import 'package:afariat/networking/api/my_ads_api.dart';
import 'package:afariat/networking/json/my_ads_json.dart';
import 'package:get/get.dart';

class TapMyadsViewController extends GetxController {
  MyAdsApi _myAdsApi = MyAdsApi();
  DeleteAds _deleteAds = DeleteAds();
  final storge = Get.find<SecureStorage>();
  List<Adverts> adverts = [];
  bool deleteData = false;
  bool getAdsFromServer = false;
  @override
  void onInit() {
    super.onInit();

      print("999999999999999");
      ads();


  }

ads() {
  if(Get.find<NetWorkController>().connectionStatus.value ){
    _myAdsApi.userId = Get.find<AccountInfoStorage>().readUserId();
    getAdsFromServer = true;
   // update();
    _myAdsApi.getList().then((value) {
      MyAdsJson myAdsJson = MyAdsJson();
      myAdsJson = value;
      adverts = myAdsJson.eEmbedded.adverts;

      getAdsFromServer = false;
      update();
    });
  }}

 Future deleteAds(int i) async{
    deleteData = true;
    update();
    _deleteAds.id = i;

   await _deleteAds.delPost().then((value) {
      ads();
      deleteData = false;
      print("ok deleete" );

      update();
    });
print("not ok delete" );
    update();
  }
}
