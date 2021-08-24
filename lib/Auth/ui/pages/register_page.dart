import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:gsg_firebase/Auth/Providers/auth_provider.dart';
import 'package:gsg_firebase/Auth/models/countryModel.dart';
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
          return SingleChildScrollView(
            child: Column(
              children: [
                CustomrTextFeild('FirstName', provider.firstNameController),
                CustomrTextFeild('LastName', provider.lastNameController),
                CustomrTextFeild('Country', provider.countryNameController),
                CustomrTextFeild('City', provider.cityController),
                CustomrTextFeild('Email', provider.emailController),
                CustomrTextFeild('Password', provider.passwordController),
                provider.countries == null
                    ? Container()
                    : Container(
                        child: DropdownButton<CountryModel>(
                          value: provider.selectedCountry,
                          onChanged: (x) {
                            provider.selectCountry(x);
                          },
                          items: provider.countries.map((e) {
                            return DropdownMenuItem<CountryModel>(
                              child: Text(e.name),
                              value: e,
                            );
                          }).toList(),
                        ),
                      ),
                provider.cities == null
                    ? Container()
                    : Container(
                        child: DropdownButton<dynamic>(
                          value: provider.selectedCity,
                          onChanged: (x) {
                            provider.selectCity(x);
                          },
                          items: provider.cities.map((e) {
                            return DropdownMenuItem<dynamic>(
                              child: Text(e),
                              value: e,
                            );
                          }).toList(),
                        ),
                      ),
                CustomButton('Register', provider.register),
              ],
            ),
          );
        },
      ),
    );
  }
}
