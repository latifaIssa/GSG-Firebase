import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:gsg_firebase/Auth/Providers/auth_provider.dart';
import 'package:gsg_firebase/Auth/ui/pages/login_page.dart';
import 'package:gsg_firebase/Auth/ui/pages/main_page.dart';
import 'package:gsg_firebase/Auth/ui/pages/register_page.dart';
import 'package:gsg_firebase/Auth/ui/pages/reset_password_page.dart';
import 'package:gsg_firebase/chats/home_page.dart';
import 'package:gsg_firebase/services/routes_helper.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(
    ChangeNotifierProvider<AuthProvider>(
      create: (context) => AuthProvider(),
      child: MaterialApp(
        routes: {
          LoginPage.routeName: (context) => LoginPage(),
          RegisterPage.routeName: (context) => RegisterPage(),
          ResetPassordPage.routeName: (context) => ResetPassordPage(),
          HomePage.routeName: (context) => HomePage(),
        },
        navigatorKey: RouteHelper.routeHelper.navKey,
        home: FirebaseConfiguration(),
      ),
    ),
  );
}

class FirebaseConfiguration extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return FutureBuilder<FirebaseApp>(
        future: Firebase.initializeApp(),
        builder: (context, AsyncSnapshot<FirebaseApp> dataSnapShot) {
          if (dataSnapShot.hasError) {
            return Scaffold(
              backgroundColor: Colors.red,
              body: Center(
                child: Text(dataSnapShot.error.toString()),
              ),
            );
          }
          if (dataSnapShot.connectionState == ConnectionState.done) {
            // return RegisterPage();
            return AuthMainPage();
          }
          return Scaffold(
            body: Center(
              child: CircularProgressIndicator(),
            ),
          );
        });
  }
}
