// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

import 'package:tasky/constants/api_keys.dart';
import 'package:tasky/data/api/auth_api/end_points.dart';

class Model {}

class LoginResponseModel extends Model {
  String id;
  String access_token;
  String refresh_token;
  LoginResponseModel({
    required this.id,
    required this.access_token,
    required this.refresh_token,
  });

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      '_id': id,
      'access_token': access_token,
      'refresh_token': refresh_token,
    };
  }

  factory LoginResponseModel.fromMap(Map<String, dynamic> map) {
    return LoginResponseModel(
      id: map[ApiKey.id] as String,
      access_token: map[ApiKey.access_token] as String,
      refresh_token: map[ApiKey.refresh_token] as String,
    );
  }

  @override
  String toString() =>
      'LoginResponseModel(_id: $id, access_token: $access_token, refresh_token: $refresh_token)';
}

class LoginModel {
  String phone;
  String password;
  LoginModel({
    required this.phone,
    required this.password,
  });

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'phone': phone,
      'password': password,
    };
  }

  factory LoginModel.fromMap(Map<String, dynamic> map) {
    return LoginModel(
      phone: map['phone'] as String,
      password: map['password'] as String,
    );
  }

  @override
  String toString() => 'LoginModel(phone: $phone, password: $password)';
}

class LogoutModel {
  bool success;
  LogoutModel({
    required this.success,
  });

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'success': success,
    };
  }

  factory LogoutModel.fromMap(Map<String, dynamic> map) {
    return LogoutModel(
      success: map['success'] as bool,
    );
  }

  @override
  String toString() => 'LogoutModel(success: $success)';
}
