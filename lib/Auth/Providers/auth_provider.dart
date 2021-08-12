import 'package:flutter/cupertino.dart';
import 'package:gsg_firebase/Auth/helpers/auth_helper.dart';

class AuthProvider extends ChangeNotifier {
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  register() async {
    await AuthHelper.authHelper
        .signup(emailController.text, passwordController.text);
  }

  login() async {
    // print(emailController.text);
    // print(passwordController.text);
    await AuthHelper.authHelper
        .signin(emailController.text, passwordController.text);
  }
}
