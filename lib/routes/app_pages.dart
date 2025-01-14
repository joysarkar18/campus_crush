import 'package:campus_crush/modules/login/screen/login_view.dart';
import 'package:campus_crush/modules/onboarding/screen/onboarding_view.dart';
import 'package:campus_crush/routes/app_routes.dart';
import 'package:campus_crush/services/login_manager.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

// GoRouter configuration
final router = GoRouter(
  initialLocation: LoginManager.isLogin ? "/" : '/login',
  navigatorKey:
      GlobalNavigation.instance.navigatorKey, // Use the global key here
  routes: [
    GoRoute(
      name: Names.login,
      path: Routes.login,
      builder: (context, state) => const LoginScreen(),
    ),
    GoRoute(
      name: Names.onboarding,
      path: Routes.onboarding,
      builder: (context, state) => const OnboardingScreen(),
    ),
  ],
);

class GlobalNavigation {
  static final GlobalNavigation instance = GlobalNavigation._internal();
  GlobalNavigation._internal();

  final GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();
}
