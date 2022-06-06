import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:real_estate_app/constants.dart';
import 'dart:math';
import 'package:mailer/mailer.dart';
import 'package:mailer/smtp_server/gmail.dart';
import 'package:http/http.dart' as http;

import '../Classes/userClass.dart';
// import 'package:real_estate_app/services/Classes/userClass.dart';

class ForgetPasswordPage extends StatefulWidget {
  const ForgetPasswordPage({Key? key}) : super(key: key);

  @override
  State<ForgetPasswordPage> createState() => _ForgetPasswordPageState();
}

class _ForgetPasswordPageState extends State<ForgetPasswordPage> {
  TextEditingController emailController = TextEditingController();

  Random random = Random();
  int randomNumber = 0;

  List<UserClass> model = [];
  List fetchData = [];
  forgetPassword() async {
    return await http.post(Uri.parse(getData), body: {
      "command": "select * from users where email = '${emailController.text}'"
    }).then((http.Response response) async {
      fetchData = json.decode(response.body);

      //print(fetchData);
      // fetchData.forEach((property) {
      //   setState(() {
      //     model.add(UserClass());
      //     //print(model.length);
      //   });
      // });
      if (fetchData.isNotEmpty) {
        randomNumber = random.nextInt(100000);
        var response2 = await http.post(Uri.parse(setData), body: {
          "command":
              "UPDATE users SET password = '$randomNumber' WHERE email = '${emailController.text}'"
        });
        sendMail();
        ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
          content: Text("The password has been reset."),
          duration: Duration(milliseconds: 3000),
        ));
        Navigator.pop(context);
      } else {
        ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
          content: Text("This email is not valid."),
          duration: Duration(milliseconds: 3000),
        ));
      }
    });
  }

  //mail
  sendMail() async {
    String username = "realestate6412@gmail.com";
    String password = "shooshoo@99";

    final smtpServer = gmail(username, password);
    // Creating the Gmail server

    // Create our email message.
    final message = Message()
      ..from = Address(username)
      ..recipients.add(emailController.text) //recipent email
      //..ccRecipients.addAll(['destCc1@example.com', 'destCc2@example.com']) //cc Recipents emails
      //..bccRecipients.add(Address('bccAddress@example.com')) //bcc Recipents emails
      ..subject =
          'Password recover link from shawondeveloper : ${DateTime.now()}' //subject of the email
      //..text =
      //'This is the plain text.\nThis is line 2 of the text part.'
      ..html =
          "<h3>Thanks for with localhost. Your new password is $randomNumber</p>"; //body of the email

    try {
      final sendReport = await send(message, smtpServer);
      print('Message sent: ' +
          sendReport.toString()); //print if the email is sent
    } on MailerException catch (e) {
      print('Message not sent. \n' +
          e.toString()); //print if the email is not sent
      // e.toString() will show why the email is not sending
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        height: MediaQuery.of(context).size.height,
        width: MediaQuery.of(context).size.width,
        color: white,
        child: Center(
            child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            textField(
                emailController, 350, 55, "Enter email to reset the Password."),
            actionButtons("Reset", forgetPassword, yellow, 250, 80)
          ],
        )),
      ),
    );
  }
}
