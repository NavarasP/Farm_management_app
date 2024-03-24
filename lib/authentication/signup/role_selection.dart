import 'package:flutter/material.dart';
import 'package:cluck_connect/authentication/signup/agent_signup.dart';
import 'package:cluck_connect/authentication/signup/farmer_signup.dart';

class RoleSelectionScreen extends StatelessWidget {
  const RoleSelectionScreen({Key? key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Choose Your Role'),
      ),
      body: ListView(
        padding: const EdgeInsets.all(16.0),
        children: [
          Image.asset(
            'assets/logo.png',
            width: 200.0,
            height: 200.0,
          ),
          const SizedBox(height: 20),
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
    );
  }
}
