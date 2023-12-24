// import 'package:firebase_core/firebase_core.dart';
// import 'package:flutter/material.dart';
// import 'package:pre/app_router.dart';
// import 'package:pre/layout/cupit/app_cubit.dart';
// import 'package:pre/shared/services/local/cache_data.dart';
// import 'firebase_options.dart';
// import 'shared/services/local/cahce_helper.dart';
// import 'shared/styles/mylight_theme.dart';
//
// void main() async {
//   WidgetsFlutterBinding.ensureInitialized();
//   await CacheHelper.init();
//   await Firebase.initializeApp(
//     options: DefaultFirebaseOptions.currentPlatform,
//   );
//
//   isDarkFromShared = CacheHelper.getCacheData(key: 'isDark');
//   onBoarding = CacheHelper.getCacheData(key: 'onBoarding');
//   token = CacheHelper.getCacheData(key: 'token');
//   runApp( MyApp(isDarkFromShared: isDarkFromShared,
//     appRouter: AppRouter(),));
// }
//
// class MyApp extends StatelessWidget {
//   final bool? isDarkFromShared;
//   final AppRouter appRouter;
//   const MyApp({super.key, this.isDarkFromShared, required this.appRouter});
//
//
//   @override
//   Widget build(BuildContext context) {
//     final AppRouter _appRouter = AppRouter();
//     return
//      MaterialApp(
//       debugShowCheckedModeBanner: false,
//       onGenerateRoute: _appRouter.generateRoute,
//       theme: myLightTheme(context),
//       themeMode: _themeMode(context),
//       onUnknownRoute: appRouter.generateRoute,
//     );
//   }
//   ThemeMode _themeMode(context) {
//     return AppCubit.get(context).isDark ? ThemeMode.dark : ThemeMode.light;
//   }
//   // ThemeMode _themeMode(context) {
//   //   final isDark = BlocProvider.of<AppCubit>(context).isDark;
//   //   return isDark ? ThemeMode.dark : ThemeMode.light;
//   // }
// }

import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pre/app_router.dart';
import 'package:pre/layout/cupit/app_cubit.dart';
import 'package:pre/modules/chat/chat_screen.dart';
import 'package:pre/shared/services/local/cache_data.dart';
import 'package:pre/shared/styles/my_dark_theme.dart';

import 'firebase_options.dart';
import 'shared/services/local/cahce_helper.dart';
import 'shared/styles/mylight_theme.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await CacheHelper.init();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  isDarkFromShared = CacheHelper.getCacheData(key: 'isDark');
  onBoarding = CacheHelper.getCacheData(key: 'onBoarding');
  token = CacheHelper.getCacheData(key: 'token');

  runApp(
    MyApp(
      isDarkFromShared: isDarkFromShared ?? false,
      appRouter: AppRouter(),
    ),
  );
}

class MyApp extends StatelessWidget {
  final bool isDarkFromShared;
  final AppRouter appRouter;

  const MyApp(
      {super.key, required this.isDarkFromShared, required this.appRouter});

  @override
  Widget build(BuildContext context) {
    // final AppRouter _appRouter = AppRouter();
    return MultiBlocProvider(
      providers: [
        _appcubit(),
      ],
      child: BlocConsumer<AppCubit, AppState>(
        listener: _listener,
        builder: _buildMaterialApp,
      ),
    );
  }

  BlocProvider<AppCubit> _appcubit() {
    return BlocProvider(
      create: (_) => AppCubit()
        ..saveAppModeInFirstLaunch(isDarkFromShared: isDarkFromShared),
    );
  }

  void _listener(context, state) {}

  MaterialApp _buildMaterialApp(BuildContext context, state) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      // onGenerateRoute: appRouter.generateRoute,
      themeMode: _themeMode(context),
      theme: myLightTheme(context),
      darkTheme: myDarkTheme(context),
      //  onUnknownRoute: appRouter.generateRoute,
      home: const ChatScreen(),
    );
  }

  ThemeMode _themeMode(context) {
    return AppCubit.get(context).isDark ? ThemeMode.dark : ThemeMode.light;
  }
}
