// ignore_for_file: deprecated_member_use

import 'package:flutter/material.dart';
import 'package:real_estate_app/Classes/fundsClass.dart';
import 'package:real_estate_app/Classes/fundsClass.dart';

import 'package:real_estate_app/functions.dart';

import '../../constants.dart';

import '../../widgets/NavigationDrawerWidgetwithID.dart';
import '../../widgets/NavigationDrawerWidgetwithoutID.dart';
import 'paymentmainpage.dart';

class InPurchaseAppPage extends StatefulWidget {
  int userID;
  InPurchaseAppPage({Key? key, this.userID = 0}) : super(key: key);

  @override
  State<InPurchaseAppPage> createState() => _InPageAppPageState();
}

class _InPageAppPageState extends State<InPurchaseAppPage> {
  List<Funds> funds = [
    Funds(numofCoins: '5', cost: '5'),
    Funds(numofCoins: '10', cost: '10'),
    Funds(numofCoins: '20', cost: '20'),
    Funds(numofCoins: '50', cost: '50'),
  ];

  int amountOfCoins = userModel.isNotEmpty ? userModel[0].AmountofCoins : 0;
  @override
  Widget build(BuildContext context) {
    setState(() {
      UserData(widget.userID);
    });
    return Scaffold(
      drawer: widget.userID != 0
          ? NavigationDrawerWidget(
              id: widget.userID,
            )
          : NavigationDrawerWidgetwithoutID(),
      appBar: AppBar(
        backgroundColor: darkBlue,
        title: const Text(
          "In-Purchase",
        ),
      ),
      body: SingleChildScrollView(
        child: Container(
          padding: const EdgeInsets.all(20),
          // ignore: prefer_const_literals_to_create_immutables
          child:
              Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
            Align(
                alignment: Alignment.topLeft,
                child: RichText(
                    text: const TextSpan(
                        style: TextStyle(color: Colors.black87),
                        children: <TextSpan>[
                      TextSpan(
                          text: "Add funds to your Wallet\n\n",
                          style: TextStyle(
                              fontSize: 30, fontWeight: FontWeight.bold)),
                      TextSpan(
                          text:
                              "Funds in your Wallet may be used for advertismenting your properties.\n",
                          style: TextStyle(
                            fontSize: 20,
                          )),
                    ]))),
            const Text(
              "YOUR ACCOUNT",
              style: TextStyle(fontSize: 25, fontWeight: FontWeight.bold),
            ),
            Container(
              color: const Color.fromARGB(77, 153, 153, 153),
              width: double.infinity,
              height: 50,
              padding: const EdgeInsets.symmetric(horizontal: 20),
              // ignore: prefer_const_literals_to_create_immutables
              child: Row(children: [
                const Text("Current Wallet balance"),
                const Spacer(
                  flex: 1,
                ),
                Text("$amountOfCoins")
              ]),
            ),
            const SizedBox(
              height: 20,
            ),
            SizedBox(
              height: 400,
              child: ListView.builder(
                itemBuilder: (BuildContext context, int index) {
                  return Card(
                    child: ListTile(
                      title: Text("Add ${funds[index].numofCoins} Coins"),
                      trailing: RaisedButton(
                          color: yellow,
                          onPressed: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => PaymentMainPage(
                                          numofCoins: funds[index].numofCoins,
                                          cost: funds[index].cost,
                                          userid: widget.userID,
                                        )));
                          },
                          child: const Text("Add Funds")),
                      subtitle: Text(funds[index].cost),
                    ),
                  );
                },
                itemCount: funds.length,
              ),
            )
          ]),
        ),
      ),
    );
  }
}
