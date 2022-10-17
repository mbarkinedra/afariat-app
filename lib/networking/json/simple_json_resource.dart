import 'package:afariat/networking/json/abstract_json_resource.dart';

/// this Class is used to describe simple json responses that have code and message in body.
class SimpleJsonResource extends AbstractJsonResource {
  int code;
  dynamic message;

  SimpleJsonResource({this.code, this.message});

  SimpleJsonResource.fromJson(Map<String, dynamic> json) {
    code = json['code'];
    message = json['message'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['code'] = this.code;
    data['message'] = this.message;
    return data;
  }

  int get statusCode => code;
  Map<String, dynamic> get data => toJson();
}
