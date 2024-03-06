import 'package:flutter/material.dart';
import 'package:cluck_connect/agent/home_agent.dart';
import 'package:cluck_connect/services/widgets.dart';
import 'package:cluck_connect/farmer/home_farmer.dart';
import 'package:cluck_connect/authentication/signup.dart';
import 'package:cluck_connect/services/api/authentication_api.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  // ignore: library_private_types_in_public_api
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final usernameController = TextEditingController();
  final passwordController = TextEditingController();

  void signIn() {
    String username = usernameController.text.trim();
    String password = passwordController.text.trim();

    if (username.isNotEmpty && password.isNotEmpty) {
      AuthenticationApi().signIn(username, password).then((_) {
        AuthenticationApi.getUserDetails().then((userDetails) {
          String? userType = userDetails['role']; // Nullable string
          if (userType == 'farmer') {
            Navigator.pushReplacement(
                context,
                MaterialPageRoute(
                    builder: (context) => const HomePageFarmer()));
          } else if (userType == 'agent') {
            // Navigate to agent home page
            Navigator.pushReplacement(context,
                MaterialPageRoute(builder: (context) => const HomePageAgent()));
          } else {
            debugPrint(userType);
            // Handle unknown user type
            debugPrint("Unknown user type");
          }
        });
      }).catchError((error) {
        // Handle error
        debugPrint("Signin Error: $error");
      });
    } else {
      // Show error message or toast indicating invalid input
      debugPrint("Invalid username or password");
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
                    "LOGIN",
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
                Container(
                  alignment: Alignment.centerRight,
                  margin:
                      const EdgeInsets.symmetric(horizontal: 40, vertical: 10),
                  child: const Text(
                    "Forgot your password?",
                    style: TextStyle(fontSize: 12, color: Color(0xFF2661FA)),
                  ),
                ),
                const SizedBox(height: 10),
                Container(
                  alignment: Alignment.centerRight,
                  margin:
                      const EdgeInsets.symmetric(horizontal: 40, vertical: 10),
                  child: ElevatedButton(
                    onPressed: signIn,
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
                        "LOGIN",
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
                  margin:
                      const EdgeInsets.symmetric(horizontal: 40, vertical: 10),
                  child: GestureDetector(
                    onTap: () => Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const RegisterScreen(),
                      ),
                    ),
                    child: const Text(
                      "Don't Have an Account? Sign up",
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
              height: 180,
            ),
          ),
        ],
      ),
    );
  }
}
