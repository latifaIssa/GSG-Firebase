import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:gsg_firebase/Auth/Providers/auth_provider.dart';
import 'package:gsg_firebase/chats/widges/item_widget.dart';
import 'package:provider/provider.dart';

class ProfilePage extends StatefulWidget {
  static final routeName = 'profile';

  @override
  _ProfilePageState createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  @override
  void initState() {
    super.initState();
    Provider.of<AuthProvider>(context, listen: false).getUserFromFirebase();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          actions: [
            IconButton(onPressed: () {}, icon: Icon(Icons.edit)),
            IconButton(
                onPressed: () {
                  Provider.of<AuthProvider>(context, listen: false).logOut();
                },
                icon: Icon(Icons.logout))
          ],
        ),
        body: Consumer<AuthProvider>(builder: (context, provider, x) {
          return provider.user == null
              ? Center(child: CircularProgressIndicator())
              : Column(
                  children: [
                    GestureDetector(
                      onTap: () {},
                      child: CircleAvatar(
                        // height: 200,
                        // width: 200,
                        backgroundColor: Colors.grey,
                        backgroundImage: provider.file == null
                            ? AssetImage(
                                'assets/images/defaultProfileImage.png')
                            : FileImage(
                                provider.file,
                              ),
                        radius: 70,
                      ),
                    ),
                    ItemWidget('Email', provider.user.email),
                    ItemWidget('First Name', provider.user.fName),
                    ItemWidget('Last Name', provider.user.lName),
                    ItemWidget('City', provider.user.city),
                    ItemWidget('Country', provider.user.country),
                  ],
                );
        }));
  }
}
