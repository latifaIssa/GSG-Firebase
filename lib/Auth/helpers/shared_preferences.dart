import 'dart:convert';

import 'package:gsg_firebase/Auth/Globals/globals.dart';
import 'package:gsg_firebase/Auth/models/LoginForm.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SpHelper {
  SpHelper._();
  static SpHelper spHelper = SpHelper._();
  SharedPreferences sharedPreferences;
  initSharedPrefernces() async {
    sharedPreferences = await SharedPreferences.getInstance();
  }

  saveUser(LoginUser user) {
    Globals.globals.user = user;
    sharedPreferences.setString('usr', json.encode({...user.toMap()}));
  }

  LoginUser getUser() {
    // try {
    String user1 = sharedPreferences.getString('usr');
    if (user1 == null) {
      return null;
    }
    assert(user1 != null);
    Map userMap = json.decode(user1);
    LoginUser user = LoginUser.map(userMap);
    Globals.globals.user = user;
    return user;
    // } on Exception catch (e) {
    //   return null;
    // }
  }

  signOut() {
    sharedPreferences.remove('usr');
  }
}
