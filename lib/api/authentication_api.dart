import 'dart:convert';
import 'package:http/http.dart' as http;

class AuthenticationApi {
  static const String baseUrl = 'http://your-api-base-url.com/api/v1';

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

  static Future<Map<String, dynamic>> signIn(String email, String password) async {
    final response = await http.post(
      Uri.parse('$baseUrl/user/signin'),
      headers: <String, String>{
        'Content-Type': 'application/json',
      },
      body: jsonEncode(<String, String>{
        'email': email,
        'password': password,
      }),
    );

    return jsonDecode(response.body);
  }

  static Future<Map<String, dynamic>> getMyUser(String token) async {
    final response = await http.get(
      Uri.parse('$baseUrl/user/me'),
      headers: <String, String>{
        'Authorization': 'Bearer $token',
      },
    );

    return jsonDecode(response.body);
  }
}