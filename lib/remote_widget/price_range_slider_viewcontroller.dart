import 'package:get/get.dart';
import '../config/Referentiel.dart';
import '../networking/api/ref_api.dart';
import '../networking/json/ref_json.dart';

class PriceRangeSliderViewController extends GetxController {
  final PriceApi _api = PriceApi();
  RefListJson items = RefListJson();
  RxInt minPriceId = Referential.priceMinId.obs;
  RxInt maxPriceId = Referential.priceMaxId.obs;
  RxString selectedMinPriceValue = '0'.obs;
  RxString selectedMaxPriceValue = '500 000+'.obs;

  @override
  Future<void> onInit() async {
    await fetchItems();
    super.onInit();
  }

  Future<RefListJson> fetchItems() async {
    if (items.isNotEmpty()) {
      // make call only if the current list is empty
      return items;
    }
    items = await _api.getList();
    minPriceId.value = items.first().id;
    maxPriceId.value = items.last().id;
    return items;
  }
}
