import 'package:afariat/networking/json/abstract_json_resource.dart';

class ErrorJsonResource extends AbstractJsonResource {
  int code;
  String message;

  ErrorJsonResource({this.code, this.message});

  ErrorJsonResource.fromJson(Map<String, dynamic> json) {
    code = json['code'];
    message = json['message'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['code'] = this.code;
    data['message'] = this.message;
    return data;
  }

  int get statusCode => code;
  Map<String, dynamic> get data => toJson();
}
