// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

class RefreshTokenResponse {
  String access_token;
  RefreshTokenResponse({
    required this.access_token,
  });

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'access_token': access_token,
    };
  }

  factory RefreshTokenResponse.fromMap(Map<String, dynamic> map) {
    return RefreshTokenResponse(
      access_token: map['access_token'] as String,
    );
  }
}
