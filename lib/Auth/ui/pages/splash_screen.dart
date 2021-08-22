import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:gsg_firebase/Auth/helpers/shared_preferences.dart';
import 'package:gsg_firebase/Auth/ui/pages/login_page.dart';
import 'package:gsg_firebase/chats/pages/home_page.dart';

class SplashScreen extends StatelessWidget {
  // const SplashScreen({ Key? key }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Future.delayed(Duration(seconds: 1)).then(
      (value) {
        if (SpHelper.spHelper.getUser() != null) {
          Navigator.of(context)
              .pushReplacement(MaterialPageRoute(builder: (context) {
            return HomePage();
          }));
        } else {
          Navigator.of(context).pushReplacement(
            MaterialPageRoute(
              builder: (context) {
                return LoginPage();
              },
            ),
          );
        }
      },
    );
    return Container();
  }
}
