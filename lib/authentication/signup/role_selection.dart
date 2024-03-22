import 'package:flutter/material.dart';
import 'package:cluck_connect/authentication/signup/agent_signup.dart';
import 'package:cluck_connect/authentication/signup/farmer_signup.dart';



class RoleSelectionScreen extends StatelessWidget {
  const RoleSelectionScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Choose Your Role'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const AgentSignUpScreen()),
                );
              },
              child: const Text('I am an Agent'),
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const FarmerSignUpScreen()),
                );
              },
              child: const Text('I am a Farmer'),
            ),
          ],
        ),
      ),
    );
  }
}
