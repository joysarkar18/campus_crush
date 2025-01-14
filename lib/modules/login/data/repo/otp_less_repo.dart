import 'package:flutter/material.dart';
import 'package:otpless_flutter/otpless_flutter.dart';

class OtplessRepository {
  final _otplessFlutterPlugin = Otpless();
  OtplessRepository() {
    _otplessFlutterPlugin.initHeadless("53F1MC6XNHYQIAJG3TAL");
  }

  void setHeadlessCallback(Function(dynamic) onHeadlessResult) {
    _otplessFlutterPlugin.setHeadlessCallback(onHeadlessResult);
  }

  void sendOtp(
      {required String phoneNo,
      required BuildContext context,
      required bool isSms,
      required Function(dynamic) onHeadlessResult}) async {
    Map<String, dynamic> arg = {
      "phone": phoneNo,
      "countryCode": "+91",
      "deliveryChannel": isSms ? "SMS" : "WHATSAPP",
    };
    _otplessFlutterPlugin.startHeadless(onHeadlessResult, arg);
  }

  void verifyOtp({
    required String phoneNo,
    required String otp,
    required Function(dynamic) onHeadlessResult,
  }) {
    Map<String, dynamic> arg = {
      "phone": phoneNo,
      "countryCode": "+91",
      "otp": otp,
    };
    _otplessFlutterPlugin.startHeadless(onHeadlessResult, arg);
  }
}
