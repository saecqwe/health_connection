import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:health_connection/components/globle_variables.dart';
import 'package:health_connection/components/screen_loader.dart';
import 'package:health_connection/components/show_toast.dart';
import 'package:health_connection/constants/firebase_constants.dart';
import 'package:health_connection/presentation/screens/update_mobile_number/verify_mobile.dart';
import 'package:health_connection/routes/app_pages.dart';

class VerifyMobileProvider extends ChangeNotifier {
  String selectedCountryCode = "+1";
////SignUp with Gmail
  Future signInWithGoogle() async {
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
        // print(res.docs.first.id);

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
        }
      }
      // Once signed in, return the UserCredential
      return await FirebaseAuth.instance.signInWithCredential(credential);
    } catch (e) {
      Loader.stop();

      return e;
    }
  }

  updateMobileNo({required Map data, required BuildContext context}) async {
    // final plainPassword = data['password'];
    // final key = encrypt.Key.fromSecureRandom(32);
    // final iv = encrypt.IV.fromSecureRandom(16);
    // final encrypter = encrypt.Encrypter(encrypt.AES(key));
    // final encryptedPassword = encrypter.encrypt(plainPassword, iv: iv);

    try {
      Loader.start();

      var finaldata = {
        'full_name': data['full_name'],
        'email': data['email'],
        'phone_number': data['phone_number'],
        'country_code': selectedCountryCode,
      };
      var firebaseUserId =
          await DB.getUser.add(finaldata).whenComplete(() async {
        Loader.stop();
        showToast('Updated SucessFully');
        await storage.write('isMobileNumberVerified', true);
        await storage.write('name', data['full_name']);
        await storage.write('mobile', data['phone_number']);
        await storage.write('email', data['email']);
        await storage.write('isLoggedIn', true);

        Navigator.of(context).pushNamedAndRemoveUntil(
            Routes.splashScreen, (Route<dynamic> route) => false);
      }).onError((error, stackTrace) {
        Loader.stop();

        return showToast('Something wnt wrong');
      }).onError((error, stackTrace) => showToast('Something went wrong'));
      await storage.write('user_id', firebaseUserId.id);
    } catch (e) {
      storage.write('isMobileNumberVerified', false);
      Loader.stop();

      // showToast('Something went wrong');
    }
  }
}
