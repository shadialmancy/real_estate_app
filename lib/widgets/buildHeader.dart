import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:real_estate_app/constants.dart';

Widget buildHeader(
    {
    //required string image,
    required String name,
    required String email,
    String image = '',
    int amountofCoins = 0}) {
  return Container(
    padding: const EdgeInsets.symmetric(vertical: 30, horizontal: 20),
    color: yellow,
    child: Column(
      children: [
        Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          // ignore: prefer_const_literals_to_create_immutables
          children: [
            Container(
              decoration: BoxDecoration(
                  boxShadow: [
                    const BoxShadow(
                        blurRadius: 10,
                        spreadRadius: 1,
                        offset: Offset(1, 6),
                        color: Colors.black54)
                  ],
                  borderRadius: BorderRadius.circular(90),
                  border: Border.all(width: 2, color: darkBlue)),
              child: CircleAvatar(
                radius: 90,
                // backgroundColor: Colors.blue,
                backgroundImage:
                    MemoryImage(base64Decode(base64.normalize(image))),
              ),
            ),
            const SizedBox(
              height: 20,
            ),
            Text(
              name,
              style: TextStyle(fontSize: 20, color: white),
            ),
            const SizedBox(
              height: 4,
            ),
            Text(
              email,
              style: TextStyle(fontSize: 12, color: white),
            ),
            const SizedBox(
              height: 10,
            )
          ],
        ),
        Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const SizedBox(
              width: 80,
            ),
            Icon(
              FontAwesomeIcons.coins,
              color: white,
            ),
            const SizedBox(
              width: 30,
            ),
            Text(
              amountofCoins.toString(),
              style: TextStyle(color: white),
            )
          ],
        )
      ],
    ),
  );
}
