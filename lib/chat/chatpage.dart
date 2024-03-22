import 'package:flutter/material.dart';
import 'package:cluck_connect/services/api/chat_api.dart';

class ChatRoomScreen extends StatefulWidget {
  const ChatRoomScreen({super.key, required this.chatRoomId});

  final String chatRoomId;

  @override
  // ignore: library_private_types_in_public_api
  _ChatRoomScreenState createState() => _ChatRoomScreenState();
}

class _ChatRoomScreenState extends State<ChatRoomScreen> {
  final TextEditingController _messageController = TextEditingController();
  final List<Message> _messages = [];

  @override
  void initState() {
    super.initState();
    fetchMessages(
        widget.chatRoomId); // Fetch messages when the screen is initialized
  }

  void sendMessage(String message) async {
    try {
      // Send message to the current chat room
      await ChatService.sendMessage(widget.chatRoomId, message);
      // After sending the message, fetch updated messages
      fetchMessages(widget.chatRoomId);
    } catch (e) {
      debugPrint("Error sending message: $e");
    }
  }

 Future<void> fetchMessages(String chatId) async {
  try {
    // Fetch all messages of the current chat room
    final fetchMessagesResponse = await ChatService.fetchChatMessages(chatId);

    // Check if the response is a Map<String, dynamic>
    // Extract the 'data' field from the response
    final List<dynamic> messageData = fetchMessagesResponse['data'];

    // Convert each message data into a Message object and add it to _messages list
    List<Message> messages = messageData.map((messageJson) => Message.fromJson(messageJson)).toList();

    // Sort the messages based on the 'created' field
    messages.sort((a, b) => DateTime.parse(a.created).compareTo(DateTime.parse(b.created)));

    setState(() {
      _messages.clear();
      _messages.addAll(messages);
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
                      return Align(
                        alignment: Alignment.centerRight,
                        child: Container(
                          margin: const EdgeInsets.all(8.0),
                          padding: const EdgeInsets.all(12.0),
                          decoration: BoxDecoration(
                            color: Colors.blue,
                            borderRadius: BorderRadius.circular(10.0),
                          ),
                          child: Text(
                            '${message.senderEmail}: ${message.content}',
                            style: const TextStyle(color: Colors.white),
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

  Message( {required this.senderEmail, required this.content, required this.created});

  factory Message.fromJson(Map<String, dynamic> json) {
    return Message(
        senderEmail: json['sender']['email'],
        content: json['content'],
        created: json['createdAt']);
  }
}
