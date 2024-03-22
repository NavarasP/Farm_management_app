import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:cluck_connect/services/widgets.dart';
import 'package:cluck_connect/farmer/home_farmer.dart';
import 'package:cluck_connect/services/api/authentication_api.dart';

class UpdateProfileForm extends StatefulWidget {
  const UpdateProfileForm({Key? key}) : super(key: key);

  @override
  _UpdateProfileFormState createState() => _UpdateProfileFormState();
}

class _UpdateProfileFormState extends State<UpdateProfileForm> {

final nameController = TextEditingController();
  final areaController = TextEditingController();
    final stateController = TextEditingController();

  final genderController = TextEditingController();
final phonenumberController = TextEditingController();


  void update() {
    String name = nameController.text.trim();
    String area = areaController.text.trim();
    String state = stateController.text.trim();
    String gender = genderController.text.trim();
    String phone = phonenumberController.text.trim();


  if (name.isNotEmpty && area.isNotEmpty) {
    AuthenticationApi.updateMyUser(name, area, state, gender,phone).then((_) {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => HomePageFarmer()),
      );
    });
  }
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    return Scaffold(
      body: Stack(
        children: [
          Container(
            decoration: const BoxDecoration(
              gradient: LinearGradient(
                colors: [Color(0xff57aef0), Color(0xFFFFFFFF)],
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
              ),
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Container(
                  alignment: Alignment.centerLeft,
                  padding: const EdgeInsets.symmetric(horizontal: 40),
                  child: const Text(
                    "UPDATE",
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      color: Color(0xff0539bd),
                      fontSize: 36,
                    ),
                    textAlign: TextAlign.left,
                  ),
                ),
                SizedBox(height: size.height * 0.03),
                GlassInputField(
                  hintText: "Nameame",
                  controller: nameController,
                ),
                SizedBox(height: size.height * 0.03),
                GlassInputField(
                  hintText: "Area",
                  isPassword: true,
                  controller: areaController,
                ),
                SizedBox(height: size.height * 0.03),
                GlassInputField(
                  hintText: "State",
                  isPassword: true,
                  controller: stateController,
                ),
                SizedBox(height: size.height * 0.03),
                GlassInputField(
                  hintText: "Gender",
                  isPassword: true,
                  controller: genderController,
                ),
                SizedBox(height: size.height * 0.03),
                GlassInputField(
                  hintText: "Phone",
                  isPassword: true,
                  controller: phonenumberController,
                ),
                
                const SizedBox(height: 10),
                Container(
                  alignment: Alignment.centerRight,
                  margin:
                      const EdgeInsets.symmetric(horizontal: 40, vertical: 10),
                  child: ElevatedButton(
                    onPressed: update,
                    style: ElevatedButton.styleFrom(
                      foregroundColor: Colors.white,
                      backgroundColor: Colors.blue,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(80.0),
                      ),
                      padding: const EdgeInsets.all(0),
                    ),
                    child: Container(
                      alignment: Alignment.center,
                      height: 50.0,
                      width: size.width * 0.5,
                      padding: const EdgeInsets.all(0),
                      child: const Text(
                        "submit",
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
          Positioned(
            bottom: 0,
            left: 0,
            child: Image.asset(
              "assets/corner.png",
              height: 180,
            ),
          ),
        ],
      ),
    );
  }
}

