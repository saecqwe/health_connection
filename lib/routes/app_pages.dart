import 'package:flutter/material.dart';
import 'package:health_connection/presentation/screens/activity_scale_screen.dart/activity_scale_screen.dart';
import 'package:health_connection/presentation/screens/forget_password/forgot_password_screen.dart';
import 'package:health_connection/presentation/screens/home/home_screen.dart';
import 'package:health_connection/presentation/screens/login/login_screen.dart';
import 'package:health_connection/presentation/screens/onboarding/signup_screen.dart';
import 'package:health_connection/presentation/screens/splash/splash_screen.dart';

import '../presentation/screens/activity_scale_screen.dart/activity_explanation_screen.dart';

part 'app_routes.dart';

class AppPages {
  AppPages._();
  static Route<dynamic> onGenerateRoute(RouteSettings settings) {
    return MaterialPageRoute(
        settings: settings,
        builder: (_) {
          switch (settings.name) {
            case Routes.homeScreen:
              return  HomeScreen();
            case Routes.login:
              return const LoginScreen();
            case Routes.splashScreen:
              return const SplashScreen();
            case Routes.signup:
              return const SignupScreen();
            case Routes.forgotPassword:
              return ForgotPasswordScreen();
            case Routes.activityScale:
              return const ActivityScaleScreen();
            case Routes.activityExplanation:
              return const ActivityExplanationScreen();
            default:
              return  HomeScreen();
          }
        });
  }
}
