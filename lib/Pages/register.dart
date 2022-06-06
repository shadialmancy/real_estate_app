// ignore_for_file: deprecated_member_use

import 'dart:convert';
import 'dart:io';
import 'dart:typed_data';
import 'package:http/http.dart' as http;
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:real_estate_app/constants.dart';
import 'package:image_picker/image_picker.dart';

class RegisterPage extends StatefulWidget {
  const RegisterPage({Key? key}) : super(key: key);

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  TextEditingController nameController = TextEditingController()..text = '';
  TextEditingController emailController = TextEditingController()..text = '';
  TextEditingController passwordController = TextEditingController()..text = '';
  TextEditingController addressController = TextEditingController()..text = '';
  TextEditingController phoneController = TextEditingController()..text = '';
  File? image;
  String base64string = '';
  bool message1 = true;

  Future pickImage() async {
    try {
      final image = await ImagePicker().pickImage(source: ImageSource.gallery);
      if (image == null) return;
      final imageTemporary = File(image.path);
      setState(() {
        this.image = imageTemporary;
        ConvertImage(imageTemporary);
      });
    } on PlatformException catch (e) {
      print(e);
    }
  }

  Future ConvertImage(File image) async {
    Uint8List imageBytes = await image.readAsBytes(); //convert to bytes
    base64string = base64.encode(imageBytes); //convert bytes to base64 string
    //_addPost(base64string);
    print(base64string);
  }

  bool password = true;

  void passwordVisible() {
    setState(() {
      password = !password;
    });
  }

  addData() async {
    try {
      var response = await http.post(Uri.parse(setData), body: {
        "command": "INSERT INTO users(full_name,"
            "phone,"
            "address,"
            "email,"
            "password,"
            "image"
            ") VALUES ("
            "'${nameController.text}',"
            "'${phoneController.text}',"
            "'${addressController.text}',"
            "'${emailController.text}',"
            "'${passwordController.text}',"
            "'$base64string'"
            ")"
      });
      print(response.statusCode);
      if (200 == response.statusCode) {
        ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
          content: Text("success"),
          duration: Duration(milliseconds: 1200),
        ));
      } else {
        const SnackBar(
          content: Text("failed"),
        );
      }
    } catch (e) {
      print(e);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
          child: Container(
        height: MediaQuery.of(context).size.height,
        width: MediaQuery.of(context).size.width,
        color: white,
        padding: const EdgeInsets.fromLTRB(20, 100, 20, 40),
        child: Column(children: [
          textField(nameController, 300, 55, "Name"),
          const SizedBox(
            height: 10,
          ),
          textField(emailController, 300, 55, "Email",
              texttype: TextInputType.emailAddress),
          const SizedBox(
            height: 10,
          ),
          passwordField(passwordController, 300, 55, "Password", password,
              passwordVisible),
          const SizedBox(
            height: 10,
          ),
          textField(addressController, 300, 55, "Address"),
          const SizedBox(
            height: 10,
          ),
          textField(phoneController, 300, 55, "Phone",
              texttype: TextInputType.phone),
          const SizedBox(
            height: 10,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              const Text("Pick an Profile image:"),
              RaisedButton(
                  color: yellow,
                  onPressed: pickImage,
                  child: Text(
                    "pick a photo",
                    style: TextStyle(color: darkBlue),
                  ))
            ],
          ),
          const Spacer(
            flex: 1,
          ),
          actionButtons("Register", addData, yellow, 250, 50),
          const SizedBox(
            height: 15,
          ),
          RichText(
            text: TextSpan(
                text: "Do you have an Account? Login Here!",
                style: const TextStyle(fontSize: 16, color: Colors.black54),
                recognizer: TapGestureRecognizer()
                  ..onTap = () {
                    Navigator.pop(context);
                  }),
          ),
        ]),
      )),
    );
  }
}
