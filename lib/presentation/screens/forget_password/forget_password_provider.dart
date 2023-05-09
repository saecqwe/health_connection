import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:health_connection/components/screen_loader.dart';
import 'package:health_connection/components/show_toast.dart';
import 'package:health_connection/themes/colors.dart';

class ForgetPasswordProvider extends ChangeNotifier {
  bool isResetEmailSent = false;
  FirebaseAuth user = FirebaseAuth.instance;
//////Reset Password
  Future<void> resetPassword(String email, BuildContext context) async {
    try {
      Loader.start();
      await user.sendPasswordResetEmail(email: email);
      isResetEmailSent = true;
      notifyListeners();
      Loader.stop();
    } on FirebaseAuthException catch (e) {
      if (e.code == "user-not-found") {
        Loader.stop();

        ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
          content: Text('There is no user record corresponding to this email.'),
          backgroundColor: AppColors.lightColor,
        ));
      } else if (e.code == 'too-many-requests') {
        Loader.stop();

        ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
          content: Text(
              'It seems you have tried maximum attempt, Please try again later'),
          backgroundColor: AppColors.lightColor,
        ));
      }
    } catch (e) {
      showToast('something went wrong');
    }
  }

  @override
  void disposeValues() {
    isResetEmailSent = false;
  }
}
