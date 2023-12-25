import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pre/modules/chat/chat_detailse_screen.dart';

import 'layout/app_layout.dart';
import 'layout/cupit/app_cubit.dart';
import 'modules/app_login/app_login_screen.dart';
import 'modules/app_login/cupit/login_cubit.dart';
//import 'modules/chat_details/chat_details_screen.dart';
import 'modules/edit_profile/edit_profile_screen.dart';
import 'modules/on_boarding.dart';
import 'modules/risgister/cupit/register_cubit.dart';
import 'modules/risgister/risgister.dart';
import 'shared/services/local/cache_data.dart';

class AppRouter {
  static const String startScreen = '/';
  static const String onBoardingScreen = '/boarding';
  static const String loginScreen = '/login';
  static const String registerScreen = '/register';
  static const String homeLayoutScreen = '/home';
  static const String searchScreen = '/search';
  static const String editProfileScreen = '/edit-Profile';
  static const String chatDetailsScreen = '/chat-details';

  static final AppCubit _AppCubit = AppCubit();
  void dispose() {
    _AppCubit.close();
  }

  Route? generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case startScreen:
        return _startScreen();
      case onBoardingScreen:
        return _goToOnBoardingScreen();
      case loginScreen:
        return _goToLoginScreen();
      case registerScreen:
        return _goToRegisterScreen();
      case homeLayoutScreen:
        return _goToHomeLayoutScreen();
      case editProfileScreen:
        return _goToEditProfileScreen();
      case chatDetailsScreen:
        return _goToChatDetailsScreen(settings);

      default:
        return _startScreen();
    }
  }

  MaterialPageRoute<dynamic> _startScreen() {
    if (onBoarding == true) {
      if (ISLOGIN == true) {
        return _goToHomeLayoutScreen();
      } else {
        return _goToLoginScreen();
      }
    } else {
      return _goToOnBoardingScreen();
    }
  }

  MaterialPageRoute<dynamic> _goToOnBoardingScreen() {
    return MaterialPageRoute(
      builder: (_) => OnBoardingScreen(),
    );
  }

  MaterialPageRoute<dynamic> _goToLoginScreen() {
    return MaterialPageRoute(
      builder: (_) => BlocProvider(
        create: (context) => LoginCubit(),
        child: LoginScreen(),
      ),
    );
  }

  MaterialPageRoute<dynamic> _goToRegisterScreen() {
    return MaterialPageRoute(
      builder: (_) => BlocProvider(
        create: (context) => RegisterCubit(),
        child: RegisterScreen(),
      ),
    );
  }

  MaterialPageRoute<dynamic> _goToHomeLayoutScreen() {
    return MaterialPageRoute(builder: (_) => const HomeLayoutScreen());
  }

  static MaterialPageRoute<dynamic> _goToEditProfileScreen() {
    return MaterialPageRoute(builder: (_) => const EditProfileScreen());
  }

  static MaterialPageRoute<dynamic> _goToChatDetailsScreen(settings) {
    final chatUser = settings.arguments;

    return MaterialPageRoute(
      builder: (_) => const ChatDetailsScreen(
          //  chatUser: chatUser,
          ),
    );
  }
}
