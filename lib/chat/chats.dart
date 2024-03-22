import 'package:flutter/material.dart';
import 'package:cluck_connect/chat/chatpage.dart';
import 'package:cluck_connect/chat/farmerlist.dart';
import 'package:cluck_connect/services/api/chat_api.dart';
import 'package:cluck_connect/services/api_models/chat_model.dart';
import 'package:cluck_connect/services/api/authentication_api.dart';



class ChatUsersPage extends StatefulWidget {
  const ChatUsersPage({super.key});

  @override
  // ignore: library_private_types_in_public_api
  _ChatUsersPageState createState() => _ChatUsersPageState();
}

class _ChatUsersPageState extends State<ChatUsersPage> {
  List<ChatRoom> _chatRooms = [];
  final bool _showNewChatButton = true;

  @override
  void initState() {
    super.initState();
    _fetchChatRooms();
  }

void _fetchChatRooms() async {
  try {
    List<ChatRoom> chatRooms = await ChatService.fetchChats();
    final isFarmer = await _isFarmer();
    setState(() {
      _chatRooms = chatRooms;
      // Check if the user is a farmer and chat list is not empty
      _showNewChatButton != isFarmer && _chatRooms.isNotEmpty;
    });
  } catch (e) {
    debugPrint("Error fetching chat rooms: $e");
  }
}


Future<bool> _isFarmer() async {
  try {
    final userDetails = await AuthenticationApi.getUserDetails();
    final role = userDetails['role'];
    return role == 'farmer';
  } catch (e) {
    debugPrint("Error getting user details: $e");
    return false; // Default to false if there's an error
  }
}



  void _navigateToChatRoom(String chatRoomId) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => ChatRoomScreen(chatRoomId: chatRoomId),
      ),
    );
  }

void _createNewChat() async {
  try {
    final isFarmer = await _isFarmer();
    if (isFarmer) {
      final agentId = await AuthenticationApi.getAgentId();
      if (agentId != null) {
        await ChatService.accessOrCreateChat(agentId);
        // Navigate to the screen for the new chat room
        // ignore: use_build_context_synchronously
        Navigator.push(context, MaterialPageRoute(builder: (context) => const ChatUsersPage()));
      } else {
        debugPrint("Agent ID not found for the farmer");
      }
    } else {
      // If the user is not a farmer, navigate to a new page to display the list of farmers
      // ignore: use_build_context_synchronously
      Navigator.push(context, MaterialPageRoute(builder: (context) => const FarmerListPage()));
    }
  } catch (e) {
    debugPrint("Error creating new chat: $e");
  }
}



  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Chat Users'),
      ),
      body: ListView.builder(
        itemCount: _chatRooms.length,
        itemBuilder: (context, index) {
          final chatRoom = _chatRooms[index];
          final chatUsers =
              chatRoom.users.map((user) => user.email).join(', '); // Join user emails
          return ListTile(
            title: Text(chatUsers),
            onTap: () => _navigateToChatRoom(chatRoom.id),
          );
        },
      ),
      floatingActionButton: Visibility(
        visible: _showNewChatButton,
        child: FloatingActionButton(
          onPressed: _createNewChat,
          tooltip: 'Create New Chat',
          child: const Icon(Icons.add),
        ),
      ),
    );
  }
}
