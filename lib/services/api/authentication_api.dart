import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:flutter/foundation.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:cluck_connect/services/models/authentication_model.dart';

class AuthenticationApi {
  static const String baseUrl = 'http://127.0.0.1:8080/api/v1';
  static const String authTokenKey = 'authToken';

  Future<void> saveUserDetails(
      String authToken, String username, String role) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setString('authToken', authToken);
    prefs.setString('username', username);
    prefs.setString('role', role);
  }

  static Future<Map<String, String?>> getUserDetails() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    return {
      'authToken': prefs.getString('authToken'),
      'username': prefs.getString('username'),
      'role': prefs.getString('role'),
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

          await saveUserDetails(token, email, role);
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
      String role, String email, String password) async {
    try {
      final response = await http.post(
        Uri.parse('$baseUrl/user/signup'),
        headers: <String, String>{'Content-Type': 'application/json'},
        body: jsonEncode(<String, String>{
          'role': role,
          'email': email,
          'password': password,
          'confirmPassword': password,
        }),
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
}
