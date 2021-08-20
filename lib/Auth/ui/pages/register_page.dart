import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:gsg_firebase/Auth/Providers/auth_provider.dart';
import 'package:gsg_firebase/Auth/ui/widgets/custom_textfeild.dart';
import 'package:gsg_firebase/global_widget.dart/custome_button.dart';
import 'package:provider/provider.dart';

class RegisterPage extends StatelessWidget {
  static final routeName = 'register';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Consumer<AuthProvider>(
        builder: (contex, provider, x) {
          return Column(
            children: [
              CustomrTextFeild('Email', provider.emailController),
              CustomrTextFeild('Password', provider.passwordController),
              CustomButton('Register', provider.register),
            ],
          );
        },
      ),
    );
  }
}
