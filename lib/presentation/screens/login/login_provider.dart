import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:health_connection/components/globle_variables.dart';
import 'package:health_connection/components/screen_loader.dart';
import 'package:health_connection/components/show_toast.dart';
import 'package:health_connection/constants/firebase_constants.dart';
import 'package:health_connection/presentation/screens/update_mobile_number/verify_mobile.dart';
import 'package:health_connection/routes/app_pages.dart';
import 'package:health_connection/themes/colors.dart';

class LoginProvider extends ChangeNotifier {
  GlobalKey<FormBuilderState> loginFormKey = GlobalKey<FormBuilderState>();

  FirebaseAuth user = FirebaseAuth.instance;
  User? currentUser = FirebaseAuth.instance.currentUser;
  bool isVisible = false;
  bool isResetEmailSent = false;

  ////Variables
  bool _isVisible = false;
  bool get getIsVisible {
    return _isVisible;
  }

  set setIsVisible(bool isVisible) {
    _isVisible = isVisible;
    notifyListeners();
  }

  loginWithEmailPasswordUser(Map data, BuildContext context) async {
    try {
      Loader.start();
      await user.signInWithEmailAndPassword(
          email: data['email'], password: data['password']);

      try {
        var user = FirebaseAuth.instance.currentUser;
        await user?.reload();
        if (user?.emailVerified == true) {
          print("matching this email ${data['email']}");
          var userResp =
              await DB.getUser.where('email', isEqualTo: data['email']).get();

          var querySnapshot =
              await DB.getUser.doc(userResp.docs.first.id).get();

          var userData = querySnapshot.data();
          await storage.write('user_id', querySnapshot.id);
          await storage.write('name', userData?['full_name'].toString());
          await storage.write('mobile', userData?['phone_number']);
          await storage.write('misc', {
            "vat_number": userData?['vat_number'],
            "vat_rate": userData?['vat_rate'],
            "bank_account_details": userData?['bank_account_details'],
            "cancellation_charge": userData?['cancellation_charge'],
          });

          await storage.write('email', userData?['email']);
          await storage.write('isEmailVarified', true);
          await storage.write('isLoggedIn', true);

          showToast('Logged In');
          Future.delayed(Duration.zero, () {
            Navigator.of(context).pushNamedAndRemoveUntil(
                Routes.splashScreen, (Route<dynamic> route) => false);
          });
        } else {
          storage.write('isEmailVarified', false);
          Future.delayed(Duration.zero, () {
            ScaffoldMessenger.of(context).showSnackBar(SnackBar(
              content: const Text(
                  'You have not verified the account yet, Check your inbox and verify'),
              duration: const Duration(milliseconds: 4000),
              backgroundColor: AppColors.blackColor,
              action: SnackBarAction(
                  label: 'Resend',
                  onPressed: () async {
                    await currentUser?.sendEmailVerification();
                    showToast('Verification mail has been sent');
                  }),
            ));
          });

          Loader.stop();
        }
      } on FirebaseAuthException catch (e) {
        storage.write('isEmailVarified', false);
        storage.write('isMobileNumberVerified', true);
        if (e.code == 'too-many-requests') {
          Loader.stop();
          storage.write('isEmailVarified', false);
          Future.delayed(Duration.zero, () {
            ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
              content: Text(
                  'You have attempted too many time, Please try after some time'),
              backgroundColor: AppColors.appColorDark,
            ));
          });
        }
        Loader.stop();
      }
    } on FirebaseAuthException catch (e) {
      if (e.code == 'wrong-password') {
        Loader.stop();

        ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
          content: Text('The password provided is wrong.'),
          backgroundColor: AppColors.appColorDark,
        ));
      } else if (e.code == 'user-not-found') {
        Loader.stop();

        ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
          content: Text('No user found for this email'),
          backgroundColor: AppColors.appColorDark,
        ));
      }
      else
      {
        print(e.toString());
      }
     
    } 
  }

  String selectedCountryCode = "+2";
