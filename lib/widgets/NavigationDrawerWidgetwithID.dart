import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:real_estate_app/Pages/login.dart';
import 'package:real_estate_app/constants.dart';
import 'package:real_estate_app/functions.dart';
import 'package:real_estate_app/services/Classes/userClass.dart';
import 'package:real_estate_app/widgets/buildHeader.dart';
import 'package:http/http.dart' as http;
import 'buildMenuItem.dart';

// ignore: must_be_immutable
class NavigationDrawerWidget extends StatelessWidget {
  int id;
  NavigationDrawerWidget({Key? key, this.id = 0}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // UserData();
    UserData(id);
    String name = userModel.isNotEmpty ? userModel[0].name : "name";
    String email = userModel.isNotEmpty ? userModel[0].email : "email";
    String image = userModel.isNotEmpty ? userModel[0].image : "image";
    int amountofCoins = userModel.isNotEmpty ? userModel[0].AmountofCoins : 0;

    return Drawer(
      backgroundColor: darkBlue,
      child: ListView(
        // ignore: prefer_const_literals_to_create_immutables
        children: <Widget>[
          // const SizedBox(
          //   height: 40,
          // ),
          buildHeader(
              name: name,
              email: email,
              image: image,
              amountofCoins: amountofCoins),
          const SizedBox(
            height: 20,
          ),

          buildMenuItem(
              icon: FontAwesomeIcons.house,
              text: 'HomePage',
              onClicked: () {
                selectedItem(context, 0, id);
              }),

          buildMenuItem(
              icon: FontAwesomeIcons.user,
              text: 'Profile',
              onClicked: () {
                selectedItem(context, 1, id);
              }),

          buildMenuItem(
              icon: FontAwesomeIcons.rightFromBracket,
              text: 'Logout',
              onClicked: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => LoginPage(),
                    ));
              }),

          // buildMenuItem(
          //     icon: FontAwesomeIcons.gear, text: 'Setting', onClicked: () {}),
          //
          buildMenuItem(
              icon: FontAwesomeIcons.coins,
              text: 'Purchase',
              onClicked: () {
                selectedItem(context, 5, id);
              }),
        ],
      ),
    );
  }
}
