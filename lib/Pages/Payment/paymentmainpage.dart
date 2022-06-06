import 'package:flutter/material.dart';
import 'package:real_estate_app/services/payment-services.dart';

import '../constants.dart';
import '../functions.dart';
import '../widgets/NavigationDrawerWidgetwithID.dart';

class PaymentMainPage extends StatefulWidget {
  String numofCoins, cost;
  int userid;
  PaymentMainPage(
      {Key? key, this.numofCoins = '0', this.cost = '0', this.userid = 0})
      : super(key: key);

  @override
  State<PaymentMainPage> createState() => _PaymentMainPageState();
}

class _PaymentMainPageState extends State<PaymentMainPage> {
  @override
  // ignore: must_call_super
  void initState() {
    // TODO: implement initState
    StripeService.init();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: NavigationDrawerWidget(
        id: widget.userid,
      ),
      appBar: AppBar(
        backgroundColor: darkBlue,
        title: const Text(
          "Payment",
        ),
      ),
      body: Container(
        padding: const EdgeInsets.all(20),
        child: ListView.separated(
          itemBuilder: (BuildContext context, int index) {
            Icon icon = const Icon(
              Icons.credit_card,
              color: Colors.black38,
            );
            Text text = const Text("");

            switch (index) {
              case 0:
                icon = const Icon(
                  Icons.add_circle,
                  color: Colors.black38,
                );
                text = const Text("Pay Via New Card");
                break;
              case 1:
                icon = const Icon(
                  Icons.credit_card,
                  color: Colors.black38,
                );
                text = const Text("Pay Via Existing Card");
                break;
            }

            return InkWell(
              onTap: () {
                onItemPressed(context, index, widget.cost, widget.userid);
              },
              child: ListTile(
                title: text,
                leading: icon,
              ),
            );
          },
          itemCount: 2,
          separatorBuilder: (BuildContext context, int index) {
            return const Divider(
              color: Colors.black38,
            );
          },
        ),
      ),
    );
  }
}
