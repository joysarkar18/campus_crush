import 'package:campus_crush/core/app_text_styles.dart';
import 'package:campus_crush/core/color_scheme.dart';
import 'package:flutter/material.dart';

class ResendOtpButton extends StatefulWidget {
  const ResendOtpButton({super.key, required this.sentOtp});
  final Function sentOtp;

  @override
  State<ResendOtpButton> createState() => _ResendOtpButtonState();
}

class _ResendOtpButtonState extends State<ResendOtpButton> {
  int _remainingTime = 30;
  bool _isTimerActive = false;
  bool _isDisposed = false;

  @override
  void initState() {
    super.initState();
    _startTimer();
  }

  @override
  void dispose() {
    _isDisposed = true;
    super.dispose();
  }

  void _startTimer() {
    setState(() {
      _remainingTime = 30;
      _isTimerActive = true;
    });

    Future.doWhile(() async {
      if (_remainingTime > 0) {
        await Future.delayed(const Duration(seconds: 1));
        if (!_isDisposed) {
          setState(() {
            _remainingTime--;
          });
        }
        return true;
      } else {
        if (!_isDisposed) {
          setState(() {
            _isTimerActive = false;
          });
        }
        return false;
      }
    });
  }

  void _handleResend() {
    _startTimer();
    widget.sentOtp();
  }

  @override
  Widget build(BuildContext context) {
    return TextButton(
      onPressed: _isTimerActive
          ? null
          : () {
              _handleResend();
            },
      child: Text(
        _isTimerActive ? "Resend OTP in $_remainingTime sec." : "Resend OTP",
        style: AppTextStyles.monserrat500(
          fontSize: 14,
          color: _isTimerActive ? AppColors.myBlack45 : AppColors.deepBlue,
        ),
      ),
    );
  }
}
