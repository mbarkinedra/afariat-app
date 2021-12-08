class User {
  String name;
  int city;
  int type;
  String phone;
  String email;
  String plainPassword;

  User(
      {this.name,
      this.city,
      this.type,
      this.phone,
      this.email,
      this.plainPassword});
/*  Map<String, dynamic> toMap() {
    return {
      'name': this.name,
      'city': this.city,
      'type': this.type,
      'phone': this.phone,
      'email': this.email,
      'plainPassword': this.plainPassword,
    };
  }*/

  @override
  Map<String, dynamic> toJson() => {
        'email': email,
        'plainPassword': {'first': plainPassword, 'second': plainPassword},
        'name': name,
        'type': type,
        'phone': phone,
        'city': city,
      };

}
