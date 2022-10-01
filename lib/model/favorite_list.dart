import 'package:get/get.dart';

class SimpleList {
  List<int> list = <int>[];

  add(int advertId) {
    if (list.contains(advertId)) {
      return;
    }
    list.add(advertId);
  }

  remove(int advertId) => list?.remove(advertId);

  clear() => list?.clear();

  has(int advertId) => list?.contains(advertId) ?? false;
}

class FavoriteList {
  static Rx<SimpleList> data = SimpleList().obs;

  static add(int advertId) {
    data.value.add(advertId);
    data.refresh();//refresh for Obx update
  }

  static remove(int advertId) {
    data.value.remove(advertId);
    data.refresh();
  }

  static clear() {
    data.value?.clear();
    data.refresh();
  }

  static has(int advertId) {
    return data.value.has(advertId) ?? false;
  }
}
