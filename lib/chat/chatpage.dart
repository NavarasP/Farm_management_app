import 'package:flutter/material.dart';
import 'package:cluck_connect/services/api/chat_api.dart';
import 'package:cluck_connect/services/api/authentication_api.dart';

class ChatRoomScreen extends StatefulWidget {
  const ChatRoomScreen({Key? key, required this.chatRoomId}) : super(key: key);

  final String chatRoomId;

  @override
  _ChatRoomScreenState createState() => _ChatRoomScreenState();
}

class _ChatRoomScreenState extends State<ChatRoomScreen> {
  final TextEditingController _messageController = TextEditingController();
  List<Message> _messages = [];
  late String? myEmail;

  @override
  void initState() {
    super.initState();
    initializeEmail();
    fetchMessages(widget.chatRoomId);
  }

  Future<void> initializeEmail() async {
    myEmail = await AuthenticationApi.getuserName();
  }

  void sendMessage(String message) async {
    try {
      await ChatService.sendMessage(widget.chatRoomId, message);
      fetchMessages(widget.chatRoomId);
    } catch (e) {
      debugPrint("Error sending message: $e");
    }
  }

  Future<void> fetchMessages(String chatId) async {
    try {
      final fetchMessagesResponse =
          await ChatService.fetchChatMessages(chatId);
      final List<dynamic> messageData = fetchMessagesResponse['data'];
      List<Message> messages = messageData
          .map((messageJson) => Message.fromJson(messageJson))
          .toList();
      messages.sort((a, b) =>
          DateTime.parse(a.created).compareTo(DateTime.parse(b.created)));

      setState(() {
        _messages = messages;
      });
    } catch (e) {
      debugPrint("Error fetching messages: $e");
    }
  }

  void _sendMessage() {
    String messageText = _messageController.text.trim();
    if (messageText.isNotEmpty) {
      sendMessage(messageText);
      _messageController.clear();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 231, 237, 241),
      appBar: AppBar(
        title: const Text('Chat Room'),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
      ),
      body: Column(
        children: [
          Expanded(
            child: _messages.isEmpty
                ? const Center(
                    child: Text(
                      'No messages available',
                      style: TextStyle(fontSize: 16),
                    ),
                  )
                : ListView.builder(
  itemCount: _messages.length,
  itemBuilder: (context, index) {
    var message = _messages[index];
    final isMyMessage =
        message.senderEmail == myEmail; // Awaited value
    return Align(
      alignment: isMyMessage
          ? Alignment.centerRight
          : Alignment.centerLeft,
      child: Container(
        margin: const EdgeInsets.symmetric(vertical: 4.0),
        padding: const EdgeInsets.symmetric(horizontal: 12.0, vertical: 8.0),
        decoration: BoxDecoration(
          color: isMyMessage ? Colors.blue : Colors.grey[300],
          borderRadius: BorderRadius.only(
            topLeft: isMyMessage ? Radius.circular(12.0) : Radius.circular(0),
            topRight: isMyMessage ? Radius.circular(0) : Radius.circular(12.0),
            bottomLeft: Radius.circular(12.0),
            bottomRight: Radius.circular(12.0),
          ),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              isMyMessage ? 'You' : message.senderEmail,
              style: TextStyle(
                color: isMyMessage ? Colors.white : Colors.black,
                fontWeight: FontWeight.bold,
                fontSize: 14.0, // Smaller font size for sender's name
              ),
            ),
            SizedBox(height: 4.0), // Add some spacing between name and message
            Text(
              message.content,
              style: TextStyle(
                color: isMyMessage ? Colors.white : Colors.black,
                fontSize: 16.0, // Regular font size for message content
              ),
            ),
          ],
        ),
      ),
    );
  },
),



          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              children: [
                Expanded(
                  child: Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(20.0),
                      border: Border.all(color: Colors.blue),
                    ),
                    child: Row(
                      children: [
                        Expanded(
                          child: TextField(
                            controller: _messageController,
                            decoration: const InputDecoration(
                              hintText: 'Type your message...',
                              border: InputBorder.none,
                              contentPadding: EdgeInsets.all(10.0),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                IconButton(
                  icon: const Icon(Icons.send, color: Colors.blue),
                  onPressed: _sendMessage,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class Message {
  final String senderEmail;
  final String content;
  final String created;

  Message(
      {required this.senderEmail,
      required this.content,
      required this.created});

  factory Message.fromJson(Map<String, dynamic> json) {
    return Message(
        senderEmail: json['sender']['email'],
        content: json['content'],
        created: json['createdAt']);
  }
}
