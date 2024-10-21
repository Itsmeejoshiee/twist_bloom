class UserSession {
  UserSession._internal();

  static final UserSession _instance = UserSession._internal();

  factory UserSession() {
    return _instance;
  }

  String? _userId;
  String? _email;
  String? _password;

  void setUserId(String id) {
    _userId = id;
  }

  String? getUserId() {
    return _userId;
  }

  void setEmail(String email) {
    _email = email;
  }

  String? getEmail() {
    return _email;
  }

  void setPassword(String password) {
    _password = password;
  }

  String? getPassword() {
    return _password;
  }
}
