import 'package:campus_crush/services/exception_service.dart';
import 'package:campus_crush/services/snackbar_service.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SingleLoginService {
  // Private constructor
  SingleLoginService._internal();

  // Single instance of the class
  static final SingleLoginService _instance = SingleLoginService._internal();

  // Factory constructor to return the same instance
  factory SingleLoginService() {
    return _instance;
  }

  Future<void> updateSessionId() async {
    try {
      final prefs = await SharedPreferences.getInstance();
      String sessionId = DateTime.now().millisecondsSinceEpoch.toString();
      prefs.setString('sessionId', sessionId);
      // if (DriverService.instance.driverModel == null) {
      //   await DriverService.instance.loadDriverModel();
      // }
      // await DriverService.instance.updateDriverField("sessionId", sessionId);
    } catch (e) {
      SnackbarService.showErrorSnackBar(
          message: MyCrashException("${e}single device login error"));
    }
  }

  Future<bool> verifySession() async {
    try {
      final prefs = await SharedPreferences.getInstance();
      String localSessionId = prefs.getString('sessionId') ?? "";
      if (localSessionId.isEmpty) {
        return false;
      }
      // if (DriverService.instance.driverModel == null) {
      //   await DriverService.instance.loadDriverModel();
      // }
      // if (localSessionId == DriverService.instance.driverModel!.sessionId) {
      //   return true;
      // }
      return false;
    } catch (e) {
      SnackbarService.showErrorSnackBar(
          message: MyCrashException("${e}Single device login error"));
      return false;
    }
  }
}
