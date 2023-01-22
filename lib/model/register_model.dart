class RegisterModel {
  int _code;

  String _msg;
  Token _token;
  User _user;

  RegisterModel({int code, String msg, Token token, User user}) {
    this._code = code;
    this._token = token;
    this._msg = msg;
    this._user = user;
  }

  String get msg => _msg;
  int get code => _code;
  Token get token => _token;
  User get user => _user;

  RegisterModel.fromJson(Map<String, dynamic> json) {
    _code = json['code'];
    _token = json['token'] != null ? Token.fromJson(json['token']) : null;
    _user = json['user'] != null ? User.fromJson(json['user']) : null;
    _msg = json['msg'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['code'] = this._code;
    if (this._token != null) {
      data['token'] = this._token.toJson();
    }
    if (this._user != null) {
      data['user'] = this._user.toJson();
    }

    data['msg'] = this._msg;
    return data;
  }
}

class Token {
  String _access;

  String _refresh;

  Token({String access, String refresh}) {
    this._access = access;
    this._refresh = refresh;
  }
  String get access => _access;
  String get refresh => _refresh;

  Token.fromJson(Map<String, dynamic> json) {
    _access = json['access'];
    _refresh = json['refresh'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['access'] = this._access;
    data['refresh'] = this._refresh;
    return data;
  }
}

class User {
  bool _is_admin;

  bool _tc;

  String _birthDate;
  String _name;
  String _phone;
  String _email;

  User(
      {String birthDate,
      bool tc,
      bool is_admin,
      String name,
      String phone,
      String email}) {
    this._is_admin = is_admin;
    this._tc = tc;
    this._birthDate = birthDate;
    this._name = name;
    this._phone = phone;
    this._email = email;
  }

  bool get is_admin => _is_admin;
  bool get tc => _tc;
  String get birthDate => _birthDate;
  String get name => _name;
  String get phone => _phone;
  String get email => _email;

  User.fromJson(Map<String, dynamic> json) {
    _tc = json['tc'];
    _is_admin = json['is_admin'];
    _birthDate = json['birthdate'];
    _name = json['name'];
    _phone = json['phone'];
    _email = json['email'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['tc'] = this._tc;
    data['is_admin'] = this._is_admin;
    data['birthdate'] = this._birthDate;
    data['name'] = this._name;
    data['phone'] = this._phone;
    data['email'] = this._email;
    return data;
  }
}
