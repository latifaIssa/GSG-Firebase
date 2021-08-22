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
  RegisterRequest({
    @required this.id,
    @required this.email,
    @required this.password,
    @required this.city,
    @required this.country,
    @required this.fname,
    @required this.lname,
  });

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'email': email,
      'city': city,
      'country': country,
      'fname': fname,
      'lname': lname,
    };
  }

  // factory RegisterRequest.fromMap(Map<String, dynamic> map) {
  //   return RegisterRequest(
  //     id: map['id'],
  //     email: map['email'],
  //     password: map['password'],
  //     city: map['city'],
  //     country: map['country'],
  //     fname: map['fname'],
  //     lname: map['lname'],
  //   );
  // }

  // String toJson() => json.encode(toMap());

  // factory RegisterRequest.fromJson(String source) =>
  //     RegisterRequest.fromMap(json.decode(source));
}
