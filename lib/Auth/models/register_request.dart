import 'dart:convert';

import 'package:flutter/cupertino.dart';

class RegisterRequest {
  String id;
  String email;
  String password;
  String city;
  String country;
  String fname;
  String lname;
  String imageUrl;
  RegisterRequest({
    @required this.id,
    @required this.email,
    @required this.password,
    @required this.city,
    @required this.country,
    @required this.fname,
    @required this.lname,
    @required this.imageUrl,
  });

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'email': email,
      'city': city,
      'country': country,
      'fname': fname,
      'lname': lname,
      'imageUrl': imageUrl
    };
  }
}
