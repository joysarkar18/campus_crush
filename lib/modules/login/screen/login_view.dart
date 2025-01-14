import 'dart:io';
import 'package:campus_crush/constants/assets.dart';
import 'package:campus_crush/core/app_text_styles.dart';
import 'package:campus_crush/core/color_scheme.dart';
import 'package:campus_crush/core/screen_responsive.dart';
import 'package:campus_crush/modules/login/bloc/login_bloc.dart';
import 'package:campus_crush/modules/login/bloc/login_event.dart';
import 'package:campus_crush/modules/login/bloc/login_state.dart';
import 'package:campus_crush/modules/login/data/repo/otp_less_repo.dart';
import 'package:campus_crush/modules/login/screen/widgets/circular_app_logo.dart';
import 'package:campus_crush/modules/login/screen/widgets/resend_otp_button.dart';
import 'package:campus_crush/routes/app_routes.dart';
import 'package:campus_crush/services/exception_service.dart';
import 'package:campus_crush/services/loading_overlay.dart';
import 'package:campus_crush/services/logger_service.dart';
import 'package:campus_crush/services/login_manager.dart';
import 'package:campus_crush/services/snackbar_service.dart';
import 'package:campus_crush/widgets/submit_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:go_router/go_router.dart';
import 'package:pinput/pinput.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final TextEditingController _phoneNoController = TextEditingController();
  final _otplessRepository = OtplessRepository();
  final TextEditingController _otpController = TextEditingController();
  bool isSms = false;

  void onHeadlessResult(dynamic result) {
    if (result['statusCode'] == 200) {
      LoadingOverlay().hide();
      switch (result['responseType'] as String) {
        case 'INITIATE':
          {
            LoggerService.logInfo("OTP SENT");
            context.read<LoginBloc>().add(OtpSentEvent());
          }
          break;

        case 'OTP_AUTO_READ':
          {
            if (Platform.isAndroid) {
              var otp = result['response']['otp'] as String;
              LoggerService.logInfo("Otp res $otp");
            }
          }

        case 'ONETAP':
          {
            LoadingOverlay().hide();
            final response = result["response"];
            LoggerService.logInfo("OTP Verified Result $response");
            LoginManager.setLoginState(
                userId: result["response"]["userId"],
                phoneNo: "+91${_phoneNoController.text.trim()}");
            context.goNamed(Names.onboarding);
          }
          break;
      }
    } else {
      LoadingOverlay().hide();
      SnackbarService.showErrorSnackBar(
          message: MyCrashException(
              "Something Went Wrong!  on otpless login screen ${result['response']} $result "));
    }
  }

  @override
  void initState() {
    super.initState();
    _otplessRepository.setHeadlessCallback(onHeadlessResult);
  }

  void sendLoginRequest({required bool isSms}) {
    final phoneNo = _phoneNoController.text.trim();
    LoadingOverlay().show(context);
    _otplessRepository.sendOtp(
        phoneNo: phoneNo,
        onHeadlessResult: onHeadlessResult,
        context: context,
        isSms: isSms);
  }

  void verifyOtp() {
    LoadingOverlay().show(context);
    final otp = _otpController.text.trim();
    final phoneNo = _phoneNoController.text.trim();

    if (otp.length == 4) {
      // Call OTP verification logic from the repository
      _otplessRepository.verifyOtp(
        phoneNo: phoneNo,
        otp: otp,
        onHeadlessResult: onHeadlessResult,
      );
    } else {
      LoadingOverlay().hide();
      SnackbarService.showErrorSnackBar(
          message: MyCustomException("Invalid OTP!"));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        resizeToAvoidBottomInset: false,
        body: SafeArea(
            child: SizedBox(
          width: context.screenWidth,
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: BlocBuilder<LoginBloc, LoginState>(
              builder: (context, state) {
                return Column(
                  children: [
                    SizedBox(
                      height: context.screenHeight * 0.03,
                    ),
                    CircularAppLogo(),
                    Text(
                      "Campus Crush",
                      style: AppTextStyles.monserrat900(
                          height: 2, color: AppColors.darkFade, fontSize: 30),
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    if (state is LoginInitial)
                      Row(
                        children: [
                          Text(
                            " What's your phone number?",
                            style: AppTextStyles.monserrat600(
                              fontSize: 16,
                              height: 3,
                              color: AppColors.darkFade,
                            ),
                          ),
                        ],
                      ),
                    if (state is LoginInitial)
                      Row(
                        children: [
                          Expanded(
                            child: TextField(
                              controller: _phoneNoController,
                              keyboardType: TextInputType.phone,
                              style: AppTextStyles.monserrat600(
                                  fontSize: 16,
                                  color: AppColors.darkFade,
                                  letterSpacing: 1),
                              decoration: InputDecoration(
                                prefixIcon: SizedBox(
                                  width: 40,
                                  child: Center(
                                    child: Text(
                                      "+91",
                                      style: AppTextStyles.monserrat600(
                                        fontSize: 16,
                                        height: 1,
                                        color: AppColors.darkFade,
                                      ),
                                    ),
                                  ),
                                ),
                                hintStyle: AppTextStyles.monserrat500(
                                    fontSize: 15, color: AppColors.darkFade),
                                focusedBorder: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(8),
                                    borderSide: BorderSide(
                                        color: AppColors.darkFade, width: 2)),
                                enabledBorder: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(8),
                                    borderSide:
                                        BorderSide(color: AppColors.darkFade)),
                                hintText: "Enter your phone number",
                              ),
                            ),
                          ),
                        ],
                      ),
                    if (state is LoginInitial)
                      SizedBox(
                        height: 20,
                      ),
                    if (state is LoginInitial)
                      SubmitButton(
                        onTap: () {
                          if (_phoneNoController.text.trim().isNotEmpty &&
                              _phoneNoController.text.trim().length == 10) {
                            isSms = false;
                            sendLoginRequest(isSms: isSms);
                          } else {
                            SnackbarService.showErrorSnackBar(
                                message:
                                    MyCustomException("Invalid Phone Number"));
                          }
                        },
                        icon: SvgPicture.asset(
                          Assets.iconsWhatsAppIcon,
                          width: 20,
                        ),
                        lable: "Continue with WhatsApp",
                      ),
                    if (state is LoginInitial)
                      Padding(
                        padding: const EdgeInsets.all(10.0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Expanded(
                                child: Divider(
                              color: AppColors.deepBlue,
                            )),
                            Text(
                              "  or  ",
                              style: AppTextStyles.monserrat600(),
                            ),
                            Expanded(
                                child: Divider(
                              color: AppColors.deepBlue,
                            )),
                          ],
                        ),
                      ),
                    if (state is LoginInitial)
                      SubmitButton(
                        onTap: () {
                          if (_phoneNoController.text.trim().isNotEmpty &&
                              _phoneNoController.text.trim().length == 10) {
                            isSms = true;
                            sendLoginRequest(isSms: isSms);
                          } else {
                            SnackbarService.showErrorSnackBar(
                                message:
                                    MyCustomException("Invalid Phone Number"));
                          }
                        },
                        lable: "Verify with SMS",
                      ),
                    if (state is OtpSentState)
                      Text(
                        "OTP Verification +91-${_phoneNoController.text.trim()}",
                        style: AppTextStyles.monserrat600(
                          fontSize: 16,
                          height: 3,
                          color: AppColors.darkFade,
                        ),
                      ),
                    if (state is OtpSentState)
                      Pinput(
                        length: 4,
                        controller: _otpController,
                        defaultPinTheme: PinTheme(
                          height: 60,
                          width: 60,
                          margin: EdgeInsets.all(6),
                          textStyle: AppTextStyles.monserrat600(
                              fontSize: 20, color: AppColors.deepBlue),
                          decoration: BoxDecoration(
                            border: Border.all(color: AppColors.darkFade),
                            borderRadius: BorderRadius.circular(5),
                          ),
                        ),
                      ),
                    if (state is OtpSentState)
                      SizedBox(
                        height: 5,
                      ),
                    if (state is OtpSentState)
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            "Didn't get the OTP?",
                            style: AppTextStyles.monserrat500(fontSize: 13),
                          ),
                          ResendOtpButton(
                            sentOtp: () {
                              sendLoginRequest(isSms: isSms);
                            },
                          ),
                        ],
                      ),
                    if (state is OtpSentState)
                      SizedBox(
                        height: 20,
                      ),
                    if (state is OtpSentState)
                      SubmitButton(
                        onTap: () {
                          if (_otpController.text.trim().length == 4) {
                            verifyOtp();
                          } else {
                            SnackbarService.showErrorSnackBar(
                                message: MyCustomException("Invalid OTP!"));
                          }
                        },
                        lable: "Verify OTP",
                      ),
                  ],
                );
              },
            ),
          ),
        )));
  }
}
