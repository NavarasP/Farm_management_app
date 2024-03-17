import 'dart:convert';
import 'constants.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:flutter/foundation.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:cluck_connect/authentication/welcoming_screen.dart';
import 'package:cluck_connect/services/api_models/farmer_model.dart';
import 'package:cluck_connect/services/api_models/authentication_model.dart';


class AuthenticationApi {
  static const String authTokenKey = 'authToken';


    static Future<String?> _getToken() {
    return AuthenticationApi.getAuthToken();
  }
  Future<void> saveUserDetails(
      String authToken, String username, String role, String agentId) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setString('authToken', authToken);
    prefs.setString('username', username);
    prefs.setString('role', role);
    prefs.setString('agentId', agentId); // Save agent ID to SharedPreferences
  }

  static Future<Map<String, String?>> getUserDetails() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    return {
      'authToken': prefs.getString('authToken'),
      'username': prefs.getString('username'),
      'role': prefs.getString('role'),
    };
  }

  static Future<String?> getAgentId() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getString('agentId');
  }

  static Future<String?> getAuthToken() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getString(authTokenKey);
  }

  // Method to check if the user is authenticated
  Future<bool> isAuthenticated() async {
    final String? authToken = await getAuthToken();
    return authToken != null;
  }

  Future<void> signIn(String email, String password) async {
    try {
      final response = await http.post(
        Uri.parse('$baseUrl/user/signin'),
        body: {'email': email, 'password': password},
      );
      debugPrint(response.body);

      if (response.statusCode == 200) {
        final Map<String, dynamic> responseData = json.decode(response.body);
        final String status = responseData['status'];

        if (status == 'success') {
          final String token = responseData['token'];
          final Map<String, dynamic> userData = responseData['data'];
          final String role = userData['role'];
          final String agentId = userData['agent']?? '';
          debugPrint(token);

          await saveUserDetails(token, email, role, agentId);
          debugPrint('Signed in successfully!');
        } else {
          debugPrint('Error signing in: Status - $status');
        }
      } else {
        debugPrint('Error signing in: ${response.statusCode}');
      }
    } catch (e) {
      debugPrint('Error signing in: $e');
      rethrow;
    }
  }

  static Future<Map<String, dynamic>> signUp(
      String role, String email, String password,
      {String? agentId}) async {
    try {
      final Map<String, String> requestBody = {
        'role': role,
        'email': email,
        'password': password,
        'confirmPassword': password,
      };

      if (role == 'farmer' && agentId != null) {
        requestBody['agent'] = agentId;
      }

      final response = await http.post(
        Uri.parse('$baseUrl/user/signup'),
        headers: <String, String>{'Content-Type': 'application/json'},
        body: jsonEncode(requestBody),
      );
      debugPrint(response.body);

      return jsonDecode(response.body);
    } catch (e) {
      debugPrint('Signup Error: $e');
      rethrow;
    }
  }

  static Future<User?> getMyUser(String token) async {
    try {
      final response = await http.get(
        Uri.parse('$baseUrl/user/me'),
        headers: <String, String>{'Authorization': 'Bearer $token'},
      );

      if (response.statusCode == 200) {
        final Map<String, dynamic> userData = jsonDecode(response.body);
        return User.fromJson(userData['data']);
      } else {
        debugPrint('Error fetching user details: ${response.statusCode}');
        return null;
      }
    } catch (e) {
      debugPrint('Error fetching user details: $e');
      return null;
    }
  }

  static Future<void> updateMyUser(String jsonString) async {
    final token = await _getToken();

    try {
      final url = Uri.parse('$baseUrl/user/me');


      final response = await http.patch(
        url,
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
          'Authorization': 'Bearer $token',
        },
        body: jsonString,
      );

      if (response.statusCode == 200) {
        // User data updated successfully
        debugPrint('Success');
      } else {
        // Error occurred while updating user data
        debugPrint('Error updating user data: ${response.body}');
      }
    } catch (e) {
      debugPrint('Error updating user data: $e');
      // Handle error
    }
  }


Future<void> signOut(BuildContext context) async {
  final SharedPreferences prefs = await SharedPreferences.getInstance();
  await prefs.clear();
  
  // Navigate to WelcomeScreen
  Navigator.pushAndRemoveUntil(
    context,
    MaterialPageRoute(builder: (context) => WelcomeScreen()),
    (Route<dynamic> route) => false, // Clear the navigation stack
  );
}

}

