// import 'package:flutter/cupertino.dart';
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:real_estate_app/Pages/Profile/MainProfile.dart';
import 'package:real_estate_app/Pages/Property/homepage.dart';
import 'package:real_estate_app/Pages/login.dart';
import 'package:real_estate_app/Payment/in-purchase_app_page.dart';
import 'package:real_estate_app/constants.dart';
import 'package:real_estate_app/services/Classes/userClass.dart';
import 'package:real_estate_app/services/payment-services.dart';
import 'package:stripe_payment/stripe_payment.dart';
import 'package:sn_progress_dialog/sn_progress_dialog.dart';
import 'Payment/existingvisapage.dart';
import 'package:http/http.dart' as http;

List fetchData = [];
List<UserClass> userModel = [];
void selectedItem(BuildContext context, int index, int userID) {
  Navigator.pop(context);
  switch (index) {
    case 0:
      Navigator.push(
        context,
        MaterialPageRoute(
            builder: (context) => HomePage(
                  userid: userID,
                )),
      );
      break;
    case 1:
      Navigator.push(
        context,
        MaterialPageRoute(
            builder: (context) => MainProfilePage(
                  userid: userID,
                )),
      );
      break;
    case 5:
      Navigator.push(
        context,
        MaterialPageRoute(
            builder: (context) => InPurchaseAppPage(
                  userID: userID,
                )),
      );
      break;
    case 9:
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => const LoginPage()),
      );
  }
}

onItemPressed(BuildContext context, int index, amount, int userID) async {
  switch (index) {
    case 0:
      payViaNewCard(context, amount, userID);
      break;
    case 1:
      Navigator.push(
          context,
          MaterialPageRoute(
              builder: (context) => ExistingVisaPage(
                    amount: amount,
                    userid: userID,
                  )));
      break;
  }
}

payViaNewCard(BuildContext context, String amount, int userID) async {
  ProgressDialog dialog = ProgressDialog(
    context: context,
  );
  int userAmount = userModel.isNotEmpty ? userModel[0].AmountofCoins : 0;
  var responseToDatabase = await http.post(Uri.parse(setData), body: {
    "command":
        "UPDATE users SET amount_coins = ${int.parse(amount) + userAmount} WHERE id=$userID"
  });
  amount = amount + '00';
  dialog.show(msg: "Please wait...", max: 100);
  var response =
      await StripeService.payViaNewCard(amount: amount, currency: 'USD');
  dialog.close();
  ScaffoldMessenger.of(context).showSnackBar(SnackBar(
    content: Text(response.message),
    duration: Duration(milliseconds: response.success == true ? 1200 : 3000),
  ));
  Navigator.pop(context);
}

payViaExistingCard(
    BuildContext context, card, String amount, int userID) async {
  int userAmount = userModel.isNotEmpty ? userModel[0].AmountofCoins : 0;
  var responseToDatabase = await http.post(Uri.parse(setData), body: {
    "command":
        "UPDATE users SET amount_coins = ${int.parse(amount) + userAmount} WHERE id=$userID"
  });
  amount = amount + '00';
  ProgressDialog dialog = ProgressDialog(context: context);
  dialog.show(msg: "Please wait...", max: 100);
  var expiryArr = card['expiryDate'].split('/');
  CreditCard stripeCard = CreditCard(
      number: card['cardNumber'],
      expMonth: int.parse(expiryArr[0]),
      expYear: int.parse(expiryArr[1]));

  var response = await StripeService.payViaExistingCard(
      amount: amount, currency: 'USD', card: stripeCard);
  dialog.close();

  ScaffoldMessenger.of(context)
      .showSnackBar(SnackBar(
        content: Text(response.message),
        duration:
            Duration(milliseconds: response.success == true ? 1200 : 3000),
      ))
      .closed
      .then((value) {
    Navigator.pop(context);
    Navigator.pop(context);
  });
}

UserData(id) async {
  fetchData.clear();
  return await http.post(Uri.parse(getData), body: {
    "command": "select * from users where id = $id"
  }).then((http.Response response) {
    fetchData = json.decode(response.body);

    fetchData.forEach((user) {
      userModel.add(UserClass(
          id: int.parse(user['id']),
          name: user['full_name'],
          phone: user['phone'],
          email: user['email'],
          image: user['image'],
          AmountofCoins: int.parse(user['amount_coins'])));
    });
  });
}
