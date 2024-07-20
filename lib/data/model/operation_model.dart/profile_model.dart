// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

import 'package:flutter/foundation.dart';

class ProfileModelResponse {
  String id;
  String displayName;
  String username;
  List<dynamic> rules;
  bool active;
  int experienceYears;
  String address;
  String level;
  String createdAt;
  String updatedAt;
  ProfileModelResponse({
    required this.id,
    required this.displayName,
    required this.username,
    required this.rules,
    required this.active,
    required this.experienceYears,
    required this.address,
    required this.level,
    required this.createdAt,
    required this.updatedAt,
  });

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      '_id': id,
      'displayName': displayName,
      'username': username,
      'rules': rules,
      'active': active,
      'experienceYears': experienceYears,
      'address': address,
      'level': level,
      'createdAt': createdAt,
      'updatedAt': updatedAt,
    };
  }

  factory ProfileModelResponse.fromMap(Map<String, dynamic> map) {
    return ProfileModelResponse(
      id: map['_id'] as String,
      displayName: map['displayName'] as String,
      username: map['username'] as String,
      rules: List<String>.from((map['roles'] as List<dynamic>)),
      active: map['active'] as bool,
      experienceYears: map['experienceYears'] as int,
      address: map['address'] as String,
      level: map['level'] as String,
      createdAt: map['createdAt'] as String,
      updatedAt: map['updatedAt'] as String,
    );
  }

  @override
  String toString() {
    return 'ProfileModelResponse(_id: $id, displayName: $displayName, username: $username, rules: $rules, active: $active, experienceYears: $experienceYears, address: $address, level: $level, createdAt: $createdAt, updatedAt: $updatedAt)';
  }
}
