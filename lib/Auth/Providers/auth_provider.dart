import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:gsg_firebase/Auth/helpers/auth_helper.dart';
import 'package:gsg_firebase/Auth/helpers/firestore_helper.dart';
import 'package:gsg_firebase/Auth/helpers/shared_preferences.dart';
import 'package:gsg_firebase/Auth/models/LoginForm.dart';
import 'package:gsg_firebase/Auth/models/register_request.dart';
import 'package:gsg_firebase/chats/pages/home_page.dart';
import 'package:gsg_firebase/services/routes_helper.dart';

class AuthProvider extends ChangeNotifier {
  TabController tabController;
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController firstNameController = TextEditingController();
  TextEditingController lastNameController = TextEditingController();
  TextEditingController cityController = TextEditingController();
  TextEditingController countryNameController = TextEditingController();

  resetControllers() {
    emailController.clear();
    passwordController.clear();
  }

  register() async {
    try {
      UserCredential userCredential = await AuthHelper.authHelper
          .signup(emailController.text, passwordController.text);
      RegisterRequest registerRequest = RegisterRequest(
          id: userCredential.user.uid,
          email: emailController.text,
          password: passwordController.text,
          city: cityController.text,
          country: countryNameController.text,
          fname: firstNameController.text,
          lname: lastNameController.text);
      FirestoreHelper.firestoreHelper.addUserToFirestore(registerRequest);
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
    UserCredential userCredential = await AuthHelper.authHelper
        .signin(emailController.text, passwordController.text);
    // FirestoreHelper.firestoreHelper
    //     .getUserFromFirestore(userCredential.user.uid);
    //Save current user in local storage
    LoginUser user = LoginUser(
        email: userCredential.user.email, password: passwordController.text);
    SpHelper.spHelper.saveUser(user);
    resetControllers();
    RouteHelper.routeHelper.goToPageWithReplacement(HomePage.routeName);

    // .then((value) {
    // if (value) {
    //   //todo handle login
    //   bool isVerifiedEmail = AuthHelper.authHelper.checkEmailVerification();
    //   isVerifiedEmail
    //       ? RouteHelper.routeHelper
    //           .goToPageWithReplacement(HomePage.routeName)
    //       : CustomDialog.customDialog.showCustomDialog(
    //           'You have to verify your email, press ok to send another email',
    //           sendVericiafion);
    //   resetControllers();
    // } else {
    //   //todo handel error state
    //   CustomDialog.customDialog.showCustomDialog('Falid email or password');
    // }
    // });
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
