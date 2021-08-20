import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:gsg_firebase/Auth/helpers/auth_helper.dart';
import 'package:gsg_firebase/Auth/ui/pages/login_page.dart';
import 'package:gsg_firebase/Auth/ui/pages/reset_password_page.dart';
import 'package:gsg_firebase/chats/home_page.dart';
import 'package:gsg_firebase/services/custom_dialog.dart';
import 'package:gsg_firebase/services/routes_helper.dart';

class AuthProvider extends ChangeNotifier {
  TabController tabController;
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  resetControllers() {
    emailController.clear();
    passwordController.clear();
  }

  register() async {
    try {
      await AuthHelper.authHelper
          .signup(emailController.text, passwordController.text);
      await AuthHelper.authHelper.verifyEmail();
      await AuthHelper.authHelper.logout();
      // RouteHelper.routeHelper.goToPageWithReplacement(LoginPage.routeName);
      tabController.animateTo(1);
    } on Exception catch (e) {
      print(e);
    }
    resetControllers();
  }

  login() async {
    await AuthHelper.authHelper
        .signin(emailController.text, passwordController.text)
        .then((value) {
      if (value) {
        //todo handle login
        bool isVerifiedEmail = AuthHelper.authHelper.checkEmailVerification();
        isVerifiedEmail
            ? RouteHelper.routeHelper
                .goToPageWithReplacement(HomePage.routeName)
            : CustomDialog.customDialog.showCustomDialog(
                'You have to verify your email, press ok to send another email',
                sendVericiafion);
        resetControllers();
      } else {
        //todo handel error state
        CustomDialog.customDialog.showCustomDialog('Falid email or password');
      }
    });
  }

  sendVericiafion() {
    AuthHelper.authHelper.verifyEmail();
    AuthHelper.authHelper.logout();
  }

  ResetPassword() async {
    AuthHelper.authHelper.resetPassword(emailController.text);
    resetControllers();
  }
}
