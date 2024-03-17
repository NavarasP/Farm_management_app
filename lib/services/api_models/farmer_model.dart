import 'package:cluck_connect/services/api_models/authentication_model.dart';

class Farm {
  final String id;
  final String area;

  Farm({
    required this.id,
    required this.area,
  });

  factory Farm.fromJson(Map<String, dynamic> json) {
    return Farm(
      id: json['_id'],
      area: json['area'],
    );
  }
}


// class FarmReport {
//   final String id;
//   final DateTime importDate;
//   final DateTime exportDate;
//   final int totalChicks;
//   final int removedChick;
//   final String foodStock;
//   final String medicineOne;
//   final String medicineTwo;
//   final bool isAcknowledged;
//   final DateTime createdAt;
//   final DateTime updatedAt;

//   FarmReport({
//     required this.id,
//     required this.importDate,
//     required this.exportDate,
//     required this.totalChicks,
//     required this.removedChick,
//     required this.foodStock,
//     required this.medicineOne,
//     required this.medicineTwo,
//     required this.isAcknowledged,
//     required this.createdAt,
//     required this.updatedAt,
//   });

//   factory FarmReport.fromJson(Map<String, dynamic> json) {
//     return FarmReport(
//       id: json['_id'],
//       importDate: DateTime.parse(json['importDate']),
//       exportDate: DateTime.parse(json['exportDate']),
//       totalChicks: json['totalChicks'],
//       removedChick: json['removedChick'],
//       foodStock: json['foodStock'] ?? '',
//       medicineOne: json['medicineOne'] ?? '',
//       medicineTwo: json['medicineTwo'] ?? '',
//       isAcknowledged: json['isAcknowledged'],
//       createdAt: DateTime.parse(json['createdAt']),
//       updatedAt: DateTime.parse(json['updatedAt']),
//     );
//   }

// }


class Profile {
  String id;
  String email;
  String role;
  Agent agent;
  String createdAt;
  String updatedAt;
  String area;
  String gender;
  String name;
  int phoneNumber;
  String state;

  Profile({
    required this.id,
    required this.email,
    required this.role,
    required this.agent,
    required this.createdAt,
    required this.updatedAt,
    required this.area,
    required this.gender,
    required this.name,
    required this.phoneNumber,
    required this.state,
  });

  factory Profile.fromJson(Map<String, dynamic> json) {
    return Profile(
      id: json['_id'] ?? '' ,
      email: json['email'] ?? '',
      role: json['role'] ?? '',
      agent: Agent.fromJson(json['agent']) ,
      createdAt: json['createdAt'] ?? '',
      updatedAt: json['updatedAt'] ?? '',
      area: json['area'] ?? '',
      gender: json['gender'] ?? '',
      name: json['name'] ?? '',
      phoneNumber: json['phoneNumber'] ?? '',
      state: json['state'] ?? '',
    );
  }

}


class Agent {
  final String id;
  final String email;
  final String role;
  final String createdAt;
  final String updatedAt;
  final int? v; // Nullable integer

  Agent({
    required this.id,
    required this.email,
    required this.role,
    required this.createdAt,
    required this.updatedAt,
    this.v, // Nullable integer
  });

  factory Agent.fromJson(Map<String, dynamic> json) {
    return Agent(
      id: json['_id'] ,
      email: json['email'] ,
      role: json['role'] ,
      createdAt: json['createdAt'],
      updatedAt: json['updatedAt'] ,
      v: json['__v'], // Nullable integer
    );
  }
}


class Transaction {
  final String id;
  final double amount;
  final String farmArea;
  final bool isAcknowledged;
  final bool isCompleted;
  final String createdAt;
  final String updatedAt;

  Transaction({
    required this.id,
    required this.amount,
    required this.farmArea,
    required this.isAcknowledged,
    required this.isCompleted,
    required this.createdAt,
    required this.updatedAt,
  });

  factory Transaction.fromJson(Map<String, dynamic> json) {
    return Transaction(
      id: json['_id'],
      amount: json['amount'].toDouble(),
      farmArea: json['farm']['area'],
      isAcknowledged: json['isAcknowledged'],
      isCompleted: json['isComplete'],
      createdAt: json['createdAt'],
      updatedAt: json['updatedAt'],
    );
  }
}
