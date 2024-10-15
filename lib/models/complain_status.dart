// lib/models/ComplainStatusModel.dart
// import 'dart:convert';

class ComplainStatusModel {
  final String id;
  final String title;
  final String status;

  ComplainStatusModel({
    required this.id,
    required this.title,
    required this.status,
  });

  factory ComplainStatusModel.fromJson(Map<String, dynamic> json) {
    return ComplainStatusModel(
      id: json['id'] as String,
      title: json['title'] as String,
      status: json['status'] as String,
    );
  }

  Map<String, dynamic> toJson() => {
        'id': id,
        'title': title,
        'status': status,
      };
}
