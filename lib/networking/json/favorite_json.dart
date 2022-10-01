import 'package:afariat/config/settings_app.dart';
import 'package:afariat/networking/json/abstract_json_resource.dart';
import 'package:afariat/networking/json/paginated_resource.dart';

import 'advert_minimal_json.dart';
import 'link.dart';

class FavoriteListJson extends PaginatedJsonResource {
  EmbeddedFavorites embedded;

  FavoriteListJson(
      [int page, int limit, int pages, int total, Links links, this.embedded])
      : super(page, limit, pages, total, links);

  FavoriteListJson.fromJson(Map<String, dynamic> json) : super.fromJson(json) {
    embedded = json['_embedded'] != null
        ? EmbeddedFavorites.fromJson(json['_embedded'])
        : null;
  }

  @override
  Map<String, dynamic> toJson() {
    final Map<String, dynamic> json = super.toJson();
    if (embedded != null) {
      json['_embedded'] = embedded.toJson();
    }
    return json;
  }

  List<FavoriteJson> favorites() => embedded?.favorites;

  remove(FavoriteJson element) {
    if (favorites() == null) return;
    embedded.favorites.removeWhere((e) => e.id == element.id);
  }

  @override
  String toString() {
    return toJson().toString();
  }
}

class EmbeddedFavorites {
  List<FavoriteJson> favorites = [];

  EmbeddedFavorites({this.favorites});

  EmbeddedFavorites.fromJson(Map<String, dynamic> json) {
    if (json['favorites'] != null) {
      json['favorites'].forEach((v) {
        favorites.add(FavoriteJson.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> json = <String, dynamic>{};
    if (favorites != null) {
      json['favorites'] = favorites.map((v) => v.toJson()).toList();
    }
    return json;
  }
}

class FavoriteJson {
  int id;
  String createdAt;
  AdvertMinimalJson advert;
  FavoriteLinks links;

  FavoriteJson({this.id, this.createdAt, this.advert, this.links}) : super();

  FavoriteJson.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    createdAt = json['created_at'];
    advert = json['advert'] != null
        ? AdvertMinimalJson.fromJson(json['advert'])
        : null;
    links =
        json['_links'] != null ? FavoriteLinks.fromJson(json['_links']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> json = <String, dynamic>{};
    json['id'] = id;
    json['created_at'] = createdAt;
    if (advert != null) {
      json['advert'] = advert.toJson();
    }
    if (links != null) {
      json['_links'] = links.toJson();
    }
    return json;
  }
}

class FavoriteLinks {
  Link advertLink;
  Link userLink;
  Link deleteLink;

  FavoriteLinks({this.advertLink, this.userLink, this.deleteLink});

  FavoriteLinks.fromJson(Map<String, dynamic> json) {
    advertLink = json['advert'] != null ? Link.fromJson(json['advert']) : null;
    userLink = json['user'] != null ? Link.fromJson(json['user']) : null;
    deleteLink = json['delete'] != null ? Link.fromJson(json['delete']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> json = <String, dynamic>{};
    if (advertLink != null) {
      json['advert'] = advertLink.toJson();
    }
    if (this.userLink != null) {
      json['user'] = userLink.toJson();
    }
    if (this.deleteLink != null) {
      json['delete'] = deleteLink.toJson();
    }
    return json;
  }
}
