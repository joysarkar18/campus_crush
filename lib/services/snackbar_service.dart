import 'package:campus_crush/core/app_text_styles.dart';
import 'package:campus_crush/core/color_scheme.dart';
import 'package:campus_crush/services/exception_service.dart';
import 'package:flutter/material.dart';

class SnackbarService {
  static final GlobalKey<ScaffoldMessengerState> snackbarKey =
      GlobalKey<ScaffoldMessengerState>();

  static showErrorSnackBar({required Exception message}) {
    if (message is MyCustomException) {
      final snackBar = SnackBar(
        content: Text(
          message.toString(),
          style: AppTextStyles.monserrat500(color: Colors.white),
        ),
        backgroundColor: const Color.fromARGB(255, 214, 58, 46),
      );
      snackbarKey.currentState?.showSnackBar(snackBar);
    } else {
      final snackBar = SnackBar(
        content: Text(
          "Something went wrong!",
          style: AppTextStyles.monserrat500(color: Colors.white),
        ),
        backgroundColor: const Color.fromARGB(255, 214, 58, 46),
      );
      snackbarKey.currentState?.showSnackBar(snackBar);
      throw message;
    }
  }

  static showSuccessSnackBar({required String message}) {
    final snackBar = SnackBar(
      content: Text(
        message,
        style: AppTextStyles.monserrat500(color: Colors.white),
      ),
      backgroundColor: AppColors.primaryBlue,
    );
    snackbarKey.currentState?.showSnackBar(snackBar);
  }

  static dismissSnackBar() {
    snackbarKey.currentState?.hideCurrentSnackBar();
  }
}
