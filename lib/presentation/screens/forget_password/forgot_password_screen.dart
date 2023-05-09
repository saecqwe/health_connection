import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:form_builder_validators/form_builder_validators.dart';
import 'package:health_connection/components/ui_helper.dart';
import 'package:health_connection/components/widget_size.dart';
import 'package:health_connection/presentation/screens/forget_password/forget_password_provider.dart';
import 'package:health_connection/routes/app_pages.dart';
import 'package:health_connection/themes/colors.dart';

import 'package:provider/provider.dart';

class ForgotPasswordScreen extends StatelessWidget {
  final _formKey = GlobalKey<FormBuilderState>();

  ForgotPasswordScreen({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: AppColors.whiteColor,
        body: SingleChildScrollView(
          child: FormBuilder(
            key: _formKey,
            child: context.watch<ForgetPasswordProvider>().isResetEmailSent ==
                    false
                ? Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      UIHelper.verticalSpace(150),
                      const Text(
                        'Forgot your password?',
                        style: TextStyle(
                            fontWeight: FontWeight.bold,
                            color: AppColors.blackColor,
                            fontSize: 22),
                      ),
                      const Text(
                        'Enter your registered email below to recieve password reset link.',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                            color: AppColors.lightColor, fontSize: 18),
                      ),
                      UIHelper.verticalSpaceLarge(),
                      Image.asset(
                        'assets/icons/send_email.png',
                        height: 130,
                        // width: 120.w,
                      ),
                      UIHelper.verticalSpaceExtraLarge(),
                      Container(
                        decoration: BoxDecoration(
                            color: AppColors.whiteColor,
                            borderRadius: BorderRadius.circular(5)),
                        padding: const EdgeInsets.only(
                            top: 5, bottom: 5, left: 10, right: 10),
                        child: Expanded(
                          flex: 8,
                          child: FormBuilderTextField(
                            name: 'email',
                            autofillHints: const [AutofillHints.email],
                            style: const TextStyle(
                                color: AppColors.blackColor, fontSize: 16),
                            validator: FormBuilderValidators.compose([
                              FormBuilderValidators.required(
                                  errorText: 'Email required'),
                              FormBuilderValidators.email(
                                  errorText:
                                      'Please enter a vaid email address')
                            ]),
                            keyboardType: TextInputType.emailAddress,
                            decoration: InputDecoration(
                              contentPadding: const EdgeInsets.only(top: 14),
                              prefixIcon: const Icon(Icons.mail),
                              border: InputBorder.none,
                              focusedBorder: OutlineInputBorder(
                                  borderSide: const BorderSide(
                                      color: AppColors.appColor, width: 1.5),
                                  borderRadius: BorderRadius.circular(50)),
                              enabledBorder: OutlineInputBorder(
                                  borderSide: const BorderSide(
                                      color: AppColors.greyColor, width: 1.5),
                                  borderRadius: BorderRadius.circular(50)),
                              errorBorder: OutlineInputBorder(
                                  borderSide: const BorderSide(
                                      color: AppColors.redColor, width: 1.5),
                                  borderRadius: BorderRadius.circular(50)),
                              disabledBorder: InputBorder.none,
                              hintText: 'Email',
                            ),
                          ),
                        ),
                      ),
                      UIHelper.verticalSpaceLarge(),
                      UIHelper.verticalSpace(80),
                      Center(
                          child: ElevatedButton(
                              onPressed: () async {
                                _formKey.currentState!.save();
                                if (_formKey.currentState!.validate()) {
                                  await context
                                      .read<ForgetPasswordProvider>()
                                      .resetPassword(
                                          _formKey.currentState!.value['email'],
                                          context);
                                }
                              },
                              style: ButtonStyle(
                                  elevation: MaterialStateProperty.all(3),
                                  minimumSize: MaterialStateProperty.all(
                                      const Size.fromHeight(45)),
                                  backgroundColor: MaterialStateProperty.all(
                                      AppColors.appColor),
                                  shape: MaterialStateProperty.all<
                                          RoundedRectangleBorder>(
                                      RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(50.0),
                                  ))),
                              child: Row(
                                crossAxisAlignment: CrossAxisAlignment.center,
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  const Text("Send Reset Link",
                                      style: TextStyle(
                                        fontSize: 20,
                                        fontWeight: FontWeight.normal,
                                      )),
                                  UIHelper.horizontalSpaceSmall(),
                                  const Icon(
                                    Icons.arrow_circle_right_outlined,
                                    color: AppColors.whiteColor,
                                    size: 30,
                                  )
                                ],
                              ))),
                      UIHelper.verticalSpaceLarge(),
                    ],
                  ).paddingAll(20)
                : Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      UIHelper.verticalSpace(150),
                      const Text(
                        'Reset link has been sent',
                        style: TextStyle(
                            fontWeight: FontWeight.bold,
                            color: AppColors.blackColor,
                            fontSize: 22),
                      ),
                      const Text(
                        'Please check you inbox and click in the received link to reset a password.',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                            color: AppColors.lightColor, fontSize: 18),
                      ),
                      UIHelper.verticalSpace(80),
                      Image.asset(
                        'assets/icons/verify_email.png',
                        height: 130,
                        // width: 120.w,
                      ),
                      UIHelper.verticalSpaceLarge(),
                      UIHelper.verticalSpace(80),
                      Center(
                          child: ElevatedButton(
                              onPressed: () {
                                // AppProviders.disposeAllDisposableProviders(
                                //     context);
                                Navigator.of(context).pushNamedAndRemoveUntil(
                                    Routes.splashScreen,
                                    (Route<dynamic> route) => false);
                              },
                              style: ButtonStyle(
                                  elevation: MaterialStateProperty.all(3),
                                  minimumSize: MaterialStateProperty.all(
                                      const Size.fromHeight(45)),
                                  backgroundColor: MaterialStateProperty.all(
                                      AppColors.appColor),
                                  shape: MaterialStateProperty.all<
                                          RoundedRectangleBorder>(
                                      RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(50.0),
                                  ))),
                              child: Row(
                                crossAxisAlignment: CrossAxisAlignment.center,
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  const Text("Login",
                                      style: TextStyle(
                                        fontSize: 20,
                                        fontWeight: FontWeight.normal,
                                      )),
                                  UIHelper.horizontalSpaceSmall(),
                                  const Icon(
                                    Icons.arrow_circle_right_outlined,
                                    color: AppColors.whiteColor,
                                    size: 35,
                                  )
                                ],
                              ))

                          // Container(
                          //   height: 40,
                          //   width: double.infinity,
                          //   child: ElevatedButton(
                          //     onPressed: () {
                          //       Get.offAllNamed(Routes.LOGIN);
                          //     },
                          //     child: Text(
                          //       "Login",
                          //     ),
                          //     style: ElevatedButton.styleFrom(
                          //         elevation: 1,
                          //         primary: buttonColor,
                          //         // padding: EdgeInsets.symmetric(vertical: 8),
                          //         textStyle: TextStyle(
                          //           fontSize: 16,
                          //           fontWeight: FontWeight.bold,
                          //         )),
                          //   ),
                          // ),
                          ),
                      UIHelper.verticalSpaceLarge(),
                    ],
                  ).paddingAll(20),
          ),
        ));
  }
}
