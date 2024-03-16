import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:cluck_connect/services/api/farmers_api.dart';
import 'package:cluck_connect/services/api/authentication_api.dart';
import 'package:cluck_connect/services/api_models/farmer_model.dart';

class ProfilePageFarmer extends StatefulWidget {
  const ProfilePageFarmer({Key? key}) : super(key: key);

  @override
  _ProfilePageFarmerState createState() => _ProfilePageFarmerState();
}

class _ProfilePageFarmerState extends State<ProfilePageFarmer> {
  Profile? profileDetails;

  @override
  void initState() {
    super.initState();
    // Call the function to fetch user data
    fetchUserData();
  }

  Profile parseUserData(String jsonString) {
    Map<String, dynamic> data = jsonDecode(jsonString);
    return Profile.fromJson(data['data']);
  }

  Future<void> fetchUserData() async {
    try {
      Profile userData = await FarmApi.getUserData();
      setState(() {
        profileDetails = userData;
      });
    } catch (e) {
      debugPrint('Failed to fetch user data: $e');
      // Handle error
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Your Profile',
          style: TextStyle(
            color: Colors.white,
            fontSize: 20,
            fontWeight: FontWeight.bold,
          ),
        ),
        centerTitle: true,
        backgroundColor: Colors.blue,
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.only(
            bottomLeft: Radius.circular(20),
            bottomRight: Radius.circular(20),
          ),
        ),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Your Details',
              style: TextStyle(
                fontSize: 20.0,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 16),
            if (profileDetails != null) ...[
              _buildProfileDetail('Name', profileDetails!.name),
              _buildProfileDetail('Gender', profileDetails!.gender),
              _buildProfileDetail('State', profileDetails!.state),
              _buildProfileDetail('Contact Number', profileDetails!.phoneNumber.toString()),
              // Add more profile details as needed
            ] else ...[
              const CircularProgressIndicator(), // Show loading indicator while fetching data
            ],
          ],
        ),
      ),
      bottomNavigationBar: Container(
        decoration: const BoxDecoration(
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(20),
            topRight: Radius.circular(20),
          ),
          color: Colors.white,
        ),
        width: MediaQuery.of(context).size.width * 0.8,
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 8.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              ElevatedButton(
                onPressed: () {
                  AuthenticationApi authenticationApi = AuthenticationApi();
                  authenticationApi.signOut(context); // Call sign-out method on instance
                },
                child: const Text('Sign Out'),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildProfileDetail(String label, String value) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: const TextStyle(fontSize: 16, color: Colors.black87),
        ),
        const SizedBox(height: 8),
        Text(
          value,
          style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: Colors.black),
        ),
        const SizedBox(height: 16),
      ],
    );
  }
}
