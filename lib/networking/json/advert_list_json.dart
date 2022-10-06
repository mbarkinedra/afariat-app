import 'package:afariat/config/settings_app.dart';
import 'package:afariat/networking/json/abstract_json_resource.dart';
import 'package:afariat/networking/json/advert_minimal_json.dart';
import 'package:afariat/networking/json/paginated_resource.dart';

import 'link.dart';

class AdvertListJson extends PaginatedJsonResource {
  Embedded embedded;

  AdvertListJson(
      [int page, int limit, int pages, int total, Links links, this.embedded])
      : super(page, limit, pages, total, links);

  AdvertListJson.fromJson(Map<String, dynamic> json) : super.fromJson(json) {
    embedded = Embedded.fromJson(json['_embedded']);
  }

  List<AdvertMinimalJson> adverts() => embedded?.adverts;
}

class Embedded {
  List<AdvertMinimalJson> adverts;

  Embedded({this.adverts});

  Embedded.fromJson(Map<String, dynamic> json) {
    adverts = List.from(json['adverts'])
        .map((e) => AdvertMinimalJson.fromJson(e))
        .toList();
  }
}
