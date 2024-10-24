class UserSession {
  UserSession._internal();

  static final UserSession _instance = UserSession._internal();

  factory UserSession() {
    return _instance;
  }

  String? _userId = "user1";
  String? _email;
  String? _password;
  String? _name;

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

  void setUserName(String name) {
    _name = name;
  }

  String? getUserName() {
    return _name;
  }

  void logout() {
    _userId = null;
  }
}
