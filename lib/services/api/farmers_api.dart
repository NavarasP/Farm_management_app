import 'dart:convert';
import 'constants.dart';
import 'package:flutter/material.dart';
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
      debugPrint('Error creating farm: $e');
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
        List<Farm> farms =
            farmsData.map((farmData) => Farm.fromJson(farmData)).toList();
        return farms;
      } else {
        throw Exception('Failed to load farms: ${response.statusCode}');
      }
    } catch (e) {
      debugPrint('Error loading farms: $e');
      throw Exception('Failed to load farms: $e');
    }
  }

static Future<List<dynamic>> getRecordOfFarm(String farmId) async {
  try {
    final token = await _getToken(); 
    final response = await http.get(
      Uri.parse('$baseUrl/farmer/reports/$farmId'),
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

  static Future<List<Transaction>> fetchTransactions() async {
    final token = await _getToken();

    try {
      final response = await http.get(
        Uri.parse('$baseUrl/farmer/transaction'),
        headers: {
          'Authorization': 'Bearer $token',
        },
      );
      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
        final List<dynamic> transactionData = data['data'];

        return transactionData
            .map((transactionJson) => Transaction.fromJson(transactionJson))
            .toList();
      } else {
        throw Exception('Failed to fetch transactions: ${response.statusCode}');
      }
    } catch (e) {
      debugPrint('Error fetching transactions: $e');
      rethrow;
    }
  }

  static Future<Map<String, dynamic>> createReport(String farmid, String jsonData, ) async {
    try {
      final token = await _getToken();

      final response = await http.post(
        Uri.parse('$baseUrl/farmer/report/$farmid'),
        headers: <String, String>{
          'Content-Type': 'application/json',
          'Authorization': 'Bearer $token',
        },
        body: jsonData
      );

      return jsonDecode(response.body);
    } catch (e) {
      debugPrint('Error creating farm: $e');
      throw Exception('Failed to create farm: $e');
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
      debugPrint('Error fetching user data: $e');
      throw Exception('Failed to get user data: $e');
    }
  }

  static Future<Map<String, dynamic>> updateUserData(
      Map<String, dynamic> userData) async {
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
