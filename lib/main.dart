import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:gsg_firebase/Auth/Providers/auth_provider.dart';
import 'package:gsg_firebase/Auth/ui/pages/login_page.dart';
import 'package:gsg_firebase/Auth/ui/pages/register_page.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(ChangeNotifierProvider<AuthProvider>(
      create: (context) => AuthProvider(),
      child: MaterialApp(home: FirebaseConfiguration())));
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
            return LoginPage();
          }
          return Scaffold(
            body: Center(
              child: CircularProgressIndicator(),
            ),
          );
        });
  }
}
