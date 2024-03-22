import 'dart:convert';
import 'constants.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:cluck_connect/services/api/authentication_api.dart';
import 'package:cluck_connect/services/api_models/agent_model.dart';



class AgentApi {
    static Future<String?> _getToken() {
    return AuthenticationApi.getAuthToken();
  }

  static Future<List<Map<String, dynamic>>?> fetchFarmers() async {
          final token = await _getToken();



    try {
      final response = await http.get(Uri.parse('$baseUrl/agent/chatusers'),headers: <String, String>{
        'Content-Type': 'application/json',
        'Authorization': 'Bearer $token',
      },);
      if (response.statusCode == 200) {
        final Map<String, dynamic> data = jsonDecode(response.body);
        final List<dynamic> farmersData = data['data'];
        final List<Map<String, dynamic>> farmers = [];
        for (var farmerData in farmersData) {
          farmers.add(Map<String, dynamic>.from(farmerData));
        }
        return farmers;
      } else {
        throw Exception('Failed to fetch farmers: ${response.statusCode}');
      }
    } catch (e) {
      debugPrint('Error fetching farmers: $e');
      return null;
    }
  }

static Future<List<dynamic>> getRecordOfFarm(String farmId) async {
  try {
    final token = await _getToken(); 
    final response = await http.get(
      Uri.parse('$baseUrl/agent/reports/$farmId'),
      headers: <String, String>{
        'Authorization': 'Bearer $token',
      },
    );

    if (response.statusCode == 200) {
      final List<dynamic> farmReportsData = jsonDecode(response.body)['data'];
      return farmReportsData;
    } else {
      throw Exception('Failed to get farm reports: ${response.statusCode}');
    }
  } catch (e) {
    // Print the error message if an exception occurs
    debugPrint('Error fetching farm reports: $e');
    // Re-throw the exception to propagate it further
    rethrow;
  }
}



    static Future<List<Map<String, dynamic>>?> fetchFarms(String farmerId) async {
          final token = await _getToken();

    try {
      final response = await http.get(Uri.parse('$baseUrl/agent/farms/$farmerId'),headers: <String, String>{
        'Content-Type': 'application/json',
        'Authorization': 'Bearer $token',
      },);
      if (response.statusCode == 200) {
        final Map<String, dynamic> data = jsonDecode(response.body);
        final List<dynamic> farmersData = data['data'];
        final List<Map<String, dynamic>> farmers = [];
        for (var farmerData in farmersData) {
          farmers.add(Map<String, dynamic>.from(farmerData));
        }
        return farmers;
      } else {
        throw Exception('Failed to fetch farmers: ${response.statusCode}');
      }
    } catch (e) {
      debugPrint('Error fetching farmers: $e');
      return null;
    }
  }

  static Future<Map<String, dynamic>> createTransaction(
      double amount,
      String farmerId,
      String farmId,
      bool isAcknowledged,
      bool isComplete) async {

                  final token = await _getToken();

    final response = await http.post(
      Uri.parse('$baseUrl/agent/trade/create'),
      headers: <String, String>{
        'Content-Type': 'application/json',
        'Authorization': 'Bearer $token',
      },
      body: jsonEncode(<String, dynamic>{
        'amount': amount,
        'farmer': farmerId,
        'farm': farmId,
        'isAcknowledged': isAcknowledged,
        'isComplete': isComplete,
      }),
    );

    return jsonDecode(response.body);
  }


  static Future<Map<String, dynamic>> getTransaction( String farmId) async {
              final token = await _getToken();

    final response = await http.get(
      Uri.parse('$baseUrl/agent/trade/$farmId'),
      headers: <String, String>{
        'Authorization': 'Bearer $token',
      },
    );

    return jsonDecode(response.body);
  }
  

      static Future<Map<String, dynamic>> getFarmName( String id) async {
              final token = await _getToken();

    final response = await http.get(
      Uri.parse('$baseUrl/agent/getfarmname/$id'),
      headers: <String, String>{
        'Authorization': 'Bearer $token',
      },
    );

    return jsonDecode(response.body);
  }





  static Future<Map<String, dynamic>> acknowledgeReport( String reportId) async {

              final token = await _getToken();

    final response = await http.patch(
      Uri.parse('$baseUrl/agent/report/$reportId'),
      headers: <String, String>{
        'Content-Type': 'application/json',
        'Authorization': 'Bearer $token',
      },
      body: jsonEncode(<String, bool>{
        'isAcknowledged': true,
      }),
    );

    return jsonDecode(response.body);
  }

  static Future<Map<String, dynamic>> getTodaysReport( String farmerId) async {
              final token = await _getToken();

    final response = await http.get(
      Uri.parse('$baseUrl/agent/report/today/$farmerId'),
      headers: <String, String>{
        'Authorization': 'Bearer $token',
      },
    );

    return jsonDecode(response.body);
  }
  





static Future<ProfileAgent> getUserData() async {
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
      return ProfileAgent.fromJson(userData);
    } else {
      throw Exception('Failed to get user data: ${response.statusCode}');
    }
  } catch (e) {
    debugPrint('Error fetching user data: $e');
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