////SignUp with Gmail
  Future signInWithGoogle() async {
    if (kIsWeb) {
      ssignInWithGoogle();
    } else {
      try {
        Loader.start();
        // Trigger the authentication flow
        final GoogleSignInAccount? googleUser = await GoogleSignIn().signIn();

        // Obtain the auth details from the request
        final GoogleSignInAuthentication? googleAuth =
            await googleUser?.authentication;

        // Create a new credential
        final credential = GoogleAuthProvider.credential(
          accessToken: googleAuth?.accessToken,
          idToken: googleAuth?.idToken,
        );
        if (credential.accessToken != null) {
          storage.write('isEmailVarified', true);
          var res = await DB.getUser
              .where('email', isEqualTo: googleUser?.email ?? '')
              .get();
           print(res.docs.first.id);

          if (res.docs.isEmpty == true) {
            storage.write('isMobileNumberVerified', false);
            Loader.stop();
            Navigator.of(navigatorKey.currentContext!).push(MaterialPageRoute(
                builder: (context) => VerifyMobile({
                      'full_name': googleUser?.displayName ?? '',
                      'email': googleUser?.email ?? '',
                    })));
          } else {
            var querySnapshot = await DB.getUser.doc(res.docs.first.id).get();
            var data = querySnapshot.data();

            await storage.write('isMobileNumberVerified', true);
            await storage.write('name', googleUser?.displayName ?? '');
            await storage.write('mobile', data?['phone_number']);
            await storage.write('user_id', res.docs.first.id);
            await storage.write('email', data?['email']);
            await storage.write('isLoggedIn', true);

            Loader.stop();

            Navigator.of(navigatorKey.currentContext!).pushNamedAndRemoveUntil(
                Routes.splashScreen, (Route<dynamic> route) => false);
            // Get.offAllNamed(Routes.HOME);
          }
        }
        // Once signed in, return the UserCredential
        return await FirebaseAuth.instance.signInWithCredential(credential);
      } catch (e) {
        print(e.toString());
        Loader.stop();

        return e;
      }
    }
  }

  Future ssignInWithGoogle() async {
    final FirebaseAuth auth = FirebaseAuth.instance;
    // Initialize Firebase
    await Firebase.initializeApp();
    User? user;

    // The `GoogleAuthProvider` can only be used while running on the web
    GoogleAuthProvider authProvider = GoogleAuthProvider();

    try {
      final UserCredential userCredential =
          await auth.signInWithPopup(authProvider);

      user = userCredential.user;

      if (user != null) {
        storage.write('isEmailVarified', true);
        var res =
            await DB.getUser.where('email', isEqualTo: user.email ?? '').get();
        // print(res.docs.first.id);

        if (res.docs.isEmpty == true) {
          storage.write('isMobileNumberVerified', false);
          Loader.stop();
          Navigator.of(navigatorKey.currentContext!).push(MaterialPageRoute(
              builder: (context) => VerifyMobile({
                    'full_name': user?.displayName ?? '',
                    'email': user?.email ?? '',
                  })));
        } else {
          var querySnapshot = await DB.getUser.doc(res.docs.first.id).get();
          var data = querySnapshot.data();

          await storage.write('isMobileNumberVerified', true);
          await storage.write('name', user.displayName ?? '');
          await storage.write('mobile', data?['phone_number']);
          await storage.write('user_id', res.docs.first.id);
          await storage.write('email', data?['email']);
          await storage.write('isLoggedIn', true);

          Loader.stop();

          Navigator.of(navigatorKey.currentContext!).pushNamedAndRemoveUntil(
              Routes.splashScreen, (Route<dynamic> route) => false);
          // Get.offAllNamed(Routes.HOME);
        }
      }
      // Once signed in, return the UserCredential
      // return await FirebaseAuth.instance.signInWithCredential(credential);
    } catch (e) {
      print(e);
    }
  }
}
