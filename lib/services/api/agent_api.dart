import 'dart:convert';
import 'constants.dart';
import 'constants.dart';
import 'package:http/http.dart' as http;
import 'package:cluck_connect/services/api/authentication_api.dart';

class AgentApi {
    static Future<String?> _getToken() {
    return AuthenticationApi.getAuthToken();
  }

  static Future<List<Map<String, dynamic>>?> fetchFarmers() async {
          final token = await _getToken();



    try {
      final response = await http.get(Uri.parse('/agent/chatusers'),headers: <String, String>{
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
      print('Error fetching farmers: $e');
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
      Uri.parse('$baseUrl/trade/create'),
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

  static Future<Map<String, dynamic>> acknowledgeReport( String reportId) async {

              final token = await _getToken();

    final response = await http.patch(
      Uri.parse('$baseUrl/report/$reportId'),
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
      Uri.parse('$baseUrl/report/today/$farmerId'),
      headers: <String, String>{
        'Authorization': 'Bearer $token',
      },
    );

    return jsonDecode(response.body);
  }
}
