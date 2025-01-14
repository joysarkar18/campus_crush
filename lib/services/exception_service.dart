class MyCustomException implements Exception {
  final String message;

  MyCustomException(this.message);

  @override
  String toString() {
    return message;
  }
}

class MyCrashException implements Exception {
  final String message;

  MyCrashException(this.message);

  @override
  String toString() {
    return "CustomException: $message";
  }
}
