import 'dart:convert';
import 'constants.dart';
import 'package:http/http.dart' as http;
import 'package:cluck_connect/services/api/authentication_api.dart';
import 'package:cluck_connect/services/api_models/farmer_model.dart';

class FarmApi {
  static Future<String?> _getToken() {
    return AuthenticationApi.getAuthToken();
  }

  static Future<Map<String, dynamic>> createFarm(String area) async {
    try {
      final token = await _getToken();

      final response = await http.post(
        Uri.parse('$baseUrl/farmer/farm/create'),
        headers: <String, String>{
          'Content-Type': 'application/json',
          'Authorization': 'Bearer $token',
        },
        body: jsonEncode(<String, String>{
          'area': area,
        }),
      );

      return jsonDecode(response.body);
    } catch (e) {
      print('Error creating farm: $e');
      throw Exception('Failed to create farm: $e');
    }
  }

  static Future<List<Farm>> getListOfFarmsForFarmer() async {
    try {
      final token = await _getToken();

      final response = await http.get(
        Uri.parse('$baseUrl/farmer/farms'),
        headers: <String, String>{
          'Authorization': 'Bearer $token',
        },
      );

      if (response.statusCode == 200) {
        final List<dynamic> farmsData = jsonDecode(response.body)['data'];
        List<Farm> farms = farmsData.map((farmData) => Farm.fromJson(farmData)).toList();
        return farms;
      } else {
        throw Exception('Failed to load farms: ${response.statusCode}');
      }
    } catch (e) {
      print('Error loading farms: $e');
      throw Exception('Failed to load farms: $e');
    }
  }

static Future<Map<String, dynamic>> createRecord(String jsonData) async {
  try {
    final token = await _getToken();

    final response = await http.post(
      Uri.parse('$baseUrl/farm/create'),
      headers: <String, String>{
        'Content-Type': 'application/json',
        'Authorization': 'Bearer $token',
      },
      body: jsonData
    );

    return jsonDecode(response.body);
  } catch (error) {
    print('Error creating record: $error');
    // You can throw the error if you want to handle it in the caller function
    throw error;
  }
}


static Future<List<FarmReport>> getRecordOfFarm(String farmId) async {
  try {
    final token = await _getToken();

    final response = await http.get(
      Uri.parse('$baseUrl/reports/$farmId'),
      headers: <String, String>{
        'Authorization': 'Bearer $token',
      },
    );

    if (response.statusCode == 200) {
      final List<dynamic> farmReportsData = jsonDecode(response.body)['data'];
      return farmReportsData.map((reportData) => FarmReport.fromJson(reportData)).toList();
    } else {
      // If the response status code is not 200, throw an exception with the error message
      throw Exception('Failed to get farm reports: ${response.statusCode}');
    }
  } catch (e) {
    // Print the error message if an exception occurs
    print('Error fetching farm reports: $e');
    // Re-throw the exception to propagate it further
    throw e;
  }
}

static Future<Profile> getUserData() async {
  try {
    final token = await _getToken();

    final response = await http.get(
      Uri.parse('$baseUrl/user/me'),
      headers: <String, String>{
        'Authorization': 'Bearer $token',
      },
    );

    if (response.statusCode == 200) {
      Map<String, dynamic> userData = jsonDecode(response.body)['data'];
      return Profile.fromJson(userData);
    } else {
      throw Exception('Failed to get user data: ${response.statusCode}');
    }
  } catch (e) {
    print('Error fetching user data: $e');
    throw Exception('Failed to get user data: $e');
  }
}


  static Future<Map<String, dynamic>> updateUserData(Map<String, dynamic> userData) async {
    final token = await _getToken();

    try {
      final response = await http.patch(
        Uri.parse('$baseUrl/user/me'),
        headers: <String, String>{
          'Authorization': 'Bearer $token',
          'Content-Type': 'application/json',
        },
        body: jsonEncode(userData),
      );

      if (response.statusCode == 200) {
        return jsonDecode(response.body);
      } else {
        throw Exception('Failed to update user data: ${response.statusCode}');
      }
    } catch (e) {
      throw Exception('Failed to update user data: $e');
    }
  }
}
