import 'package:flutter/material.dart';
import 'package:health_connection/components/ui_helper.dart';
import 'package:health_connection/components/widget_size.dart';
import 'package:health_connection/routes/app_pages.dart';
import 'package:health_connection/themes/colors.dart';

class SignUpSuccessScreen extends StatelessWidget {
  final String? title;
  final String? body;
  final String? icon;

  const SignUpSuccessScreen(
      {super.key, required this.title, required this.body, required this.icon});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.whiteColor,
      body: SafeArea(
        child: Center(
          child: Column(
            children: [
              UIHelper.verticalSpaceDoubleExtraLarge(),
              UIHelper.verticalSpaceDoubleExtraLarge(),
              UIHelper.verticalSpaceDoubleExtraLarge(),
              Image.asset(
                icon ?? '',
                height: 100,
                width: 100,
                color: AppColors.appColor,
              ),
              // Icon(
              //   Icons.check_circle,
              //   color: Colors.green,
              //   size: 100,
              // ),
              UIHelper.verticalSpaceExtraLarge(),
              Text(
                title ?? '',
                style: const TextStyle(
                    fontSize: 28,
                    fontWeight: FontWeight.bold,
                    color: AppColors.blackColor),
              ),
              UIHelper.verticalSpaceExtraSmall(),
              Text(
                body ?? '',
                textAlign: TextAlign.center,
                style: const TextStyle(
                  fontSize: 20,
                  color: AppColors.veryDarkGreyColor,
                ),
              ).marginZero,

              UIHelper.verticalSpaceExtraLarge(),
              Center(
                child: ElevatedButton(
                    onPressed: () {
                      ///TODO: Dispose provider

                      Navigator.of(context).pushNamedAndRemoveUntil(
                          Routes.login, (Route<dynamic> route) => false);
                    },
                    style: ButtonStyle(
                        elevation: MaterialStateProperty.all(3),
                        minimumSize: MaterialStateProperty.all(
                            const Size.fromHeight(50)),
                        backgroundColor:
                            MaterialStateProperty.all(AppColors.appColor),
                        shape:
                            MaterialStateProperty.all<RoundedRectangleBorder>(
                                RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(50.0),
                        ))),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const Text("Login",
                            style: TextStyle(
                                fontSize: 20,
                                fontWeight: FontWeight.normal,
                                color: AppColors.whiteColor)),
                        UIHelper.horizontalSpaceSmall(),
                        const Icon(
                          Icons.arrow_circle_right_outlined,
                          color: AppColors.whiteColor,
                        )
                      ],
                    )),
              ),
            ],
          ).paddingAll(20),
        ),
      ),
    );
  }
}
