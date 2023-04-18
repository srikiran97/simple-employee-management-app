import 'dart:convert';

import 'package:equatable/equatable.dart';
import 'package:uuid/uuid.dart';

Uuid uuid = const Uuid();

class Employee extends Equatable {
  final String id;
  final String employeeName;
  final String role;
  final String startDate;
  final String? endDate;
  Employee({
    String? id,
    required this.employeeName,
    required this.role,
    required this.startDate,
    this.endDate,
  }) : id = id ?? uuid.v4();

  @override
  List<Object?> get props => [
        id,
        employeeName,
        role,
        startDate,
        endDate,
      ];

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'employeeName': employeeName,
      'role': role,
      'startDate': startDate,
      'endDate': endDate,
    };
  }

  factory Employee.fromMap(Map<String, dynamic> map) {
    return Employee(
      id: map['id'] as String,
      employeeName: map['employeeName'] as String,
      role: map['role'] as String,
      startDate: map['startDate'] as String,
      endDate: map['endDate'] != null ? map['endDate'] as String : null,
    );
  }

  String toJson() => json.encode(toMap());

  factory Employee.fromJson(String source) =>
      Employee.fromMap(json.decode(source) as Map<String, dynamic>);
}
