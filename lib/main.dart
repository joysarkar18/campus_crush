import 'package:campus_crush/app.dart';
import 'package:campus_crush/firebase_options.dart';
import 'package:campus_crush/services/login_manager.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  await LoginManager.updateLoginState();
  SystemChrome.setSystemUIOverlayStyle(
    const SystemUiOverlayStyle(
      statusBarColor: Colors.transparent, // Makes status bar transparent
      statusBarIconBrightness: Brightness.dark, // Sets text and icons to black
    ),
  );
  runApp(const MyApp());
}
