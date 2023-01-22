class SignUpModel {
  String name;
  String email;
  String phone;
  String password2;
  String password;
  bool is_driver;
  bool is_admin;

  SignUpModel(
      {this.name,
      this.password2,
      this.phone,
      this.email = '',
      this.password,
      this.is_admin,
      this.is_driver});

  SignUpModel.fromJson(Map<String, dynamic> json) {
    name = json['name'];
    password2 = json['password2'];
    phone = json['phone_number'];
    email = json['email'];
    password = json['password'];
    is_admin = json['is_admin'];
    is_driver = json['is_driver'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['name'] = this.name;
    data['password2'] = this.password2;
    data['phone_number'] = this.phone;
    data['email'] = this.email;
    data['password'] = this.password;
    data['is_driver'] = this.is_driver;
    data['is_admin'] = this.is_admin;
    return data;
  }
}
