// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

class RegisterResponseModel {
  String id;
  String displayName;
  String access_token;
  String refresh_token;
  RegisterResponseModel({
    required this.id,
    required this.displayName,
    required this.access_token,
    required this.refresh_token,
  });

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      '_id': id,
      'displayName': displayName,
      'access_token': access_token,
      'refresh_token': refresh_token,
    };
  }

  factory RegisterResponseModel.fromMap(Map<String, dynamic> map) {
    return RegisterResponseModel(
      id: map['_id'] as String,
      displayName: map['displayName'] as String,
      access_token: map['access_token'] as String,
      refresh_token: map['refresh_token'] as String,
    );
  }

  @override
  String toString() {
    return 'RegisterResponseModel(_id: $id, displayName: $displayName, access_token: $access_token, refresh_token: $refresh_token)';
  }
}

class RegisterModel {
  String phone;
  String password;
  String display_name;
  String address;
  String level;
  int experienceYears;
  RegisterModel(
    this.phone,
    this.password,
    this.display_name,
    this.address,
    this.level,
    this.experienceYears,
  );

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'phone': phone,
      'password': password,
      'display_name': display_name,
      'address': address,
      'level': level,
      'experienceYears': experienceYears,
    };
  }

  factory RegisterModel.fromMap(Map<String, dynamic> map) {
    return RegisterModel(
      map['phone'] as String,
      map['password'] as String,
      map['display_name'] as String,
      map['address'] as String,
      map['level'] as String,
      map['experienceYears'] as int,
    );
  }

  @override
  String toString() {
    return 'RegisterModel(phone: $phone, password: $password, display_name: $display_name, address: $address, level: $level, experienceYears: $experienceYears)';
  }

  RegisterModel copyWith({
    String? phone,
    String? password,
    String? display_name,
    String? address,
    String? level,
    int? experienceYears,
  }) {
    return RegisterModel(
      phone ?? this.phone,
      password ?? this.password,
      display_name ?? this.display_name,
      address ?? this.address,
      level ?? this.level,
      experienceYears ?? this.experienceYears,
    );
  }

  factory RegisterModel.fromJson(String source) =>
      RegisterModel.fromMap(json.decode(source) as Map<String, dynamic>);
}


