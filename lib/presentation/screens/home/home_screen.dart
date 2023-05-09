import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:health_connection/components/custom_buttons.dart';
import 'package:health_connection/components/globle_variables.dart';
import 'package:health_connection/components/widget_size.dart';
import 'package:health_connection/presentation/screens/Tasks/tasks.dart';
import 'package:health_connection/presentation/screens/activity_scale_screen.dart/activity_explanation_screen.dart';
import 'package:health_connection/presentation/screens/activity_scale_screen.dart/activity_scale_screen.dart';
import 'package:health_connection/routes/app_pages.dart';
import 'package:health_connection/utils/ui_helper.dart';
import 'package:health_connection/widgets/bouncing_widget.dart';
import 'package:provider/provider.dart';

import '../../../themes/colors.dart';
import '../activity_scale_screen.dart/activity_scale_provider.dart';

class HomeScreen extends StatelessWidget {
  final PageController pageController = PageController();

  HomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.whiteColor,
      appBar: AppBar(
          title: Row(
            children: [
              Image.asset(
                appIcon,
                height: 40,
              ),
              UIHelper.horizontalSpaceSmall(),
              const Text('Home Screen'),
            ],
          ),
          actions: [
            CustomButtons.customPopUpButton(popUpItem: [
              PopupMenuItem(
                onTap: () {
                  Future.delayed(Duration.zero, () {
                    showConfirmModal(context, "Do you want to logout?");
                  });
                },
                value: 1,
                // row has two child icon and text.
                child: Row(
                  children: const [
                    Icon(Icons.logout_rounded),
                    SizedBox(
                      // sized box with width 10
                      width: 10,
                    ),
                    Text("Logout")
                  ],
                ),
              ),
            ])
          ]),

      bottomNavigationBar: BottomNavigationBar(items: [
        BottomNavigationBarItem(
            label: "Previous",
            icon: IconButton(
              icon: const Icon(Icons.arrow_back_ios_new),
              onPressed: () {
                pageController.previousPage(
                    duration: const Duration(milliseconds: 300),
                    curve: Curves.easeInOut);
              },
            )),
        BottomNavigationBarItem(
            label: "Next",
            icon: IconButton(
              icon: const Icon(Icons.arrow_forward_ios),
              onPressed: () {
                if (pageController.page == 1.0) {
                  Provider.of<ActivityScaleProvider>(context, listen: false)
                      .uploadUserActivitiesToFirebase();
                } else if (pageController.page == 2.0) {
                  Provider.of<ActivityScaleProvider>(context, listen: false)
                      .uploadTasksToActivites();
                }
                pageController.nextPage(
                    duration: const Duration(milliseconds: 300),
                    curve: Curves.easeInOut);
              },
            ))
      ]),
      // body: SingleChildScrollView(
      //   child:
      //    Column(
      //     children: [
      //       Card(
      //         child: Column(
      //             crossAxisAlignment: CrossAxisAlignment.start,
      //             children: [
      //               Text(
      //                 "Health Connections Self-Prescription*",
      //                 style: basicStyle(
      //                     size: 26,
      //                     color: AppColors.greenColor,
      //                     fontWeight: FontWeight.w500),
      //               ),
      //               UIHelper.verticalSpaceMedium(),
      //               Text(
      //                 "Why ‘Health Connections’ and why ‘Self-Prescription’?",
      //                 style: basicStyle(
      //                     size: 22,
      //                     color: AppColors.blackColor,
      //                     fontWeight: FontWeight.w500),
      //               ),
      //               UIHelper.verticalSpaceSmall(),
      //               Text.rich(TextSpan(children: [
      //                 TextSpan(
      //                   text:
      //                       "Your health is not a simple yes / no or singular item, but rather it is an interconnected and interdependent concept that impacts your overall wellness and quality of life.  When efforts are made to invest in one aspect of your health it can also contribute to and be reciprocally related to positive gains in other areas of your health.  Exploring these ",
      //                   style: basicStyle(
      //                       size: 16,
      //                       color: AppColors.blackColor,
      //                       fontWeight: FontWeight.normal),
      //                 ),
      //                 TextSpan(
      //                   text: "Health Connections ",
      //                   style: basicStyle(
      //                       size: 16,
      //                       color: AppColors.blackColor,
      //                       fontWeight: FontWeight.bold),
      //                 ),
      //                 TextSpan(
      //                   text:
      //                       "and identifying how multiple areas of your health connect allows you to experience multidimensional health connection benefits.",
      //                   style: basicStyle(
      //                       size: 16,
      //                       color: AppColors.blackColor,
      //                       fontWeight: FontWeight.normal),
      //                 ),
      //               ])),
      //               UIHelper.verticalSpaceSmall(),
      //               Text.rich(TextSpan(children: [
      //                 TextSpan(
      //                   text: "The ",
      //                   style: basicStyle(
      //                       size: 16,
      //                       color: AppColors.blackColor,
      //                       fontWeight: FontWeight.normal),
      //                 ),
      //                 TextSpan(
      //                   text: "Self-Prescription ",
      //                   style: basicStyle(
      //                       size: 16,
      //                       color: AppColors.blackColor,
      //                       fontWeight: FontWeight.bold),
      //                 ),
      //                 TextSpan(
      //                   text:
      //                       "aspect allows you to intentionally plan for these health connections while allowing you to reflect on these experiences and feel good about the choices and investments you have made through these health connections.",
      //                   style: basicStyle(
      //                       size: 16,
      //                       color: AppColors.blackColor,
      //                       fontWeight: FontWeight.normal),
      //                 ),
      //               ])),
      //             ]).paddingAll(20),
      //       ),
      //       UIHelper.verticalSpace(100),
      //       BouncingWidget(
      //         animationDuration: const Duration(milliseconds: 1000),
      //         curve: Curves.ease,
      //         tweenBegin: 0.95,
      //         tweenEnd: 0.9,
      //         widgetToBounce: CustomButtons.customElevatedButton(
      //             onTap: () {
      //               pushPage(pageName: Routes.activityScale);
      //             },
      //             borderRadius: BorderRadius.circular(50),
      //             widget: SizedBox(
      //               height: 45,
      //               child: Row(
      //                 mainAxisAlignment: MainAxisAlignment.center,
      //                 children: [
      //                   Text(
      //                     "Let's Start",
      //                     style: basicStyle(
      //                         color: AppColors.whiteColor, size: 16),
      //                   ),
      //                   const Icon(
      //                     Icons.double_arrow_rounded,
      //                     color: Colors.white,
      //                   )
      //                 ],
      //               ),
      //             )),
      //       )
      //     ],
      //   ).paddingAll(20),

