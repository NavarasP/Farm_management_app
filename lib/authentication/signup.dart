import 'package:flutter/material.dart';
import 'package:cluck_connect/services/widgets.dart';
import 'package:cluck_connect/authentication/login.dart';
import 'package:cluck_connect/services/api/authentication_api.dart';

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({super.key});

  @override
  // ignore: library_private_types_in_public_api
  _RegisterScreenState createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  String selectedUserRole = '';
  TextEditingController usernameController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController confirmPasswordController = TextEditingController();

  void setSelectedUserRole(String role) {
    setState(() {
      selectedUserRole = role;
    });
  }

  void signUp() {
    String username = usernameController.text.trim();
    String password = passwordController.text.trim();
    String confirmPassword = confirmPasswordController.text.trim();

    // if (username.isNotEmpty && password.isNotEmpty && confirmPassword.isNotEmpty && password == confirmPassword) {
      AuthenticationApi.signUp(selectedUserRole, username, password).then((response) {
        // Handle signup response
        Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => const LoginPage()));
      }).catchError((error) {
        // Handle error
        debugPrint("Signup Error: $error");
      });
    // } else {
    //   // Show error message or toast indicating invalid input
    //   debugPrint("Invalid input or passwords do not match");
    // }
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    return Scaffold(
      body: Stack(
        children: <Widget>[
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
                    "REGISTER",
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
                  hintText: "Username",
                  controller: usernameController,
                ),
                SizedBox(height: size.height * 0.03),
                GlassInputField(
                  hintText: "Password",
                  isPassword: true,
                  controller: passwordController,
                ),
                SizedBox(height: size.height * 0.03),
                GlassInputField(
                  hintText: "Confirm Password",
                  isPassword: true,
                  controller: confirmPasswordController,
                ),
                SizedBox(height: size.height * 0.03),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    UserTypeButton(userType: "Farmer", isSelected: selectedUserRole == "Farmer", onSelect: setSelectedUserRole),
                    const SizedBox(width: 20),
                    UserTypeButton(userType: "Agent", isSelected: selectedUserRole == "Agent", onSelect: setSelectedUserRole),
                  ],
                ),
                SizedBox(height: size.height * 0.03),
                Container(
                  alignment: Alignment.centerRight,
                  margin: const EdgeInsets.symmetric(horizontal: 40, vertical: 10),
                  child: ElevatedButton(
                    onPressed: signUp,
                    style: ElevatedButton.styleFrom(
                      foregroundColor: Colors.white,
                      backgroundColor: const Color(0xff0581e6),
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
                        "SIGN UP",
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ),
                ),
                Container(
                  alignment: Alignment.centerRight,
                  margin: const EdgeInsets.symmetric(horizontal: 40, vertical: 10),
                  child: GestureDetector(
                    onTap: () => Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const LoginPage(),
                      ),
                    ),
                    child: const Text(
                      "Already Have an Account? Login",
                      style: TextStyle(
                        fontSize: 12,
                        fontWeight: FontWeight.bold,
                        color: Color(0xFF2661FA),
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
              height: 150,
            ),
          ),
        ],
      ),
    );
  }
}
