import 'dart:convert';
import 'constants.dart';
import 'package:http/http.dart' as http;
import 'package:cluck_connect/services/api_models/chat_model.dart';
import 'package:cluck_connect/services/api/authentication_api.dart';

class ChatService {
  static Future<String?> _getToken() {
    return AuthenticationApi.getAuthToken();
  }

  static Future<ChatRoom?> accessOrCreateChat(String userIdToChat) async {
    try {
      final token = await _getToken();
      final response = await http.post(
        Uri.parse('$baseUrl/chat/$userIdToChat'),
        headers: <String, String>{
          'Authorization': 'Bearer $token',
        },
      );

      if (response.statusCode == 200) {
        Map<String, dynamic> data = jsonDecode(response.body);
        return ChatRoom.fromJson(data['data']);
      } else {
        throw Exception('Failed to access or create chat');
      }
    } catch (e) {
      print('Error accessing or creating chat: $e');
      return null;
    }
  }

  static Future<List<ChatRoom>> fetchChats() async {
    try {
      final token = await _getToken();
      final response = await http.get(
        Uri.parse('$baseUrl/chat'),
        headers: <String, String>{
          'Authorization': 'Bearer $token',
        },
      );

      if (response.statusCode == 200) {
        List<dynamic> data = jsonDecode(response.body)['data'];
        return data.map((chatData) => ChatRoom.fromJson(chatData)).toList();
      } else {
        throw Exception('Failed to fetch chats');
      }
    } catch (e) {
      print('Error fetching chats: $e');
      return [];
    }
  }

  static Future<ChatMessage?> sendMessage(String chatId, String content) async {
    try {
      final token = await _getToken();
      final response = await http.post(
        Uri.parse('$baseUrl/chat/message/add/$chatId'),
        headers: <String, String>{
          'Content-Type': 'application/json',
          'Authorization': 'Bearer $token',
        },
        body: jsonEncode(<String, String>{
          'content': content,
        }),
      );

      if (response.statusCode == 200 || response.statusCode == 201) {
        print('${response.statusCode}');
        
      } else {
        // Only print errors for non-200 and non-201 status codes
        print('Error sending message: ${response.statusCode}');
        return null;
      }
    } catch (e) {
      // Print any other caught errors
      print('Error sending message: $e');
      return null;
    }
  }


 static Future<Map<String, dynamic>> fetchChatMessages(String chatId) async {
    try {
      final token = await _getToken();
      final response = await http.get(
        Uri.parse('$baseUrl/chat/message/$chatId'),
        headers: <String, String>{
          'Authorization': 'Bearer $token',
        },
      );

      if (response.statusCode == 200) {
        return jsonDecode(response.body);
      } else {
        throw Exception('Failed to fetch chat messages: ${response.statusCode}');
      }
    } catch (e) {
      print('Error fetching chat messages: $e');
      return {}; // Return an empty map in case of error
    }
  }



  
  }

