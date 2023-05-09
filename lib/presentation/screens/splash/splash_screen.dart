import 'package:flutter/material.dart';
import 'package:health_connection/components/globle_variables.dart';
import 'package:health_connection/components/ui_helper.dart';
import 'package:health_connection/presentation/screens/splash/splash_screen_provider.dart';
import 'package:health_connection/themes/colors.dart';

import 'package:provider/provider.dart';

class SplashScreen extends StatelessWidget {
  const SplashScreen({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    context.read<SplashScreenProvider>().checkUserStatus();
    return Scaffold(
      backgroundColor: AppColors.whiteColor,
      body: Center(
        child: Center(
            child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset(
              appIcon,
              height: 150,
            ),
            UIHelper.verticalSpaceLarge(),
            const Text(
              'My Holiday Home',
              textAlign: TextAlign.center,
              style: TextStyle(
                  fontSize: 40,
                  fontWeight: FontWeight.w500,
                  color: AppColors.appColor),
            ),
            UIHelper.verticalSpaceExtraSmall(),
            const Text(
              'Holiday home management made easy!',
              textAlign: TextAlign.center,
              style: TextStyle(fontSize: 20, color: AppColors.appColor),
            ),
          ],
        )),
      ),
    );
  }
}
