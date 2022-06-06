// ignore_for_file: deprecated_member_use

import 'dart:convert';
import 'dart:io';
import 'dart:typed_data';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:real_estate_app/constants.dart';
import 'package:real_estate_app/widgets/NavigationDrawerWidgetwithID.dart';
import 'package:image_picker/image_picker.dart';

import '../../widgets/NavigationDrawerWidgetwithoutID.dart';

class CreatePropertyPage extends StatefulWidget {
  int userid;
  CreatePropertyPage({Key? key, this.userid = 0}) : super(key: key);

  @override
  State<CreatePropertyPage> createState() => _CreatePropertyPageState();
}

class _CreatePropertyPageState extends State<CreatePropertyPage> {
  TextEditingController title = TextEditingController()..text = '';
  TextEditingController bedroom = TextEditingController()..text = '';
  TextEditingController hall = TextEditingController()..text = '';
  TextEditingController kitchen = TextEditingController()..text = '';
  TextEditingController bathroom = TextEditingController()..text = '';
  TextEditingController balcony = TextEditingController()..text = '';
  TextEditingController price = TextEditingController()..text = '';
  TextEditingController address = TextEditingController()..text = '';
  TextEditingController description = TextEditingController()..text = '';
  TextEditingController latitude = TextEditingController()..text = '';
  TextEditingController longitude = TextEditingController()..text = '';
  TextEditingController propertyOwner = TextEditingController()..text = '';
  TextEditingController propertyType = TextEditingController()..text = '';
  TextEditingController email = TextEditingController()..text = '';
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

  addData() async {
    try {
      var response = await http.post(Uri.parse(setData), body: {
        "command": "INSERT INTO property(title,"
            "bedroom,"
            " hall,"
            "kichan,"
            "bathroom,"
            "balcony,"
            "price,"
            "address,"
            "image,"
            "description,"
            "property_owner,"
            "property_type,"
            "longitude,"
            "latitude,"
            " email"
            ") VALUES ("
            "'${title.text}',"
            "'${bedroom.text}',"
            "'${hall.text}',"
            "'${kitchen.text}',"
            "'${bathroom.text}',"
            "'${balcony.text}',"
            "'${price.text}',"
            "'${address.text}',"
            "'$base64string',"
            "'${description.text}',"
            "'${propertyOwner.text}',"
            "'${propertyType.text}',"
            "${longitude.text},"
            "${latitude.text},"
            "'${email.text}'"
            ")"
      });
      //print(response.statusCode);
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
      drawer: widget.userid != 0
          ? NavigationDrawerWidget(
              id: widget.userid,
            )
          : NavigationDrawerWidgetwithoutID(),
      appBar: AppBar(
        backgroundColor: darkBlue,
        title: const Text(
          "Homepage",
        ),
      ),
      body: SingleChildScrollView(
          child: Container(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            textFieldProperty(title, 200, 50, "Title"),
            const SizedBox(
              height: 5,
            ),
            Row(
              children: [
                const Text("Choose File:"),
                const Spacer(
                  flex: 1,
                ),
                RaisedButton(
                    color: yellow,
                    onPressed: pickImage,
                    child: Text(
                      "pick a photo",
                      style: TextStyle(color: darkBlue),
                    ))
              ],
            ),
            const SizedBox(
              height: 5,
            ),
            textFieldProperty(bedroom, 200, 50, "bedroom",
                textType: TextInputType.number),
            const SizedBox(
              height: 5,
            ),
            textFieldProperty(hall, 200, 50, "hall",
                textType: TextInputType.number),
            const SizedBox(
              height: 5,
            ),
            textFieldProperty(kitchen, 200, 50, "kitchen",
                textType: TextInputType.number),
            const SizedBox(
              height: 5,
            ),
            textFieldProperty(bathroom, 200, 50, "bathroom",
                textType: TextInputType.number),
            const SizedBox(
              height: 5,
            ),
            textFieldProperty(balcony, 200, 50, "balcony",
                textType: TextInputType.number),
            const SizedBox(
              height: 5,
            ),
            textFieldProperty(price, 200, 50, "price",
                textType: TextInputType.number),
            const SizedBox(
              height: 5,
            ),
            textFieldProperty(address, 200, 50, "address"),
            const SizedBox(
              height: 5,
            ),
            textFieldProperty(description, 200, 50, "description"),
            const SizedBox(
              height: 5,
            ),
            Row(
              children: [
                textFieldProperty(latitude,
                    MediaQuery.of(context).size.width * 0.4, 50, "Latitude"),
                textFieldProperty(longitude,
                    MediaQuery.of(context).size.width * 0.5, 50, "Longitude"),
              ],
            ),
            const SizedBox(
              height: 5,
            ),
            textFieldProperty(propertyOwner, 200, 50, "propertyOwner"),
            const SizedBox(
              height: 5,
            ),
            textFieldProperty(propertyType, 200, 50, "propertyType"),
            const SizedBox(
              height: 5,
            ),
            textFieldProperty(email, 200, 50, "email",
                textType: TextInputType.emailAddress),
            const SizedBox(
              height: 5,
            ),
            actionButtons("Add", addData, yellow, 250, 50)
          ],
        ),
      )),
    );
  }
}
