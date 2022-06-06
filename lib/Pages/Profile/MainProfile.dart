import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:real_estate_app/Pages/Profile/accountsetting.dart';
import 'package:real_estate_app/constants.dart';

import '../../functions.dart';
import '../../widgets/NavigationDrawerWidgetwithID.dart';
import 'addnewcreditcardpage.dart';
// import 'changepasswordpage.dart';

class MainProfilePage extends StatefulWidget {
  int userid;
  MainProfilePage({Key? key, this.userid = 0}) : super(key: key);

  @override
  State<MainProfilePage> createState() => _MainProfilePageState();
}

class _MainProfilePageState extends State<MainProfilePage> {
  TextEditingController controller = TextEditingController()..text = '';

  String image = userModel.isNotEmpty ? userModel[0].image : "";
  String name = userModel.isNotEmpty ? userModel[0].name : "";
  String email = userModel.isNotEmpty ? userModel[0].email : "";
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: darkBlue,
        title: const Text(
          "Profile",
        ),
      ),
      drawer: NavigationDrawerWidget(
        id: widget.userid,
      ),
      body: SingleChildScrollView(
          child: Container(
        padding: const EdgeInsets.all(30),
        height: MediaQuery.of(context).size.height,
        width: MediaQuery.of(context).size.width,
        child: Column(crossAxisAlignment: CrossAxisAlignment.center,
            // ignore: prefer_const_literals_to_create_immutables
            children: [
              CircleAvatar(
                radius: 90,
                backgroundColor: Colors.blue,
                backgroundImage:
                    MemoryImage(base64Decode(base64.normalize(image))),
              ),
              const SizedBox(
                height: 20,
              ),
              Text(
                name,
                style: const TextStyle(fontSize: 25, color: Colors.black54),
              ),
              const SizedBox(
                height: 10,
              ),
              Text(
                email,
                style: const TextStyle(fontSize: 20, color: Colors.black26),
              ),
              const SizedBox(
                height: 40,
              ),
              profileButton("Account Settings", double.infinity, 70, () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: ((context) => AccountSettingPage(
                              userid: widget.userid,
                            ))));
              }, yellow),
              const SizedBox(
                height: 10,
              ),
              profileButton("New Credit Card", double.infinity, 70, () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: ((context) => AddNewCreditCardPage(
                              userid: widget.userid,
                            ))));
              }, yellow),
              const SizedBox(
                height: 10,
              ),
              // profileButton("Change Password", double.infinity, 70, () {
              //   Navigator.push(
              //       context,
              //       MaterialPageRoute(
              //           builder: ((context) => ChangePasswordPage(
              //                 userid: widget.userid,
              //               ))));
              // }, yellow),
            ]),
      )),
    );
  }
}