      // )
      body: PageView(
        controller: pageController,
        children: [
          Column(
            children: [
              Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
                Text(
                  "Health Connections Self-Prescription*",
                  style: basicStyle(
                      size: 26,
                      color: AppColors.greenColor,
                      fontWeight: FontWeight.w500),
                ),
                UIHelper.verticalSpaceMedium(),
                Text(
                  "Why ‘Health Connections’ and why ‘Self-Prescription’?",
                  style: basicStyle(
                      size: 22,
                      color: AppColors.blackColor,
                      fontWeight: FontWeight.w500),
                ),
                UIHelper.verticalSpaceSmall(),
                Text.rich(TextSpan(children: [
                  TextSpan(
                    text:
                        "Your health is not a simple yes / no or singular item, but rather it is an interconnected and interdependent concept that impacts your overall wellness and quality of life.  When efforts are made to invest in one aspect of your health it can also contribute to and be reciprocally related to positive gains in other areas of your health.  Exploring these ",
                    style: basicStyle(
                        size: 16,
                        color: AppColors.blackColor,
                        fontWeight: FontWeight.normal),
                  ),
                  TextSpan(
                    text: "Health Connections ",
                    style: basicStyle(
                        size: 16,
                        color: AppColors.blackColor,
                        fontWeight: FontWeight.bold),
                  ),
                  TextSpan(
                    text:
                        "and identifying how multiple areas of your health connect allows you to experience multidimensional health connection benefits.",
                    style: basicStyle(
                        size: 16,
                        color: AppColors.blackColor,
                        fontWeight: FontWeight.normal),
                  ),
                ])),
                UIHelper.verticalSpaceSmall(),
                Text.rich(TextSpan(children: [
                  TextSpan(
                    text: "The ",
                    style: basicStyle(
                        size: 16,
                        color: AppColors.blackColor,
                        fontWeight: FontWeight.normal),
                  ),
                  TextSpan(
                    text: "Self-Prescription ",
                    style: basicStyle(
                        size: 16,
                        color: AppColors.blackColor,
                        fontWeight: FontWeight.bold),
                  ),
                  TextSpan(
                    text:
                        "aspect allows you to intentionally plan for these health connections while allowing you to reflect on these experiences and feel good about the choices and investments you have made through these health connections.",
                    style: basicStyle(
                        size: 16,
                        color: AppColors.blackColor,
                        fontWeight: FontWeight.normal),
                  ),
                ])),
              ]).paddingAll(20),
              // UIHelper.verticalSpace(100),
              BouncingWidget(
                animationDuration: const Duration(milliseconds: 1000),
                curve: Curves.ease,
                tweenBegin: 0.95,
                tweenEnd: 0.9,
                widgetToBounce: CustomButtons.customElevatedButton(
                    onTap: () {
                      pushPage(pageName: Routes.activityScale);
                    },
                    borderRadius: BorderRadius.circular(50),
                    widget: SizedBox(
                      height: 45,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            "Let's Start",
                            style: basicStyle(
                                color: AppColors.whiteColor, size: 16),
                          ),
                          const Icon(
                            Icons.double_arrow_rounded,
                            color: Colors.white,
                          )
                        ],
                      ),
                    )),
              )
            ],
          ).paddingAll(20),
          const ActivityScaleScreen(),
          const ActivityExplanationScreen(),
          const Tasks()
        ],
      ),
    );
  }
}

showConfirmModal(context, text) async {
  showCupertinoModalPopup(
      context: context,
      builder: (context) {
        return CupertinoActionSheet(
          message: Text(text),
          actions: [
            CupertinoActionSheetAction(
              onPressed: () async {
                FirebaseAuth user = FirebaseAuth.instance;

                await user.signOut();
                await storage.erase();
                await GoogleSignIn().signOut();

                Navigator.of(navigatorKey.currentContext!)
                    .pushNamedAndRemoveUntil(
                        Routes.login, (Route<dynamic> route) => false);
              },
              child: const Text(
                "Log Out",
                style: TextStyle(color: AppColors.redColor),
              ),
            )
          ],
          cancelButton: CupertinoActionSheetAction(
            child: const Text("Cancel"),
            onPressed: () {
              Navigator.of(context).pop();
            },
          ),
        );
      });
}
