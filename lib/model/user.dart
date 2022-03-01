class User {
  String name;
  int city;
  int type;
  String phone;
  String email;
  String first;
  String second;

  User(
      {this.name,
      this.city,
      this.type,
      this.phone,
      this.email,
      this.first,
      this.second});



  Map<String, dynamic> toJson() => {
        "email": email,
        "plainPassword": {'first': first, 'second': second},
        "name": name,
        "type": type,
        "phone": phone,
        "city": city,
      };
}
