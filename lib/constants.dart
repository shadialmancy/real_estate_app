import 'package:flutter/material.dart';

Color primaryColor = const Color.fromRGBO(255, 255, 255, 1);
Color yellow = const Color.fromRGBO(252, 185, 50, 1);
Color textColor = Color.fromARGB(255, 47, 47, 47);
Color white = Color.fromARGB(255, 255, 255, 255);
Color textFill = Colors.white;
Color darkBlue = const Color.fromRGBO(29, 41, 65, 1);
Color bar = const Color.fromRGBO(26, 82, 118, 1);

var setData = 'http://192.168.1.9:8080/RealEstateApp/setAPI.php';
var getData = 'http://192.168.1.9:8080/RealEstateApp/getAPI.php';

// Custom Text Field
Widget textField(
    TextEditingController text, double width, double height, String hint,
    {TextInputType texttype = TextInputType.text, int maxlength = 50}) {
  return Container(
    width: width,
    height: height,
    child: TextFormField(
      controller: text,
      style: TextStyle(
        color: textColor,
      ),
      maxLength: maxlength,
      decoration: InputDecoration(
          counterText: '',
          hintText: hint,
          suffixIcon: const Padding(
            padding: EdgeInsets.only(
              right: 10,
            ),
          ),
          fillColor: textFill,
          filled: true,
          border: const UnderlineInputBorder(),
          focusedBorder: const UnderlineInputBorder(
              borderSide: BorderSide(color: Colors.grey))),
      keyboardType: texttype,
    ),
  );
}

// Custom Password Field
Widget passwordField(TextEditingController text, double width, double height,
    String hint, bool password, VoidCallback onTap) {
  return Container(
    width: width,
    height: height,
    child: TextFormField(
      controller: text,
      style: TextStyle(
        color: textColor,
      ),
      decoration: InputDecoration(
          counterText: '',
          hintText: hint,
          suffixIcon: Padding(
            padding: const EdgeInsets.only(
              right: 10,
            ),
            child: IconButton(
              icon: Icon(
                password ? Icons.visibility_off : Icons.visibility,
                color: yellow,
              ),
              onPressed: onTap,
            ),
          ),
          fillColor: textFill,
          filled: true,
          border: const UnderlineInputBorder(),
          focusedBorder: const UnderlineInputBorder(
              borderSide: BorderSide(color: Colors.grey))),
      obscureText: password,
    ),
  );
}

// Custom Button for all pages to act on database
Widget actionButtons(String title, VoidCallback onTap, Color color,
    double width, double height) {
  return Container(
    width: width,
    height: height,
    decoration:
        // ignore: prefer_const_literals_to_create_immutables
        BoxDecoration(borderRadius: BorderRadius.circular(50), boxShadow: [
      const BoxShadow(
          blurRadius: 10,
          spreadRadius: 1,
          offset: Offset(4, 4),
          color: Colors.grey)
    ]),
    // ignore: deprecated_member_use
    child: RaisedButton(
      color: color,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.all(
          Radius.circular(50),
        ),
      ),
      child: Text(
        title,
        style: TextStyle(
          fontSize: 20,
          color: darkBlue,
        ),
      ),
      onPressed: onTap,
    ),
  );
}

//Profile Button
profileButton(String title, double width, double height, VoidCallback onTap,
    Color color) {
  return SizedBox(
    width: width,
    height: height,
    // ignore: deprecated_member_use
    child: RaisedButton(
      color: color,
      // padding: const EdgeInsets.only(
      //   top: 20,
      //   bottom: 20,
      //   left: 35,
      //   right: 35,
      // ),

      child: Text(
        title,
        style: TextStyle(
          fontSize: 20,
          color: textColor,
        ),
      ),
      onPressed: onTap,
    ),
  );
}

Widget textFieldProperty(
    TextEditingController text, double width, double height, String hint,
    {TextInputType textType = TextInputType.text}) {
  return Container(
    width: width,
    height: height,
    child: TextFormField(
      keyboardType: textType,
      controller: text,
      style: TextStyle(color: textColor, fontSize: 20),
      decoration: InputDecoration(
        counterText: '',
        hintText: hint,
        suffixIcon: const Padding(
          padding: EdgeInsets.only(
            right: 10,
          ),
        ),
        fillColor: textFill,
        filled: true,
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
      ),
    ),
  );
}
