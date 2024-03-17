import 'package:flutter/material.dart';
import 'package:cluck_connect/authentication/signup/agent_signup.dart';
import 'package:cluck_connect/authentication/signup/farmer_signup.dart';



class RoleSelectionScreen extends StatelessWidget {
  const RoleSelectionScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Choose Your Role'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => AgentSignUpScreen()),
                );
              },
              child: Text('I am an Agent'),
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => FarmerSignUpScreen()),
                );
              },
              child: Text('I am a Farmer'),
            ),
          ],
        ),
      ),
    );
  }
}
