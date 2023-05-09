import 'package:country_code_picker/country_code_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:form_builder_validators/form_builder_validators.dart';
import 'package:health_connection/components/field_validation.dart';
import 'package:health_connection/components/globle_variables.dart';
import 'package:health_connection/components/ui_helper.dart';
import 'package:health_connection/presentation/screens/onboarding/signup_provider.dart';
import 'package:health_connection/presentation/screens/update_mobile_number/verify_mobile_provider.dart';
import 'package:health_connection/routes/app_pages.dart';
import 'package:health_connection/themes/colors.dart';

import 'package:provider/provider.dart';

class SignupScreen extends StatelessWidget {
  const SignupScreen({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    final controller = Provider.of<SignupProvider>(context, listen: true);

    return Scaffold(
        // appBar: AppBar(
        //   title: const Text(
        //     'Register',
        //   ),
        //   centerTitle: true,
        //   // backgroundColor: whiteColor,
        //   elevation: 0,
        // ),
        body: Provider<SignupProvider>(
      create: (ctx) => SignupProvider(),
      builder: (ctx, child) => SingleChildScrollView(
        child: FormBuilder(
          key: controller.ownerOnboadrdformKey,
          child: Padding(
            padding: const EdgeInsets.all(20.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                UIHelper.verticalSpace(90),
                // UIHelper.verticalSpaceDoubleExtraLarge(),
                // Row(
                //   mainAxisAlignment: MainAxisAlignment.spaceBetween,
                //   children: [
                //     Container(
                //         height: 45,
                //         width: 100,
                //         decoration: BoxDecoration(
                //             color: const Color.fromARGB(255, 242, 242, 242),
                //             borderRadius: BorderRadius.circular(50)),
                //         child: Center(
                //           child: IconButton(
                //               onPressed: () {
                //                 Navigator.pop(context);
                //               },
                //               icon: const Icon(Icons.arrow_back)),
                //         )),
                //     Container(
                //         height: 45,
                //         width: 230,
                //         decoration: BoxDecoration(
                //             color: const Color.fromARGB(255, 242, 242, 242),
                //             borderRadius: BorderRadius.circular(50)),
                //         child: const Center(
                //             child: Text('Register',
                //                 style: TextStyle(
                //                     fontSize: 18,
                //                     fontWeight: FontWeight.bold))))
                //   ],
                // ),
                UIHelper.verticalSpace(30),
                Center(
                  child: Image.asset(
                    appIcon,
                    height: 100,
                  ),
                ),
                UIHelper.verticalSpace(30),
                const Center(
                  child: Text(
                    'Please enter your details below',
                    style: TextStyle(
                        fontWeight: FontWeight.normal,
                        color: AppColors.blackColor,
                        fontSize: 26),
                    textAlign: TextAlign.center,
                  ),
                ),
                UIHelper.verticalSpace(80),
                FormBuilderTextField(
                  autofillHints: const [AutofillHints.name],
                  name: 'full_name',
                  decoration: InputDecoration(
                    hintText: 'Full Name*',
                    hintStyle: const TextStyle(color: Colors.grey),
                    contentPadding:
                        const EdgeInsets.only(left: 25, top: 15, bottom: 15),
                    enabledBorder: OutlineInputBorder(
                        borderSide: const BorderSide(
                            color: Color.fromARGB(255, 215, 215, 215)),
                        borderRadius: BorderRadius.circular(50)),
                    focusedBorder: OutlineInputBorder(
                        borderSide: const BorderSide(
                            color: AppColors.appColor, width: 1.5),
                        borderRadius: BorderRadius.circular(50)),
                    errorBorder: OutlineInputBorder(
                        borderSide: const BorderSide(
                            color: AppColors.redColor, width: 1.5),
                        borderRadius: BorderRadius.circular(50)),
                  ),
                  validator: FormBuilderValidators.compose([
                    FormBuilderValidators.required(
                        errorText: 'Full Name required'),
                  ]),
                  keyboardType: TextInputType.text,
                  textCapitalization: TextCapitalization.words,
                ),
                UIHelper.verticalSpaceMedium(),
                Row(children: [
                  Expanded(
                    child: FormBuilderTextField(
                      name: 'phone_number',
                      decoration: InputDecoration(
                        prefixIcon: SizedBox(
                          width: 125,
                          child: CountryCodePicker(
                            initialSelection: controller.selectedCountryCode,
                            showCountryOnly: false,
                            showOnlyCountryWhenClosed: false,
                            favorite: const ['+1'],
                            enabled: true,
                            hideMainText: false,
                            showFlagMain: true,
                            showFlag: true,
                            hideSearch: false,
                            showFlagDialog: true,
                            alignLeft: true,
                            onChanged: (value) {
                              controller.selectedCountryCode = value.toString();
                            },
                          ),
                        ),
                        hintText: 'Phone Number*',
                        hintStyle: const TextStyle(color: Colors.grey),
                        contentPadding: const EdgeInsets.only(
                            left: 25, top: 15, bottom: 15),
                        enabledBorder: OutlineInputBorder(
                            borderSide: const BorderSide(
                                color: Color.fromARGB(255, 215, 215, 215)),
                            borderRadius: BorderRadius.circular(50)),
                        focusedBorder: OutlineInputBorder(
                            borderSide: const BorderSide(
                                color: AppColors.appColor, width: 1.5),
                            borderRadius: BorderRadius.circular(50)),
                        errorBorder: OutlineInputBorder(
                            borderSide: const BorderSide(
                                color: AppColors.redColor, width: 1.5),
                            borderRadius: BorderRadius.circular(50)),
                      ),
                      validator: FormBuilderValidators.compose([
                        FormBuilderValidators.required(
                            errorText: 'Phone Number required'),
                      ]),
                      keyboardType: TextInputType.number,
                    ),
                  ),
                ]),
                UIHelper.verticalSpaceMedium(),
                FormBuilderTextField(
                  autofillHints: const [AutofillHints.email],
                  name: 'email',
                  decoration: InputDecoration(
                    hintText: 'E-mail*',
                    hintStyle: const TextStyle(color: Colors.grey),
                    contentPadding:
                        const EdgeInsets.only(left: 25, top: 15, bottom: 15),
                    enabledBorder: OutlineInputBorder(
                        borderSide: const BorderSide(
                            color: Color.fromARGB(255, 215, 215, 215)),
                        borderRadius: BorderRadius.circular(50)),
                    focusedBorder: OutlineInputBorder(
                        borderSide: const BorderSide(
                            color: AppColors.appColor, width: 1.5),
                        borderRadius: BorderRadius.circular(50)),
                    errorBorder: OutlineInputBorder(
                        borderSide: const BorderSide(
                            color: AppColors.redColor, width: 1.5),
                        borderRadius: BorderRadius.circular(50)),
                  ),
                  validator: FormBuilderValidators.compose([
                    FormBuilderValidators.email(),
                    FormBuilderValidators.required(
                        errorText: 'E-mail required'),
                    AppValidation.validateEmailAddress,
                  ]),
                  keyboardType: TextInputType.text,
                ),
                UIHelper.verticalSpaceMedium(),
                FormBuilderTextField(
                  name: 'password',
                  obscureText: !controller.getIsVisible,
                  style: const TextStyle(color: AppColors.blackColor),
                  decoration: InputDecoration(
                    contentPadding:
                        const EdgeInsets.only(left: 25, top: 15, bottom: 15),
                    suffixIcon: IconButton(
                      onPressed: () {
                        controller.setIsVisible = !controller.getIsVisible;
                      },
                      icon: Icon(
                        controller.getIsVisible
                            ? Icons.visibility
                            : Icons.visibility_off,
                        color: AppColors.blackColor,
                        size: 25,
                      ),
                    ),
                    enabledBorder: OutlineInputBorder(
                        borderSide: const BorderSide(
                            color: Color.fromARGB(255, 215, 215, 215)),
                        borderRadius: BorderRadius.circular(50)),
                    focusedBorder: OutlineInputBorder(
                        borderSide: const BorderSide(
                            color: AppColors.appColor, width: 1.5),
                        borderRadius: BorderRadius.circular(50)),
                    errorBorder: OutlineInputBorder(
                        borderSide: const BorderSide(
                            color: AppColors.redColor, width: 1.5),
                        borderRadius: BorderRadius.circular(50)),
                    focusColor: AppColors.whiteColor,
                    hintText: 'Password',
                  ),
                  validator: FormBuilderValidators.compose([
                    FormBuilderValidators.required(
                        errorText: 'Password required'),
                    FormBuilderValidators.minLength(6,
                        errorText: 'Enter atleast 6 chrecter'),
                    AppValidation.validatePassword,
                  ]),
                  onChanged: (code) {
                    controller.firstPin = code!;
                  },
                ),
                UIHelper.verticalSpaceMedium(),
                FormBuilderTextField(
                  name: 'repeat_password',
                  obscureText: !controller.getIsRepeatVisible,
                  style: const TextStyle(color: AppColors.blackColor),
                  decoration: InputDecoration(
                    contentPadding:
                        const EdgeInsets.only(left: 25, top: 15, bottom: 15),
                    suffixIcon: IconButton(
                      onPressed: () {
                        controller.setIsRepeatVisible =
                            !controller.getIsRepeatVisible;
                      },
                      icon: Icon(
                        controller.getIsRepeatVisible
                            ? Icons.visibility
                            : Icons.visibility_off,
                        color: AppColors.blackColor,
                        size: 25,
                      ),
                    ),
                    enabledBorder: OutlineInputBorder(
                        borderSide: const BorderSide(
                            color: Color.fromARGB(255, 215, 215, 215)),
                        borderRadius: BorderRadius.circular(50)),
                    focusedBorder: OutlineInputBorder(
                        borderSide: const BorderSide(
                            color: AppColors.appColor, width: 1.5),
                        borderRadius: BorderRadius.circular(50)),
                    errorBorder: OutlineInputBorder(
                        borderSide: const BorderSide(
                            color: AppColors.redColor, width: 1.5),
                        borderRadius: BorderRadius.circular(50)),
                    focusColor: AppColors.whiteColor,
                    hintText: 'Repeat Password',
                  ),
                  onChanged: (value) {
                    controller.setSecondPin = value.toString();
                  },
                  validator: FormBuilderValidators.compose([
                    FormBuilderValidators.required(
                        errorText: 'Password required'),
                    FormBuilderValidators.minLength(6,
                        errorText: 'Enter atleast 6 chrecter'),
                    FormBuilderValidators.equal(controller.firstPin,
                        errorText: 'Password does not match'),
                  ]),
                ),
                UIHelper.verticalSpaceDoubleExtraLarge(),
                ElevatedButton(
                    onPressed: () async {
                      controller.sendData(context);
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
                    child: Text("Create",
                        style: Theme.of(context).textTheme.titleLarge?.copyWith(
                              color: AppColors.whiteColor,
                              fontSize: 20,
                            ))),
                UIHelper.verticalSpaceExtraLarge(),
                Row(
                  children: const [
                    Expanded(
                      child: Divider(thickness: 1, color: Colors.grey),
                    ),
                    Expanded(
                        child: Center(
                            child: Text(
                      'Or Signup With',
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
                    context.read<VerifyMobileProvider>().signInWithGoogle();
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
                      const Text("Signup with Google",
                          style: TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.normal,
                              color: Colors.black)),
                    ],
                  ),
                ),
                UIHelper.verticalSpaceExtraLarge(),
                Row(mainAxisAlignment: MainAxisAlignment.center, children: [
                  const Text(
                    "Already have an account?",
                    style: TextStyle(
                        fontWeight: FontWeight.normal,
                        color: AppColors.blackColor,
                        fontSize: 16),
                  ),
                  TextButton(
                      child: const Text(" Login",
                          style: TextStyle(
                              fontWeight: FontWeight.normal,
                              color: AppColors.blueColor,
                              fontSize: 16)),
                      onPressed: () {
                        //TODO: dispose formkey

                        Navigator.of(context).pushNamedAndRemoveUntil(
                            Routes.login, (Route<dynamic> route) => false);
                      })
                ]),
              ],
            ),
          ),
        ),
      ),
    ));
  }
}
