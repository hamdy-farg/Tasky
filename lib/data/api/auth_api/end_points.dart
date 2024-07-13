import 'package:tasky/data/model/operation_model.dart/profile_model.dart';

class EndPoint {
  static String baseUrl = "https://todo.iraqsapp.com/";
  static String login = "auth/login";
  static String register = "auth/register";
  static String logout = "auth/logout";
  static String refresh = "auth/refresh-token";
  static String profile = "auth/profile";
  static String todos = "/todos";
}

class ApiKey {
  // custom
  static String counter = "counter";

  static String Authorization = "Authorization";
  static String statusCode = "statusCode";
  static String error = "error";
  static String message = "message";
  //
  static String id = "_id";
  static String displayName = "displayName";
  static String access_token = "access_token";
  static String refresh_token = "refresh_token";
  static String token = "token";
  //
  static String success = "success";
  //
  static String address = "address";
  static String experienceYears = "experienceYears";
  static String phone = "phone";
  static String password = "password";
  static String username = "username";
  static String roles = "roles";
  static String level = "level";
  static String createdAt = "createdAt";
  static String updatedAt = "updatedAt";
  static String v = "__v";
}

class modelKeys {
  static String id = "id";
  static String displayName = "displayName";
  static String username = "username";
  static String roles = "roles";
  static String active = "active";
  static String experienceYears = "experienceYears";
  static String address = "address";
  static String level = "level";
  static String createdAt = "createdAt";
  static String updatedAt = "updatedAt";
}
