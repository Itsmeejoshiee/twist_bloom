class UserSession {
  UserSession._internal();

  static final UserSession _instance = UserSession._internal();

  factory UserSession() {
    return _instance;
  }

  String? userId;

  void setUserId(String id) {
    userId = id;
  }

  String? getUserId() {
    return userId;
  }

  void logout() {
    userId = null;
  }
}
