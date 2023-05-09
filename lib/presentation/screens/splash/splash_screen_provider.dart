import 'package:flutter/material.dart';
import 'package:health_connection/components/globle_variables.dart';
import 'package:health_connection/routes/app_pages.dart';

class SplashScreenProvider extends ChangeNotifier {
  Future checkUserStatus() async {
    if (await storage.read('isLoggedIn') == true &&
        await storage.read('user_id') != null) {
      Navigator.of(navigatorKey.currentContext!).pushNamedAndRemoveUntil(
          Routes.homeScreen, (Route<dynamic> route) => false);
    } else {
      await Navigator.of(navigatorKey.currentContext!)
          .pushReplacementNamed(Routes.login);
      // Navigator.of(navigatorKey.currentContext!).pushNamedAndRemoveUntil(
      //     Routes.loginScreen, (Route<dynamic> route) => false);
    }
  }

  void disposeValues() {}
}
