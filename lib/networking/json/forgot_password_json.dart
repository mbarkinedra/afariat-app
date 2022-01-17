import 'abstract_json_resource.dart';

class ForgotPasswordJson extends AbstractJsonResource {
  String message;

  ForgotPasswordJson({this.message});

  ForgotPasswordJson.fromJson(Map<String, dynamic> json) {
    message = json['message'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['message'] = this.message;
    return data;
  }
}
