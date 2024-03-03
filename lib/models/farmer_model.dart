import 'package:cluck_connect/models/authentication_model.dart';


class Farm {
  final String id;
  final String area;
  final String farmer;
  final DateTime createdAt;
  final DateTime updatedAt;

  Farm({
    required this.id,
    required this.area,
    required this.farmer,
    required this.createdAt,
    required this.updatedAt,
  });

  factory Farm.fromJson(Map<String, dynamic> json) {
    return Farm(
      id: json['_id'],
      area: json['area'],
      farmer: json['farmer'],
      createdAt: DateTime.parse(json['createdAt']),
      updatedAt: DateTime.parse(json['updatedAt']),
    );
  }
}

class FarmReport {
  final String id;
  final DateTime importDate;
  final DateTime exportDate;
  final int totalChicks;
  final int removedChick;
  final String foodStock;
  final String medicineOne;
  final String medicineTwo;
  final bool isAcknowledged;
  final Farm farm;
  final User farmer;
  final DateTime createdAt;
  final DateTime updatedAt;

  FarmReport({
    required this.id,
    required this.importDate,
    required this.exportDate,
    required this.totalChicks,
    required this.removedChick,
    required this.foodStock,
    required this.medicineOne,
    required this.medicineTwo,
    required this.isAcknowledged,
    required this.farm,
    required this.farmer,
    required this.createdAt,
    required this.updatedAt,
  });

  factory FarmReport.fromJson(Map<String, dynamic> json) {
    return FarmReport(
      id: json['_id'],
      importDate: DateTime.parse(json['importDate']),
      exportDate: DateTime.parse(json['exportDate']),
      totalChicks: json['totalChicks'],
      removedChick: json['removedChick'],
      foodStock: json['foodStock'],
      medicineOne: json['medicineOne'],
      medicineTwo: json['medicineTwo'],
      isAcknowledged: json['isAcknowledged'],
      farm: Farm.fromJson(json['farm']),
      farmer: User.fromJson(json['farmer']),
      createdAt: DateTime.parse(json['createdAt']),
      updatedAt: DateTime.parse(json['updatedAt']),
    );
  }
}
