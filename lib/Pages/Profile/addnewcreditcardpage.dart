import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import '../../constants.dart';
import '../../widgets/NavigationDrawerWidgetwithID.dart';

class AddNewCreditCardPage extends StatefulWidget {
  int userid;
  AddNewCreditCardPage({Key? key, this.userid = 0}) : super(key: key);

  @override
  State<AddNewCreditCardPage> createState() => _AddNewCreditCardPageState();
}

class _AddNewCreditCardPageState extends State<AddNewCreditCardPage> {
  TextEditingController cardNumberController = TextEditingController();
  TextEditingController dateController = TextEditingController();
  TextEditingController cardHolderNameController = TextEditingController();
  TextEditingController cvvController = TextEditingController();

  addNewVisa() async {
    return await http.post(Uri.parse(setData), body: {
      "command":
          "INSERT INTO visa_card VALUES(${widget.userid},'${cardNumberController.text}','${dateController.text}','${cardHolderNameController.text}','${cvvController.text}')"
    }).then((value) => {
          ScaffoldMessenger.of(context)
              .showSnackBar(const SnackBar(
                content: Text("The Visa has been added"),
                duration: Duration(milliseconds: 2000),
              ))
              .closed
              .then((value) => Navigator.pop(context))
        });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: white,
      appBar: AppBar(
        backgroundColor: darkBlue,
        title: const Text(
          "Add New Credit Card",
        ),
      ),
      drawer: NavigationDrawerWidget(
        id: widget.userid,
      ),
      bottomNavigationBar: Padding(
          padding: const EdgeInsets.all(10.0),
          child: actionButtons("Add", () {
            addNewVisa();
          }, yellow, 250, 50)),
      body: SingleChildScrollView(
        // ignore: avoid_unnecessary_containers
        child: Container(
          padding: const EdgeInsets.all(10.0),
          // height: MediaQuery.of(context).size.height,
          color: white,
          child: Column(
            // mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              textField(cardNumberController, MediaQuery.of(context).size.width,
                  50, "Card Number",
                  texttype: TextInputType.number, maxlength: 16),
              const SizedBox(
                height: 10,
              ),
              textField(dateController, MediaQuery.of(context).size.width, 50,
                  "Expiry Date in Format(MM/YY)",
                  texttype: TextInputType.datetime, maxlength: 5),
              const SizedBox(
                height: 10,
              ),
              textField(cardHolderNameController,
                  MediaQuery.of(context).size.width, 50, "Name"),
              const SizedBox(
                height: 10,
              ),
              textField(
                  cvvController, MediaQuery.of(context).size.width, 50, "cvv",
                  maxlength: 3, texttype: TextInputType.number),
            ],
          ),
        ),
      ),
    );
  }
}
