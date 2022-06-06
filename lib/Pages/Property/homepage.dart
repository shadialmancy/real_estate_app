import 'dart:convert';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:http/http.dart' as http;
import 'package:real_estate_app/Pages/Property/property.dart';
import 'package:real_estate_app/Pages/login.dart';
import 'package:real_estate_app/constants.dart';
import 'package:real_estate_app/functions.dart';
import 'package:real_estate_app/services/Classes/propertyclass.dart';
import 'package:real_estate_app/widgets/NavigationDrawerWidgetwithoutID.dart';
import 'addproperty.dart';
import '../../widgets/NavigationDrawerWidgetwithID.dart';
import 'package:image_picker/image_picker.dart';

class HomePage extends StatefulWidget {
  int userid;
  HomePage({Key? key, this.userid = 0}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  late File image;
  final picker = ImagePicker();

  List<PropertyClass> model = [];
  List fetchData = [];

  // ignore: non_constant_identifier_names
  SelectPropertyData() async {
    return await http.post(Uri.parse(getData), body: {
      "command": "select * from property where sold = 'No'"
    }).then((http.Response response) {
      fetchData = json.decode(response.body);

      fetchData.forEach((property) {
        setState(() {
          model.add(PropertyClass(
              id: int.parse(property['id']),
              title: property['title'],
              image: property['image'],
              description: property['description'],
              price: property['price']));
          //print(model.length);
        });
      });
    });
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    setState(() {
      userModel.clear();
      SelectPropertyData();
      UserData(widget.userid);
    });
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
      floatingActionButton: FloatingActionButton(
        backgroundColor: yellow,
        onPressed: () {
          widget.userid != 0
              ? Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => CreatePropertyPage(
                      userid: widget.userid,
                    ),
                  ))
              : Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const LoginPage(),
                  ));
        },
        child: Icon(
          Icons.add,
          color: darkBlue,
        ),
      ),
      // body: ,
      body: ListView.separated(
        itemBuilder: (BuildContext context, int index) {
          return Card(
            child: SizedBox(
              child: ListTile(
                onTap: (() {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => PropertyPage(
                          propertyid: model[index].id,
                          userid: widget.userid,
                        ),
                      ));
                }),
                title: Text(
                  model[index].title,
                  textAlign: TextAlign.left,
                ),
                subtitle: Text(model[index].description +
                    "\n" +
                    "Price: " +
                    model[index].price),
                isThreeLine: true,
                leading: Image.memory(
                  base64Decode(base64.normalize(model[index].image)),
                  width: 100,
                  height: 100,
                  // alignment: Alignment.centerLeft,
                  fit: BoxFit.cover,
                ),
              ),
            ),
          );
        },
        itemCount: model.length,
        separatorBuilder: (BuildContext context, int index) {
          return const SizedBox(
            height: 15,
          );
        },
      ),
    );
  }
}

// class CustomSearchDelegate extends SearchDelegate {
//   @override
//   List<Widget>? buildActions(BuildContext context) {
//     IconButton(
//       icon: const Icon(FontAwesomeIcons.arrowLeft),
//       onPressed: () {
//         Navigator.pop(context);
//       },
//     );
//   }

//   @override
//   Widget? buildLeading(BuildContext context) {
//     IconButton(
//       // ignore: deprecated_member_use
//       icon: const Icon(FontAwesomeIcons.search),
//       onPressed: () {
//         if (query.isEmpty) {
//           close(context, null);
//         } else {
//           query = '';
//         }
//       },
//     );
//   }

//   @override
//   Widget buildResults(BuildContext context) {
//     HomePage(userid: widget.userid,)
//   }

//   @override
//   Widget buildSuggestions(BuildContext context) {
//     List<String> suggestions = ['for rent', 'for sale'];

//     return ListView.builder(
//       itemCount: suggestions.length,
//       itemBuilder: (context, index) {
//         final suggestion = suggestions[index];
//         return ListTile(
//           title: Text(suggestion),
//           onTap: () {
//             query = suggestion;
//             showResults(context);
//           },
//         );
//       },
//     );
//   }
// }
