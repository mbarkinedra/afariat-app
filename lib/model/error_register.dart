class ErrorRegister {
  List<String> errors;
  Email email;
  Email phone;

  ErrorRegister({this.errors, this.email, this.phone});

  ErrorRegister.fromJson(Map<String, dynamic> json) {
    errors = json['errors'] ;
    email = json['email'] != null ? new Email.fromJson(json['email']) : null;
    phone = json['phone'] != null ? new Email.fromJson(json['phone']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['errors'] = this.errors;
    if (this.email != null) {
      data['email'] = this.email.toJson();
    }
    if (this.phone != null) {
      data['phone'] = this.phone.toJson();
    }
    return data;
  }
}

class Email {
  List<String> errors;

  Email({this.errors});

  Email.fromJson(Map<String, dynamic> json) {
    errors = json['errors'].cast<String>();
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['errors'] = this.errors;
    return data;
  }
}
