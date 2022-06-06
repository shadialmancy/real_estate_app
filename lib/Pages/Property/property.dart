import 'dart:convert';
import 'dart:io';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:real_estate_app/Pages/login.dart';
import 'package:real_estate_app/functions.dart';
import 'package:real_estate_app/widgets/map.dart';
import '../../Classes/propertyclass.dart';
// import '../../Payment/in-purchase_app_page.dart';
import '../../constants.dart';
// import '../../services/Classes/propertyclass.dart';

import '../../widgets/NavigationDrawerWidgetwithID.dart';
import '../../widgets/NavigationDrawerWidgetwithoutID.dart';
import '../Payment/in-purchase_app_page.dart';

class PropertyPage extends StatefulWidget {
  int propertyid = 0;
  int userid;
  PropertyPage({Key? key, required this.propertyid, this.userid = 0})
      : super(key: key);

  @override
  State<PropertyPage> createState() => _PropertyPageState();
}

class _PropertyPageState extends State<PropertyPage> {
  late File image;
  final picker = ImagePicker();

  List<PropertyClass> model = [];
  List fetchData = [];

  SelectAllData() async {
    return await http.post(Uri.parse(getData), body: {
      "command": "select * from property where id = ${widget.propertyid}"
    }).then((http.Response response) {
      fetchData = json.decode(response.body);
      // fetchData = fetchData.split(',');
      //print(fetchData);
      fetchData.forEach((property) {
        setState(() {
          model.add(PropertyClass(
            id: int.parse(property['id']),
            title: property['title'],
            hall: int.parse(property['hall']),
            bedroom: int.parse(property['bedroom']),
            balcony: int.parse(property['balcony']),
            bathroom: int.parse(property['bathroom']),
            price: property['price'],
            address: property['address'],
            description: property['description'],
            longitude: double.parse(property['longitude']),
            latitude: double.parse(property['latitude']),
            property_owner: property['property_owner'],
            email: property['email'],
            image: property['image'],
          ));
          //print(model.length);
        });
      });
    });
    // var response = await http
    //     .post(Uri.parse(getData), body: {"command": "SELECT * FROM property"});
    // fetchData = json.decode(json.encode(response.body));
    // print(fetchData);
    // if (data == "success") {
    //   print("success");
    // }
  }

  Purchase() async {
    if (widget.userid != 0) {
      UserData(widget.userid);
      int amountOfCoins = userModel.isNotEmpty ? userModel[0].AmountofCoins : 0;
      int price = model.isNotEmpty ? int.parse(model[0].price) : 0;
      int result = amountOfCoins - price;
      if (amountOfCoins < price) {
        Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) => InPurchaseAppPage(
                      userID: widget.userid,
                    )));
      } else {
        var response = await http.post(Uri.parse(setData), body: {
          "command":
              "UPDATE property SET sold = 'Yes' WHERE id=${widget.propertyid}"
        });
        var response2 = await http.post(Uri.parse(setData), body: {
          "command":
              "UPDATE users SET amount_coins = $result WHERE id=${widget.userid}"
        });
        ScaffoldMessenger.of(context)
            .showSnackBar(const SnackBar(
              content: Text("Thanks for Purchasing!"),
              duration: Duration(milliseconds: 2000),
            ))
            .closed
            .then((value) => Navigator.pop(context));
      }
    } else {
      Navigator.push(
          context, MaterialPageRoute(builder: (context) => const LoginPage()));
    }
  }

  @override
  void initState() {
    // TODO: implement initState
    SelectAllData();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: Padding(
          padding: const EdgeInsets.all(10.0),
          child: actionButtons("Purchase", () {
            Purchase();
          }, yellow, 250, 50)),
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
          child:
              Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
            SizedBox(
              child: model.isNotEmpty
                  ? Image.memory(
                      base64Decode(base64.normalize(model[0].image)),
                    )
                  : const Text("no image"),
            ),
            const SizedBox(
              height: 20,
            ),
            displayDetails()
          ]),
        ),
      ),
    );
  }

  Widget row(String title, Object text) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          title,
          style: const TextStyle(fontSize: 20),
        ),
        Text(
          text.toString(),
          style: const TextStyle(fontSize: 20),
        )
      ],
    );
  }

  Widget rowWithIcon(String title, Object text) {
    return Row(
      //mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          title,
          style: const TextStyle(fontSize: 20),
        ),
        const Spacer(
          flex: 1,
        ),
        Text(
          text.toString(),
          style: const TextStyle(fontSize: 20),
        ),
        const SizedBox(
          width: 10,
        ),
        const Icon(FontAwesomeIcons.coins),
      ],
    );
  }

  Widget displayDetails() {
    double latitude = model.isNotEmpty ? model[0].latitude : 0;
    double longitude = model.isNotEmpty ? model[0].longitude : 0;
    return Column(
      children: [
        Center(
          child: Text(
            (model.isNotEmpty ? model[0].title : 'None'),
            style: const TextStyle(fontSize: 30, fontWeight: FontWeight.bold),
          ),
        ),
        rowWithIcon(
            "price:", model.isNotEmpty ? model[0].price.toString() : "None"),
        const SizedBox(
          height: 20,
        ),
        row("bedroom:",
            model.isNotEmpty ? model[0].bedroom.toString() : "None"),
        const SizedBox(
          height: 20,
        ),
        row("hall:", model.isNotEmpty ? model[0].hall.toString() : "None"),
        const SizedBox(
          height: 20,
        ),
        row("kitchen:",
            model.isNotEmpty ? model[0].kitchen.toString() : "None"),
        const SizedBox(
          height: 20,
        ),
        row("bathroom:",
            model.isNotEmpty ? model[0].bathroom.toString() : "None"),
        const SizedBox(
          height: 20,
        ),
        row("balcony:",
            model.isNotEmpty ? model[0].balcony.toString() : "None"),
        const SizedBox(
          height: 20,
        ),
        row("address:", model.isNotEmpty ? model[0].address : "None"),
        const SizedBox(
          height: 20,
        ),
        row("description:", model.isNotEmpty ? model[0].description : "None"),
        const SizedBox(
          height: 20,
        ),
        row("propert owner:",
            model.isNotEmpty ? model[0].property_owner : "None"),
        const SizedBox(
          height: 20,
        ),
        row("email:", model.isNotEmpty ? model[0].email : "None"),
        const SizedBox(
          height: 20,
        ),
        SizedBox(
            height: 300,
            child: latitude != 0 && longitude != 0
                ? GPSMap(
                    longitude: longitude,
                    latitude: latitude,
                  )
                : Container(
                    child: const Center(child: Text("None")),
                  ))
      ],
    );
  }
}
