import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:cluck_connect/models/agent_model.dart';
import 'package:cluck_connect/models/farmer_model.dart';


class FarmApi {
  static const String baseUrl = 'http://your-api-base-url.com/api/v1/farmer';

  static Future<Map<String, dynamic>> createFarm(String token, String area) async {
    final response = await http.post(
      Uri.parse('$baseUrl/farm/create'),
      headers: <String, String>{
        'Content-Type': 'application/json',
        'Authorization': 'Bearer $token',
      },
      body: jsonEncode(<String, String>{
        'area': area,
      }),
    );

    return jsonDecode(response.body);
  }

  static Future<Map<String, dynamic>> createRecord(
      String token,
      String importDate,
      String exportDate,
      int totalChicks,
      int removedChick,
      String foodStock,
      String medicineOne,
      String medicineTwo) async {
    final response = await http.post(
      Uri.parse('$baseUrl/farm/create'),
      headers: <String, String>{
        'Content-Type': 'application/json',
        'Authorization': 'Bearer $token',
      },
      body: jsonEncode(<String, dynamic>{
        'importDate': importDate,
        'exportDate': exportDate,
        'totalChicks': totalChicks,
        'removedChick': removedChick,
        'foodStock': foodStock,
        'medicineOne': medicineOne,
        'medicineTwo': medicineTwo,
      }),
    );

    return jsonDecode(response.body);
  }

  static Future<List<FarmReport>> getRecordOfFarm(String token, String farmId) async {
    final response = await http.get(
      Uri.parse('$baseUrl/reports/$farmId'),
      headers: <String, String>{
        'Authorization': 'Bearer $token',
      },
    );

    final List<dynamic> farmReportsData = jsonDecode(response.body)['data'];
    return farmReportsData.map((reportData) => FarmReport.fromJson(reportData)).toList();
  }

  static Future<List<Farm>> getListOfFarms(String token) async {
    final response = await http.get(
      Uri.parse('$baseUrl/farms'),
      headers: <String, String>{
        'Authorization': 'Bearer $token',
      },
    );

    final List<dynamic> farmsData = jsonDecode(response.body)['data'];
    return farmsData.map((farmData) => Farm.fromJson(farmData)).toList();
  }

  static Future<List<Transaction>> getListOfTransactions(String token) async {
    final response = await http.get(
      Uri.parse('$baseUrl/transaction'),
      headers: <String, String>{
        'Authorization': 'Bearer $token',
      },
    );

    final List<dynamic> transactionsData = jsonDecode(response.body)['data'];
    return transactionsData.map((transactionData) => Transaction.fromJson(transactionData)).toList();
  }

  static Future<Map<String, dynamic>> updateFarmData(String token, String farmId, String area) async {
    final response = await http.patch(
      Uri.parse('$baseUrl/farm/$farmId'),
      headers: <String, String>{
        'Content-Type': 'application/json',
        'Authorization': 'Bearer $token',
      },
      body: jsonEncode(<String, String>{
        'area': area,
      }),
    );

    return jsonDecode(response.body);
  }
}
