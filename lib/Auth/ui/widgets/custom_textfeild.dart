import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class CustomrTextFeild extends StatelessWidget {
  String label;
  TextEditingController controller;
  CustomrTextFeild(this.label, this.controller);
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(
        horizontal: 10,
        vertical: 20,
      ),
      child: TextField(
        controller: this.controller,
        decoration: InputDecoration(
          labelText: this.label,
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(15),
          ),
        ),
      ),
    );
  }
}
