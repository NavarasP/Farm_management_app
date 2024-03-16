class ChatRoom {
  final String id;
  final String chatName;
  final List<User> users;
  final DateTime createdAt;
  final DateTime updatedAt;
  final int v;

  ChatRoom({
    required this.id,
    required this.chatName,
    required this.users,
    required this.createdAt,
    required this.updatedAt,
    required this.v,
  });

  factory ChatRoom.fromJson(Map<String, dynamic> json) {
    return ChatRoom(
      id: json['_id'],
      chatName: json['chatName'],
      users: List<User>.from(json['users'].map((user) => User.fromJson(user))),
      createdAt: DateTime.parse(json['createdAt']),
      updatedAt: DateTime.parse(json['updatedAt']),
      v: json['__v'],
    );
  }
}

class ChatMessage {
  final String id;
  final User sender;
  final String content;
  final ChatRoom chat;
  final List<User> readBy;
  final DateTime createdAt;
  final DateTime updatedAt;
  final int v;

  ChatMessage({
    required this.id,
    required this.sender,
    required this.content,
    required this.chat,
    required this.readBy,
    required this.createdAt,
    required this.updatedAt,
    required this.v,
  });

  factory ChatMessage.fromJson(Map<String, dynamic> json) {
    return ChatMessage(
      id: json['_id'],
      sender: User.fromJson(json['sender']),
      content: json['content'],
      chat: ChatRoom.fromJson(json['chat']),
      readBy: List<User>.from(json['readBy'].map((user) => User.fromJson(user))),
      createdAt: DateTime.parse(json['createdAt']),
      updatedAt: DateTime.parse(json['updatedAt']),
      v: json['__v'],
    );
  }
}

class User {
  final String id;
  final String email;
  final String role;
  final DateTime createdAt;
  final DateTime updatedAt;
  final int v;

  User({
    required this.id,
    required this.email,
    required this.role,
    required this.createdAt,
    required this.updatedAt,
    required this.v,
  });

  factory User.fromJson(Map<String, dynamic> json) {
    return User(
      id: json['_id'],
      email: json['email'],
      role: json['role'],
      createdAt: DateTime.parse(json['createdAt']),
      updatedAt: DateTime.parse(json['updatedAt']),
      v: json['__v'],
    );
  }
}
