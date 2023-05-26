import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:form_builder_validators/form_builder_validators.dart';
import 'package:health_connection/components/globle_variables.dart';
import 'package:health_connection/components/ui_helper.dart';
import 'package:health_connection/components/widget_size.dart';
import 'package:health_connection/presentation/screens/login/login_provider.dart';
import 'package:health_connection/routes/app_pages.dart';
import 'package:health_connection/themes/colors.dart';
import 'package:provider/provider.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // appBar: AppBar(
      //   // backgroundColor: Colors.white,
      //   centerTitle: true,
      //   elevation: .5,
      //   title: const Text(
      //     'Log in',
      //     // style: TextStyle(fontWeight: FontWeight.bold, color: blackColor)
      //   ),
      // ),
      body: SingleChildScrollView(
        child: Center(
          child: FormBuilder(
            key: context.watch<LoginProvider>().loginFormKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                UIHelper.verticalSpace(60),
                Center(
                  child: Image.asset(
                    appIcon,
                    height: 100,
                  ),
                ),
                UIHelper.verticalSpace(30),
                const Center(
                  child: Text(
                    'Login',
                    style: TextStyle(
                        fontWeight: FontWeight.normal,
                        color: AppColors.blackColor,
                        fontSize: 28),
                    textAlign: TextAlign.center,
                  ),
                ),
                UIHelper.verticalSpace(60),
                FormBuilderTextField(
                  name: 'email',
                  autofillHints: const [AutofillHints.email],
                  style: const TextStyle(
                      color: AppColors.blackColor, fontSize: 16),
                  validator: FormBuilderValidators.compose([
                    FormBuilderValidators.required(errorText: 'Email required'),
                    FormBuilderValidators.email(
                        errorText: 'Please enter a vaid email address')
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
                UIHelper.verticalSpaceLarge(),
                FormBuilderTextField(
                  name: 'password',
                  obscureText: !context.watch<LoginProvider>().getIsVisible,
                  style: const TextStyle(
                      color: AppColors.blackColor, fontSize: 16),
                  decoration: InputDecoration(
                    prefixIcon: const Icon(Icons.lock),
                    suffixIcon: InkWell(
                      onTap: () {
                        context.read<LoginProvider>().setIsVisible =
                            !context.read<LoginProvider>().getIsVisible;
                      },
                      child: Padding(
                        padding: const EdgeInsets.all(0.0),
                        child: Icon(
                          context.watch<LoginProvider>().getIsVisible
                              ? Icons.visibility
                              : Icons.visibility_off,
                          color: AppColors.blackColor,
                          size: 25,
                        ),
                      ),
                    ),
                    contentPadding: const EdgeInsets.only(top: 14),
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
                    focusColor: AppColors.whiteColor,
                    hintText: 'Password',
                  ),
                  validator: FormBuilderValidators.compose([
                    FormBuilderValidators.required(
                        errorText: 'Password required'),
                    FormBuilderValidators.minLength(6,
                        errorText: 'Enter atleast 6 chrecter'),
                  ]),
                ),
                UIHelper.verticalSpaceSmall(),
                Align(
                  alignment: Alignment.centerRight,
                  child: TextButton(
                      onPressed: () {
                        Navigator.pushNamed(context, Routes.forgotPassword);
                      },
                      child: const Text(
                        'Forgot Password',
                        style: TextStyle(
                            color: Colors.grey,
                            fontSize: 14,
                            fontWeight: FontWeight.bold),
                      )),
                ),
                UIHelper.verticalSpace(60),
                Center(
                  child: ElevatedButton(
                      onPressed: () async {
                        context
                            .read<LoginProvider>()
                            .loginFormKey
                            .currentState!
                            .save();
                        if (context
                            .read<LoginProvider>()
                            .loginFormKey
                            .currentState!
                            .validate()) {
                          await context
                              .read<LoginProvider>()
                              .loginWithEmailPasswordUser(
                                  context
                                      .read<LoginProvider>()
                                      .loginFormKey
                                      .currentState!
                                      .value,
                                  context);
                        }
                      },
                      style: ButtonStyle(
                          elevation: MaterialStateProperty.all(3),
                          minimumSize: MaterialStateProperty.all(
                              const Size.fromHeight(45)),
                          backgroundColor:
                              MaterialStateProperty.all(AppColors.appColor),
                          shape:
                              MaterialStateProperty.all<RoundedRectangleBorder>(
                                  RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(50.0),
                          ))),
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          const Text("Continue",
                              style: TextStyle(
                                fontSize: 20,
                                fontWeight: FontWeight.normal,
                              )),
                          UIHelper.horizontalSpaceSmall(),
                          const Icon(
                            Icons.arrow_circle_right_outlined,
                            size: 30,
                          )
                        ],
                      )),
                ),
                UIHelper.verticalSpace(20),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Text(
                      "Don't have an account?",
                      style: TextStyle(
                          fontWeight: FontWeight.normal,
                          color: AppColors.blackColor,
                          fontSize: 16),
                    ),
                    TextButton(
                        child: const Text(" Create Account",
                            style: TextStyle(
                                fontWeight: FontWeight.normal,
                                color: AppColors.blueColor,
                                fontSize: 16)),
                        onPressed: () {
                          Navigator.pushNamed(context, Routes.signup);
                        })
                  ],
                ),
                UIHelper.verticalSpaceExtraLarge(),
                Row(
                  children: const [
                    Expanded(
                      child: Divider(thickness: 1, color: Colors.grey),
                    ),
                    Expanded(
                        child: Center(
                            child: Text(
                      'Or Login With',
                      style: TextStyle(color: Colors.grey, fontSize: 14),
                    ))),
                    Expanded(
                      child: Divider(thickness: 1, color: Colors.grey),
                    ),
                  ],
                ),
                UIHelper.verticalSpaceExtraLarge(),
                OutlinedButton(
                  onPressed: () async {
                    context.read<LoginProvider>().signInWithGoogle();
                  },
                  style: OutlinedButton.styleFrom(
                    minimumSize: const Size.fromHeight(45),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(100.0),
                    ),
                    side: const BorderSide(width: 1, color: Colors.grey),
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      SvgPicture.asset('assets/svg_icons/google.svg',
                          height: 25),
                      UIHelper.horizontalSpaceSmall(),
                      const Text("Login with Google",
                          style: TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.normal,
                              color: Colors.black)),
                    ],
                  ),
                ),
                UIHelper.verticalSpaceExtraLarge(),
              ],
            ).paddingAll(20),
          ),
        ),
      ),
    );
  }
}
