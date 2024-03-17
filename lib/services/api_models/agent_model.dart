class Transaction {
  final String id;
  final double amount;
  final String agent;
  final String farmer;
  final String farm;
  final bool isAcknowledged;
  final bool isComplete;
  final DateTime createdAt;
  final DateTime updatedAt;

  Transaction({
    required this.id,
    required this.amount,
    required this.agent,
    required this.farmer,
    required this.farm,
    required this.isAcknowledged,
    required this.isComplete,
    required this.createdAt,
    required this.updatedAt,
  });

  factory Transaction.fromJson(Map<String, dynamic> json) {
    return Transaction(
      id: json['_id'],
      amount: json['amount'],
      agent: json['agent'],
      farmer: json['farmer'],
      farm: json['farm'],
      isAcknowledged: json['isAcknowledged'],
      isComplete: json['isComplete'],
      createdAt: DateTime.parse(json['createdAt']),
      updatedAt: DateTime.parse(json['updatedAt']),
    );
  }
}



class ProfileAgent {
  String id;
  String email;
  String role;
  String createdAt;
  String updatedAt;
  String area;
  String gender;
  String name;
  String phoneNumber;
  String state;

  ProfileAgent({
    required this.id,
    required this.email,
    required this.role,
    required this.createdAt,
    required this.updatedAt,
    required this.area,
    required this.gender,
    required this.name,
    required this.phoneNumber,
    required this.state,
  });

  factory ProfileAgent.fromJson(Map<String, dynamic> json) {
    return ProfileAgent(
      id: json['_id'] ?? '' ,
      email: json['email'] ?? '',
      role: json['role'] ?? '',
      createdAt: json['createdAt'] ?? '',
      updatedAt: json['updatedAt'] ?? '',
      area: json['area'] ?? '',
      gender: json['gender'] ?? '',
      name: json['name'] ?? '',
      phoneNumber: json['phoneNumber'].toString(),
      state: json['state'] ?? '',
    );
  }

}