// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:collection';

import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:tasky/cache/cache_helper.dart';
import 'package:tasky/constants/api_keys.dart';
import 'package:tasky/constants/db_handler_strings.dart';
import 'package:tasky/data/api/auth_api/api_consumer.dart';
import 'package:tasky/data/api/auth_api/end_points.dart';
import 'package:tasky/data/model/auth_model/login_model.dart';
import 'package:tasky/data/model/auth_model/refresh_token_and_get_profile.dart';
import 'package:tasky/data/model/auth_model/register_model.dart';
import 'package:tasky/data/model/operation_model.dart/profile_model.dart';
import 'package:tasky/data/repo/error/exceptions.dart';
// ignore: depend_on_referenced_packages
import 'package:dartz/dartz.dart';

class AuthRepo {
  final ApiConsumer api;
  AuthRepo({
    required this.api,
  });

  static String? refresh_token;
  Future<String?> check() async {
    await CacheHelper().init();

    refresh_token = await CacheHelper().getData(key: ApiKey.refresh_token);
    print("$refresh_token --)))_)))__");
  }

  Future<Either<String, dynamic>> register(
      {required RegisterModel register_model}) async {
    // to send the request with user data
    try {
      final reponse =
          await api.post(EndPoint.register, "", isFormData: false, data: {
        ApiKey.phone: register_model.phone,
        ApiKey.password: register_model.password,
        ApiKey.displayName: register_model.display_name,
        ApiKey.experienceYears: register_model.experienceYears,
        ApiKey.address: register_model.address,
        ApiKey.level: register_model.level,
      });

      final register_response = RegisterResponseModel.fromMap(reponse);
      // save token and refresh token in the cach helper
      CacheHelper().saveData(
          key: ApiKey.access_token, value: register_response.access_token);
      CacheHelper().saveData(
          key: ApiKey.refresh_token, value: register_response.refresh_token);
      CacheHelper().saveData(key: ApiKey.id, value: register_response.id);
      // register response
      print(register_response);
      return Right(register_response);
    } on ServerException catch (e) {
      print(e.errorModel.message);

      return Left(e.errorModel.message);
    }
  }

  Future<Either<String, dynamic>> login(
      {required LoginModel login_model}) async {
    try {
      final response =
          await api.post(EndPoint.login, " ", isFormData: false, data: {
        ApiKey.phone: login_model.phone,
        ApiKey.password: login_model.password,
      });
      final login_response = LoginResponseModel.fromMap(response);
      // save token and refresh token in the cach helper
      CacheHelper().saveData(
          key: ApiKey.access_token, value: login_response.access_token);
      CacheHelper().saveData(
          key: ApiKey.refresh_token, value: login_response.refresh_token);
      CacheHelper().saveData(key: ApiKey.id, value: login_response.id);
      return right(login_response);
    } on ServerException catch (e) {
      return left(e.errorModel.message);
      // TODO
    }
  }

  Future<Either<String, dynamic>> logout() async {
    try {
      final response = await api!.post(EndPoint.logout);

      final logout_response = LogoutModel.fromMap(response);
      // clear all data in cash
      CacheHelper().clearData(key: ApiKey.access_token);
      CacheHelper().clearData(key: ApiKey.refresh_token);
      CacheHelper().clearData(key: ApiKey.id);

      return right(logout_response);
    } on ServerException catch (e) {
      if (e.errorModel.message == "Unauthorized") {
        checkIfAutherized(api: api, func: AuthRepo().logout());
      }
      return left(e.errorModel.message);
      // TODO
    }
  }
}

checkIfAutherized({
  required ApiConsumer? api,
  required Future<Either<String, dynamic>> func,
}) async {
  try {
    final response = await api!.get(EndPoint.refresh, queryParameters: {
      ApiKey.token: CacheHelper().getData(key: ApiKey.refresh_token) != null
          ? CacheHelper().getData(key: ApiKey.refresh_token)
          : AuthRepo.refresh_token,
    });
    RefreshTokenResponse refresh_token_response =
        RefreshTokenResponse.fromMap(response);
    CacheHelper().saveData(
      key: ApiKey.access_token,
      value: refresh_token_response.access_token,
    );
    func;
  } on Exception catch (e) {
    return left(e.toString());
    // TODO
  }
}
