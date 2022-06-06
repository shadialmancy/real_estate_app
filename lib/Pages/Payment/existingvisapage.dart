import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:real_estate_app/constants.dart';
import 'package:real_estate_app/functions.dart';

import 'package:flutter_credit_card/credit_card_widget.dart';
import 'package:http/http.dart' as http;

import '../../Classes/visacardClass.dart';
import '../../widgets/NavigationDrawerWidgetwithID.dart';
import '../../widgets/NavigationDrawerWidgetwithoutID.dart';

class ExistingVisaPage extends StatefulWidget {
  String amount;
  int userid;
  ExistingVisaPage({Key? key, this.amount = '0', this.userid = 0})
      : super(key: key);

  @override
  State<ExistingVisaPage> createState() => _ExistingVisaPageState();
}

class _ExistingVisaPageState extends State<ExistingVisaPage> {
  List<CardClass> model = [];
  List cards = [];

  cardData() async {
    return await http.post(Uri.parse(getData), body: {
      "command": "select * from visa_card where userID = ${widget.userid}"
    }).then((http.Response response) {
      fetchData = json.decode(response.body);
      // fetchData = fetchData.split(',');
      //print(fetchData);
      fetchData.forEach((card) {
        setState(() {
          model.add(CardClass(
              cardNumber: card['cardNumber'],
              expiryDate: card['expiryDate'],
              cardHolderName: card['cardHolderName'],
              cvvCode: card['cvvCode']));
          //print(model.length);
        });
      });

      for (var i = 0; i < model.length; i++) {
        cards.add(
          {
            'cardNumber': model[i].cardNumber,
            'expiryDate': model[i].expiryDate,
            'cardHolderName': model[i].cardHolderName,
            'cvvCode': model[i].cvvCode,
            'showBackView': false,
          },
        );
      }
    });
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    cardData();
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
          "Pick a card",
        ),
      ),
      body: Container(
          padding: const EdgeInsets.all(20),
          child: ListView.builder(
            itemBuilder: (BuildContext context, int index) {
              var card = cards[index];
              return InkWell(
                  onTap: () {
                    payViaExistingCard(
                        context, card, widget.amount, widget.userid);
                  },
                  child: CreditCardWidget(
                    cardNumber: card['cardNumber'],
                    expiryDate: card['expiryDate'],
                    cardHolderName: card['cardHolderName'],
                    cvvCode: card['cvvCode'],
                    showBackView: false,
                    // ignore: non_constant_identifier_names
                    onCreditCardWidgetChange: (CreditCardBrand) {},
                  ));
            },
            itemCount: cards.length,
          )),
    );
  }
}
