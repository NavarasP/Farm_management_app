import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:flutter/foundation.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:cluck_connect/services/models/authentication_model.dart';


class AuthenticationApi {
  static const String baseUrl = 'http://127.0.0.1:8000/api/v1/';
  static const String authTokenKey = 'authToken';


  static Future<Map<String, dynamic>> signUp(String role, String email, String password) async {
    final response = await http.post(
      Uri.parse('$baseUrl/user/signup'),
      headers: <String, String>{
        'Content-Type': 'application/json',
      },
      body: jsonEncode(<String, String>{
        'role': role,
        'email': email,
        'password': password,
        'confirmPassword': password,
      }),
    );

    return jsonDecode(response.body);
  }


  Future<void> saveUserDetails(
      String authToken, String username, String name, String userType) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setString('authToken', authToken);
    prefs.setString('username', username);
    prefs.setString('name', name);
    prefs.setString('userType', userType);
  }

  static Future<Map<String, String?>> getUserDetails() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    return {
      'authToken': prefs.getString('authToken'),
      'username': prefs.getString('username'),
      'name': prefs.getString('name'),
      'userType': prefs.getString('userType'),
    };
  }

  // Retrieve the auth token from SharedPreferences
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
      Uri.parse('$baseUrl/api/mobile/login/'),
      body: {'username': email, 'password': password},
    );

    if (response.statusCode == 200) {
      // Parse the response JSON
      final Map<String, dynamic> responseData = json.decode(response.body);

      // Extract the token and other user details from the response
      final String token = responseData['token'];
      final Map<String, dynamic> userData = responseData['data'];
      final String role = userData['role'];
      final String agentId = userData['agent']; // Assuming agentId is returned

      // Save user details
      await saveUserDetails(token, email, role, agentId);

      debugPrint('Signed in successfully!');
    } else {
      debugPrint('Error signing in: ${response.statusCode}');
      // Handle sign-in errors here
    }
  } catch (e) {
    debugPrint('Error signing in: $e');
    // Handle sign-in errors here
    rethrow; // Rethrow the exception for the caller to handle
  }
}

  static Future<User> getMyUser(String token) async {
    final response = await http.get(
      Uri.parse('$baseUrl/user/me'),
      headers: <String, String>{
        'Authorization': 'Bearer $token',
      },
    );

    final Map<String, dynamic> userData = jsonDecode(response.body);
    return User.fromJson(userData['data']);
  }
}
