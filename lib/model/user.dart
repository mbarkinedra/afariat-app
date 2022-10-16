class User {
  String firstName;
  String lastName;
  int city;
  int type;
  String phone;
  String email;
  String first;
  String second;

  User(
      {this.firstName,
      this.lastName,
      this.city,
      this.type,
      this.phone,
      this.email,
      this.first,
      this.second});

  Map<String, dynamic> toJson() => {
        "email": email,
        "plainPassword": {'first': first, 'second': second},
        "firstName": firstName,
        "lastName": firstName,
        "type": type,
        "phone": phone,
        "city": city,
      };
}
