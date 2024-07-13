// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

class ErrorModel {
  String message;
  int statusCode;
  String? error;
  ErrorModel({
    required this.message,
    required this.statusCode,
    this.error,
  });

  

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'message': message,
      'statusCode': statusCode,
      'error': error,
    };
  }

  factory ErrorModel.fromMap(Map<String, dynamic> map) {
    return ErrorModel(
      message: map['message'] as String,
      statusCode: map['statusCode'] as int,
      error: map['error'] != null ? map['error'] as String : null,
    );
  }

  @override
  String toString() =>
      'ErrorModel(message: $message, statusCode: $statusCode, error: $error)';
}
