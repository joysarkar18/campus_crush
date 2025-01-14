import 'package:campus_crush/core/color_scheme.dart';
import 'package:campus_crush/modules/login/bloc/login_bloc.dart';
import 'package:campus_crush/routes/app_pages.dart';
import 'package:campus_crush/services/snackbar_service.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<LoginBloc>(
          create: (BuildContext context) => LoginBloc(),
        ),
      ],
      child: MaterialApp.router(
        title: 'Campus Crush',
        scaffoldMessengerKey: SnackbarService.snackbarKey,
        routerConfig: router,
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          colorScheme: ColorScheme.fromSeed(seedColor: AppColors.primaryBlue),
          useMaterial3: true,
        ),
      ),
    );
  }
}
