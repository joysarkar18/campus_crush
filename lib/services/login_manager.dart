import 'package:campus_crush/services/logger_service.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LoginManager {
  static final LoginManager _instance = LoginManager._internal();
  LoginManager._internal();

  factory LoginManager() {
    return _instance;
  }

  static String? userId;
  static bool isLogin = false;
  static String? phoneNo;

  // Update login state
  static Future<void> updateLoginState() async {
    try {
      final prefs = await SharedPreferences.getInstance();
      String? currentUserId = prefs.getString("userId");
      bool? currentIsLogin = prefs.getBool("isLogin");
      String? currentPhoneNo = prefs.getString("phoneNo");
      userId = currentUserId ?? "";
      isLogin = currentIsLogin ?? false;
      phoneNo = currentPhoneNo ?? "";
      LoggerService.logInfo("UserId: $userId");
      LoggerService.logInfo("IsLogin: $isLogin");
      LoggerService.logInfo("PhoneNo: $phoneNo");
    } catch (e) {
      userId = null;
      isLogin = false;
    }
  }

  static Future<void> setLoginState({
    required String userId,
    required String phoneNo,
  }) async {
    try {
      final prefs = await SharedPreferences.getInstance();
      bool isUserIdUpdated = await prefs.setString("userId", userId);
      bool isLoginUpdated = await prefs.setBool("isLogin", true);
      bool isPhoneNoUpdated = await prefs.setString("phoneNo", phoneNo);
      LoggerService.logInfo("UserId: $userId");
      LoggerService.logInfo("IsLogin: $isPhoneNoUpdated");
      LoggerService.logInfo("PhoneNo: $phoneNo");

      if (isUserIdUpdated && isLoginUpdated && isPhoneNoUpdated) {
        LoggerService.logInfo("Login Successful");
      }
    } catch (e) {
      userId = "";
      isLogin = false;
    }
  }

  // Get login status
  bool getLoginStatus() {
    return isLogin;
  }

  // Get current user ID
  String? getUserId() {
    return userId;
  }

  // Logout user
  Future<void> logout() async {
    final prefs = await SharedPreferences.getInstance();
    prefs.clear();
    LoggerService.logInfo("User logged out");
  }

  // Get all user data
  Future<void> getAllData() async {
    await updateLoginState();
  }

  // Clear login status, JWT token, and user ID (logout)
  Future<void> clearLoginStatus() async {}
}
