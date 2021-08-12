import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:gsg_firebase/Auth/Providers/auth_provider.dart';
import 'package:gsg_firebase/Auth/ui/widgets/custom_textfeild.dart';
import 'package:provider/provider.dart';

class RegisterPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Register'),
      ),
      body: Consumer<AuthProvider>(
        builder: (contex, provider, x) {
          return Column(
            children: [
              CustomrTextFeild('Email', provider.emailController),
              CustomrTextFeild('Password', provider.passwordController),
              ElevatedButton(
                onPressed: () {
                  provider.register();
                },
                child: Text('Register'),
              )
            ],
          );
        },
      ),
    );
  }
}
