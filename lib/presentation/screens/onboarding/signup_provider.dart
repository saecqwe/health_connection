import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:health_connection/components/globle_variables.dart';
import 'package:health_connection/components/screen_loader.dart';
import 'package:health_connection/components/show_toast.dart';
import 'package:health_connection/constants/firebase_constants.dart';
import 'package:health_connection/presentation/screens/onboarding/sign_up_successfully_screen.dart';

import 'package:health_connection/routes/app_pages.dart';
import 'package:health_connection/themes/colors.dart';

class SignupProvider extends ChangeNotifier {
  GlobalKey<FormBuilderState> ownerOnboadrdformKey =
      GlobalKey<FormBuilderState>();
  FirebaseAuth user = FirebaseAuth.instance;
  bool _isVisible = false;
  bool _isRepeatVisible = false;

  String firstPin = "";
  String _secondPin = "";

  String selectedCountryCode = "+1";

  /////Getters
  bool get getIsVisible {
    return _isVisible;
  }

  bool get getIsRepeatVisible {
    return _isRepeatVisible;
  }

  String get getSecondPin {
    return _secondPin;
  }

  ///Setters
  set setIsVisible(bool value) {
    _isVisible = value;
    notifyListeners();
  }

  set setIsRepeatVisible(bool value) {
    _isRepeatVisible = value;
    notifyListeners();
  }

  set setSecondPin(String value) {
    _secondPin = value;
    notifyListeners();
  }

  Future sendData(BuildContext context) async {
    if (ownerOnboadrdformKey.currentState?.saveAndValidate() ?? true) {
      Loader.start();
      try {
        var emailRes = await DB.getUser
            .where('email',
                isEqualTo: ownerOnboadrdformKey.currentState?.value['email'])
            .get();

        var phoneRes = await DB.getUser
            .where('phone_number',
                isEqualTo:
                    ownerOnboadrdformKey.currentState?.value['phone_number'])
            .get();

        if (emailRes.docs.isEmpty == true) {
          if (phoneRes.docs.isEmpty == true) {
            storingUserData(data: ownerOnboadrdformKey.currentState?.value);
          } else {
            Loader.stop();

            ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
              content:
                  Text('Phone No. is already registered with another account'),
              backgroundColor: AppColors.blackColor,
            ));
          }
        } else {
          Loader.stop();

          ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
            content: Text('Email is already registered with another account'),
            backgroundColor: AppColors.blackColor,
          ));
        }
      } catch (e) {
        Loader.stop();

        ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
          content: Text('Something went wrong'),
          backgroundColor: AppColors.blackColor,
        ));
      }
    }
  }

  Future storingUserData({Map? data}) async {
    Map<String, dynamic> postData = {
      'email': data?['email'],
      'country_code': selectedCountryCode,
      'full_name': data?['full_name'],
      'phone_number': data?['phone_number'],
    };

    await user.createUserWithEmailAndPassword(
        email: data?['email'], password: data?['password']);

    await DB.getUser
        .add(postData)
        .then((value) {
          storage.write('name', data?['full_name']);
          storage.write('mobile', data?['phone_number']);
          storage.write('user_id', value.id);
          storage.write('email', data?['email']);
        })
        .then((value) => showToast('Account created successfully'))
        .then((value) => Loader.stop());

    if (user.currentUser?.emailVerified != null &&
        !user.currentUser!.emailVerified) {
      await user.currentUser!.sendEmailVerification();
      storage.write('isEmailVarified', false);
      Navigator.of(
        navigatorKey.currentContext!,
      ).pushAndRemoveUntil(
          MaterialPageRoute(
              builder: (context) => const SignUpSuccessScreen(
                  title: 'Registered Successfully!',
                  body:
                      "We have sent you a verification link on your email please verify",
                  icon: "assets/icons/mail.png")),
          (Route<dynamic> route) => false);
    } else {
      storage.write('isEmailVarified', true);
      await storage.write('isLoggedIn', true);
      Navigator.of(navigatorKey.currentContext!).pushNamedAndRemoveUntil(
          Routes.splashScreen, (Route<dynamic> route) => false);
    }
  }
}
