abstract class Routes {
  static const login = _Paths.login;
  static const onboarding = _Paths.onboarding;
  Routes._();
}

abstract class _Paths {
  static const login = '/login';
  static const onboarding = '/';
  _Paths._();
}

abstract class _Names {
  static const login = 'login';
  static const onboarding = 'onboarding';
  _Names._();
}

abstract class Names {
  static const login = _Names.login;
  static const onboarding = _Names.onboarding;
  Names._();
}
