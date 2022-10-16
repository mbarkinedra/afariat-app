/// this Class is used to describe the post json response
class PostJsonResponse {
  int _code;
  String _message;
  PostJsonResponseErrors _errors = PostJsonResponseErrors();

  PostJsonResponse.fromJson(Map<String, dynamic> json) {
    _code = json['code'];
    if (json['message'] != null) {
      if (json['message'] is String) {
        _message = json['message'].toString();
      } else {
        _errors = PostJsonResponseErrors.fromJson(json['message']);
      }
    }
  }

  Map<String, dynamic> toJson() {
    return <String, dynamic>{
      'code': _code,
      'message': _message,
      'errors': _errors.toJson(),
    };
  }

  @override
  String toString() => toJson().toString();

  bool hasErrors() => _errors.hasErrors();

  int get code => _code;

  String get message => _message;

  PostJsonResponseErrors get errors => _errors;
}

class PostJsonResponseErrors {
  List<dynamic> globalErrors = [];
  Map<String, PostJsonFieldError> fieldErrors = {};

  PostJsonResponseErrors();

  PostJsonResponseErrors.fromJson(Map<String, dynamic> json) {
    json.forEach((key, value) {
      if (key == 'errors') {
        globalErrors = value;
      } else {
        //field errors
        fieldErrors[key] = PostJsonFieldError.fromJson(value);
      }
    });
  }

  Map<String, dynamic> toJson() {
    return <String, dynamic>{
      'globalErrors': globalErrors,
      'fieldErrors': fieldErrors
    };
  }

  @override
  String toString() => toJson().toString();

  bool hasErrors() => globalErrors.isNotEmpty || fieldErrors.isNotEmpty;

  bool hasField(String fieldName) => fieldErrors.containsKey(fieldName);

  PostJsonFieldError getField(String fieldName) {
    if (!fieldErrors.containsKey(fieldName)) {
      return null;
    }
    return fieldErrors[fieldName];
  }
}

class PostJsonFieldError {
  List<String> errors = [];

  PostJsonFieldError.fromJson(Map<String, dynamic> json) {
    if (json['errors'] != null) {
      List err = json['errors'];
      for (var errorMessage in err) {
        errors.add(errorMessage);
      }
    }
  }

  Map<String, dynamic> toJson() {
    return <String, dynamic>{'errors': errors};
  }

  @override
  String toString() => toJson().toString();

  // Get the first error
  String first() {
    if (errors.isEmpty) {
      return null;
    }
    return errors.first;
  }
}
