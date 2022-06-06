import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:real_estate_app/Pages/login.dart';
import 'package:real_estate_app/constants.dart';
import 'package:real_estate_app/functions.dart';
// import 'package:real_estate_app/services/Classes/userClass.dart';
import 'package:real_estate_app/widgets/buildHeader.dart';
import 'package:http/http.dart' as http;
import 'buildMenuItem.dart';

// ignore: must_be_immutable
class NavigationDrawerWidgetwithoutID extends StatelessWidget {
  int id;
  NavigationDrawerWidgetwithoutID({Key? key, this.id = 0}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Drawer(
      backgroundColor: darkBlue,
      child: ListView(
        // ignore: prefer_const_literals_to_create_immutables
        children: <Widget>[
          const SizedBox(
            height: 40,
          ),
          Divider(
            color: white,
          ),
          buildMenuItem(
              icon: FontAwesomeIcons.house,
              text: 'HomePage',
              onClicked: () {
                selectedItem(context, 0, id);
              }),
          Divider(
            color: white,
          ),
          buildMenuItem(
              icon: FontAwesomeIcons.user,
              text: 'Login',
              onClicked: () {
                selectedItem(context, 9, id);
              }),
        ],
      ),
    );
  }
}
