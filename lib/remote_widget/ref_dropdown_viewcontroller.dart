import 'package:get/get_state_manager/src/simple/get_controllers.dart';

import '../networking/api/ref_api.dart';
import '../networking/json/ref_json.dart';

abstract class RefDropdownViewController extends GetxController {
  RefListJson items = RefListJson();
  RefJson selectedItem;

  RefApi getApi();

  @override
  Future<void> onInit() async {
    fetchItems();
    super.onInit();
  }

  Future<RefListJson> fetchItems() async {
    if(items.isNotEmpty()){ // make call only if the current list is empty
      return items;
    }

    items = await getApi().getList() as RefListJson;
    return items;
  }
}
