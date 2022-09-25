import 'package:get/get.dart';
import 'package:syncfusion_flutter_sliders/sliders.dart';
import '../networking/api/ref_api.dart';
import '../networking/json/ref_json.dart';

class PriceRangeSliderViewController extends GetxController {
  final PriceApi _api = PriceApi();
  RefListJson items = RefListJson();
  int minPriceId = 0;
  int maxPriceId = 20;
  RxString selectedMinPriceValue = '0'.obs;
  RxString selectedMaxPriceValue = '500 000+'.obs;
  Rx<SfRangeValues> values = const SfRangeValues(0,20).obs;

  @override
  Future<void> onInit() async {
    fetchItems();
    super.onInit();
  }

  Future<RefListJson> fetchItems() async {
    if (items.isNotEmpty()) {
      // make call only if the current list is empty
      return items;
    }
    items = await _api.getList();
    minPriceId = items.first().id;
    maxPriceId = items.last().id;
    values.value = SfRangeValues(minPriceId, maxPriceId);
    return items;
  }
}
