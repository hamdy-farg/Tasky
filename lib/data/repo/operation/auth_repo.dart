// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:collection';
import 'dart:developer';

import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tasky/bussiness_logic/get_user_bloc/get_user_bloc.dart';
import 'package:tasky/bussiness_logic/get_user_bloc/get_user_event.dart';
import 'package:tasky/cache/cache_helper.dart';
import 'package:tasky/constants/api_keys.dart';
import 'package:tasky/data/api/auth_api/api_consumer.dart';
import 'package:tasky/data/api/auth_api/dio_consumer.dart';
import 'package:tasky/data/api/auth_api/end_points.dart';
import 'package:tasky/data/api/db/db_handler.dart';
import 'package:tasky/data/model/auth_model/login_model.dart';
import 'package:tasky/data/model/auth_model/refresh_token_and_get_profile.dart';
import 'package:tasky/data/model/auth_model/register_model.dart';
import 'package:tasky/data/model/error_model.dart';
import 'package:tasky/data/model/get_user_model.dart';
import 'package:tasky/data/model/operation_model.dart/profile_model.dart';
import 'package:tasky/data/repo/error/exceptions.dart';
// ignore: depend_on_referenced_packages
import 'package:dartz/dartz.dart';
import 'package:tasky/data/repo/operation/get_repo.dart';

class AuthRepo {
  final ApiConsumer? api;
  AuthRepo({
    this.api,
  });

  static String? refresh_token;
  static GetUserModel getUser_model = GetUserModel();

  Future<String?> check() async {
    await CacheHelper().init();

    refresh_token = await CacheHelper().getData(key: ApiKey.refresh_token);
    print("$refresh_token --)))_)))__");
    return null;
  }

  Future<Either<String, dynamic>> register(
      {required RegisterModel register_model}) async {
    // to send the request with user data
    try {
      final reponse =
          await api!.post(EndPoint.register, isFormData: false, data: {
        ApiKey.phone: register_model.phone,
        ApiKey.password: register_model.password,
        ApiKey.displayName: register_model.display_name,
        ApiKey.experienceYears: register_model.experienceYears,
        ApiKey.address: register_model.address,
        ApiKey.level: register_model.level,
      });

      final registerResponse = RegisterResponseModel.fromMap(reponse);
      // save token and refresh token in the cach helper
      CacheHelper().saveData(
          key: ApiKey.access_token, value: registerResponse.access_token);
      CacheHelper().saveData(
          key: ApiKey.refresh_token, value: registerResponse.refresh_token);
      CacheHelper().saveData(key: ApiKey.id, value: registerResponse.id);
      // register response
      return Right(registerResponse);
    } on ServerException catch (e) {
      return Left(e.errorModel.message);
    }
  }

  Future<Either<String, dynamic>> login(
      {required LoginModel login_model}) async {
    try {
      log("$api ss");
      final response =
          await api!.post(EndPoint.login, isFormData: false, data: {
        ApiKey.phone: login_model.phone,
        ApiKey.password: login_model.password,
      });

      log("tttt");
      LoginResponseModel loginResponse = LoginResponseModel.fromMap(response);
      // save token and refresh token in the cach helper

      //

      log('start6');

      log('start2');

      log('start3');

      //
      return right(loginResponse);
    } on ServerException catch (e) {
    
      return left(e.errorModel.message);
      // TODO
    }
  }

  Future<Either<String, dynamic>> logout() async {
    try {
      final response = await api!.post(EndPoint.logout);

      final logoutResponse = LogoutModel.fromMap(response);
      // clear all data in cash
      CacheHelper().clearData(key: ApiKey.access_token);
      CacheHelper().clearData(key: ApiKey.refresh_token);
      CacheHelper().clearData(key: ApiKey.id);

      return right(logoutResponse);
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
      ApiKey.token: CacheHelper().getData(key: ApiKey.refresh_token) ??
          AuthRepo.refresh_token,
    });
    RefreshTokenResponse refreshTokenResponse =
        RefreshTokenResponse.fromMap(response);
    CacheHelper().saveData(
      key: ApiKey.access_token,
      value: refreshTokenResponse.access_token,
    );
    func;
  } on Exception catch (e) {
    return left(e.toString());
    // TODO
  }
}
//! save login data in chash memory
  // CacheHelper().saveData(
      //     key: ApiKey.access_token, value: loginResponse.access_token);
      // CacheHelper().saveData(
      //     key: ApiKey.refresh_token, value: loginResponse.refresh_token);
      // CacheHelper().saveData(key: ApiKey.id, value: loginResponse.id);