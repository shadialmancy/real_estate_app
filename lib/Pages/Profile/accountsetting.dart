import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import '../../constants.dart';
import '../../functions.dart';
import '../../widgets/NavigationDrawerWidgetwithID.dart';

class AccountSettingPage extends StatefulWidget {
  int userid;
  AccountSettingPage({Key? key, this.userid = 0}) : super(key: key);

  @override
  State<AccountSettingPage> createState() => _AccountSettingPageState();
}

class _AccountSettingPageState extends State<AccountSettingPage> {
  String name = userModel.isNotEmpty ? userModel[0].name : "name";
  String email = userModel.isNotEmpty ? userModel[0].email : "email";
  String phone = userModel.isNotEmpty ? userModel[0].phone : "phone";

  // bool _isEditingText = false;
  // TextEditingController nameController = TextEditingController();
  // TextEditingController emailController = TextEditingController();
  // TextEditingController phoneController = TextEditingController();

  // @override
  // void initState() {
  //   super.initState();
  //   nameController = TextEditingController(text: name);
  //   emailController = TextEditingController(text: email);
  //   phoneController = TextEditingController(text: phone);
  // }

  // @override
  // void dispose() {
  //   nameController.dispose();
  //   emailController.dispose();
  //   phoneController.dispose();
  //   super.dispose();
  // }

  // Widget _editTitleTextField(String value, TextEditingController controller) {
  //   if (_isEditingText) {
  //     return TextField(
  //       onSubmitted: (newValue) {
  //         setState(() {
  //           value = newValue;
  //           _isEditingText = false;
  //         });
  //       },
  //       autofocus: true,
  //       controller: controller,
  //     );
  //   }
  //   return InkWell(
  //       onTap: () {
  //         setState(() {
  //           _isEditingText = true;
  //         });
  //       },
  //       child: Text(
  //         value,
  //         style: TextStyle(
  //           color: Colors.black,
  //           fontSize: 18.0,
  //         ),
  //       ));
  // }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: NavigationDrawerWidget(
        id: widget.userid,
      ),
      appBar: AppBar(
        backgroundColor: darkBlue,
        title: const Text(
          "Account Setting",
        ),
      ),
      body: SingleChildScrollView(
        // ignore: avoid_unnecessary_containers
        child: Container(
            padding: EdgeInsets.all(20),
            child: Column(
              children: [
                // _editTitleTextField(name, nameController),
                buildAccountSetting(text: "Name", data: name),
                const Divider(
                  color: Colors.black54,
                ),
                buildAccountSetting(text: "Email", data: email),
                const Divider(
                  color: Colors.black54,
                ),
                buildAccountSetting(text: "Phone", data: phone)
              ],
            )),
      ),
    );
  }
}

Widget buildAccountSetting({
  required String text,
  required String data,
}) {
  return Container(
    padding: EdgeInsets.all(10),
    child: Row(children: [
      Text(
        text + " : " + data,
        style: const TextStyle(fontSize: 18, color: Colors.black87),
      ),
      // const Spacer(
      //   flex: 1,
      // ),
      // // IconButton(
      //     onPressed: () {},
      //     icon: const Icon(
      //       FontAwesomeIcons.pen,
      //       size: 15,
      //     ))
    ]),
  );
}
