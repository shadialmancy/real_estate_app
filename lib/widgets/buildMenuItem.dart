import 'package:flutter/material.dart';
import 'package:real_estate_app/constants.dart';

Widget buildMenuItem(
    {required String text,
    required IconData icon,
    required VoidCallback onClicked}) {
  const color = Colors.black87;
  return ListTile(
    leading: Icon(
      icon,
      color: white,
    ),
    title: Text(
      text,
      style: TextStyle(color: white),
    ),
    onTap: onClicked,
  );
}
