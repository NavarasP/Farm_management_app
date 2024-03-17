import 'package:flutter/material.dart';
import 'package:cluck_connect/services/widgets.dart';
import 'package:cluck_connect/authentication/login.dart';
import 'package:cluck_connect/services/api/authentication_api.dart';

class FarmerSignUpScreen extends StatefulWidget {
  const FarmerSignUpScreen({Key? key}) : super(key: key);

  @override
  _FarmerSignUpScreenState createState() => _FarmerSignUpScreenState();
}

class _FarmerSignUpScreenState extends State<FarmerSignUpScreen> {
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController confirmPasswordController = TextEditingController();
  TextEditingController agentIdController = TextEditingController(); // New controller for agent ID

  void signUp() {
    String email = emailController.text.trim();
    String password = passwordController.text.trim();
    String confirmPassword = confirmPasswordController.text.trim();
    String agentId = agentIdController.text.trim(); // Get agent ID from the text field

    if (password == confirmPassword) {
      if (agentId.isEmpty) {
        // Show error message if the user doesn't enter an agent ID
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Please enter an agent ID.'),
            duration: Duration(seconds: 2),
          ),
        );
        return;
      }

      AuthenticationApi.signUp("farmer", email, password, agentId: agentId).then((response) {
        // Handle signup response
        if (response['status'] == 'success') {
          Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => const LoginPage()));
        } else {
          // Print error message when signup fails
          debugPrint("Signup failed: ${response['message']}");
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text('Signup failed: ${response['message']}'),
              duration: Duration(seconds: 2),
            ),
          );
        }
      }).catchError((error) {
        // Handle error
        debugPrint("Signup Error: $error");
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Signup error: $error'),
            duration: Duration(seconds: 2),
          ),
        );
      });
    } else {
      // Show error message or toast indicating invalid input
      debugPrint("Invalid input or passwords do not match");
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Passwords do not match.'),
          duration: Duration(seconds: 2),
        ),
      );
    }
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
                  hintText: "Email",
                  controller: emailController,
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
                GlassInputField(
                  hintText: "Agent ID",
                  controller: agentIdController,
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
