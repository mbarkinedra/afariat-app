import 'abstract_json_resource.dart';
import 'link.dart';

class PaginatedJsonResource extends AbstractJsonResource {
  int page;
  int limit;
  int pages;
  int total;
  Links links;

  PaginatedJsonResource(
      [this.page, this.limit, this.pages, this.total, this.links]);

  PaginatedJsonResource.name(
      this.page, this.limit, this.pages, this.total, this.links);

  PaginatedJsonResource.fromJson(Map<String, dynamic> json) {
    page = json['page'];
    limit = json['limit'];
    pages = json['pages'];
    total = json['total'];
    links = json['_links'] != null ? Links.fromJson(json['_links']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> json = <String, dynamic>{};
    json['page'] = page;
    json['limit'] = limit;
    json['pages'] = pages;
    json['total'] = total;
    json['_links'] = links.toJson();
    return json;
  }
}
