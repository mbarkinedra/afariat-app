import 'package:afariat/networking/json/ref_json.dart';

/// Implementation of the new API GET RESPONSE (code, message)
class GetJsonResponse {
  int _code;
  String _message;
  RefListJson data;

  GetJsonResponse.fromJson(Map<String, dynamic> json) {
    _code = json['code'];
    if (json['message'] != null) {
      if (json['message'] is String) {
        _message = json['message'].toString();
      } else {
        data = RefListJson.fromJson(json['message']);
      }
    }
  }

  Map<String, dynamic> toJson() {
    return <String, dynamic>{
      'code': _code,
      'message': _message,
      'data': data.toJson(),
    };
  }

  @override
  String toString() => toJson().toString();

  bool hasErrors() =>
      _code != 200; //As it's a GET, all success codes should be 200

  int get code => _code;

  String get message => _message;
}
