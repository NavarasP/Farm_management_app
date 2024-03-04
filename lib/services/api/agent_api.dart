import 'dart:convert';
import 'package:http/http.dart' as http;

class AgentApi {
  static const String baseUrl = 'http://127.0.0.1:8000';

  static Future<Map<String, dynamic>> createTransaction(
      String token,
      double amount,
      String farmerId,
      String farmId,
      bool isAcknowledged,
      bool isComplete) async {
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

  static Future<Map<String, dynamic>> acknowledgeReport(String token, String reportId) async {
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

  static Future<Map<String, dynamic>> getTodaysReport(String token, String farmerId) async {
    final response = await http.get(
      Uri.parse('$baseUrl/report/today/$farmerId'),
      headers: <String, String>{
        'Authorization': 'Bearer $token',
      },
    );

    return jsonDecode(response.body);
  }
}
