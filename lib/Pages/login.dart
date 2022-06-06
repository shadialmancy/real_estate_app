import 'dart:convert';

import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:real_estate_app/Pages/Property/homepage.dart';
import 'package:real_estate_app/Pages/register.dart';
import 'package:real_estate_app/constants.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:http/http.dart' as http;
// import 'package:real_estate_app/services/Classes/userClass.dart';

// import '../forgetpasswordpage.dart';
import 'forgetpasswordpage.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  TextEditingController email = TextEditingController()..text = '';
  TextEditingController password = TextEditingController()..text = '';
  bool visiblePassword = true;

  // List<UserClass> model = [];
  List fetchData = [];

  void passwordVisible() {
    setState(() {
      visiblePassword = !visiblePassword;
    });
  }

  SelectAllData() async {
    return await http.post(Uri.parse(getData), body: {
      "command":
          "select * from users where email = '${email.text}' and password = '${password.text}'"
    }).then((http.Response response) {
      fetchData = json.decode(response.body);

      // print(fetchData);
      // fetchData.forEach((property) {
      //   setState(() {
      //     model.add(UserClass());
      //     //print(model.length);
      //   });
      // });
      if (fetchData.isNotEmpty) {
        Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => HomePage(
                userid: int.parse(fetchData[0]['id']),
              ),
            ));
      } else {
        ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
          content: Text("Incorrect username/password"),
          duration: Duration(milliseconds: 2000),
        ));
      }
    });
    // var response = await http
    //     .post(Uri.parse(getData), body: {"command": "SELECT * FROM property"});
    // fetchData = json.decode(json.encode(response.body));
    // print(fetchData);
    // if (data == "success") {
    //   print("success");
    // }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        // ignore: avoid_unnecessary_containers
        child: Container(
          height: MediaQuery.of(context).size.height,
          width: MediaQuery.of(context).size.width,
          color: white,
          child: Container(
            padding: const EdgeInsets.fromLTRB(20, 170, 20, 40),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                textField(email, 300, 55, "Email"),
                const SizedBox(
                  height: 10,
                ),
                passwordField(password, 300, 55, "Password", visiblePassword,
                    passwordVisible),
                const SizedBox(
                  height: 10,
                ),
                RichText(
                  text: TextSpan(
                      text: "Forget Password?",
                      style:
                          const TextStyle(fontSize: 16, color: Colors.black54),
                      recognizer: TapGestureRecognizer()
                        ..onTap = () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) =>
                                      const ForgetPasswordPage()));
                        }),
                ),
                const Spacer(
                  flex: 1,
                ),
                actionButtons("Login", SelectAllData, yellow, 250, 80),
                const SizedBox(
                  height: 10,
                ),
                //iconbuttons(),
                const SizedBox(
                  height: 10,
                ),
                RichText(
                  text: TextSpan(
                      text: "Don't have an Account? Register Here!",
                      style:
                          const TextStyle(fontSize: 16, color: Colors.black54),
                      recognizer: TapGestureRecognizer()
                        ..onTap = () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => const RegisterPage()),
                          );
                        }),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

// Widget iconbuttons() {
//   return Padding(
//     padding: const EdgeInsets.all(4.0),
//     child: Row(
//       mainAxisAlignment: MainAxisAlignment.center,
//       children: [
//         IconButton(
//             onPressed: () {
//               // ignore: todo
//               //TODO g+
//             },
//             icon: const Icon(
//               FontAwesomeIcons.googlePlus,
//               color: Color(0xFFdb4a39),
//             ),
//             iconSize: 50),
//         const SizedBox(width: 10),
//         IconButton(
//             onPressed: () {
//               // ignore: todo
//               //TODO face
//             },
//             icon: const Icon(
//               FontAwesomeIcons.facebook,
//               color: Color(0xFF4267B2),
//             ),
//             iconSize: 50),
//         const SizedBox(width: 10),
//         IconButton(
//             onPressed: () {},
//             icon: const Icon(FontAwesomeIcons.apple),
//             iconSize: 50),
//       ],
//     ),
//   );
// }
