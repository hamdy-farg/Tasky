// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:collection';
import 'dart:developer';

import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:sqflite/sqflite.dart';
import 'package:tasky/cache/cache_helper.dart';
import 'package:tasky/constants/api_keys.dart';
import 'package:tasky/data/api/auth_api/api_consumer.dart';
import 'package:tasky/data/api/auth_api/end_points.dart';
import 'package:tasky/data/api/db/db_handler.dart';
import 'package:tasky/data/model/auth_model/login_model.dart';
import 'package:tasky/data/model/auth_model/refresh_token_and_get_profile.dart';
import 'package:tasky/data/model/auth_model/register_model.dart';
import 'package:tasky/data/model/error_model.dart';
import 'package:tasky/data/model/operation_model.dart/profile_model.dart';
import 'package:tasky/data/repo/error/exceptions.dart';
// ignore: depend_on_referenced_packages
import 'package:dartz/dartz.dart';

class AuthRepo {
  final ApiConsumer? api;
  AuthRepo({
    this.api,
  });

  static String? refresh_token;
  Future<String?> check() async {
    try {
      await CacheHelper().init();
      refresh_token =
          await GetFromDB().getUser()[DbHandlerStrings.coloumn_refresh_token];
    } catch (e) {
      refresh_token = null;
      return null;
    }
    return null;
  }

  Future<Either<String, dynamic>> register(
      {required RegisterModel register_model}) async {
    // to send the request with user data
    try {
      final reponse =
          await api!.post(EndPoint.register, "", isFormData: false, data: {
        ApiKey.phone: register_model.phone,
        ApiKey.password: register_model.password,
        ApiKey.displayName: register_model.display_name,
        ApiKey.experienceYears: register_model.experienceYears,
        ApiKey.address: register_model.address,
        ApiKey.level: register_model.level,
      });

      final registerResponse = RegisterResponseModel.fromMap(reponse);
      // save token and refresh token in the cach helper
      // CacheHelper().saveData(
      //     key: ApiKey.access_token, value: registerResponse.access_token);
      // CacheHelper().saveData(
      //     key: ApiKey.refresh_token, value: registerResponse.refresh_token);
      // CacheHelper().saveData(key: ApiKey.id, value: registerResponse.id);
      // register response
      return Right(registerResponse);
    } on ServerException catch (e) {
      print(e.errorModel.message);

      return Left(e.errorModel.message);
    }
  }

  Future<Either<String, dynamic>> login(
      {required LoginModel login_model}) async {
    try {
      log("first look");
      final response =
          await api!.post(EndPoint.login, " ", isFormData: false, data: {
        ApiKey.phone: login_model.phone,
        ApiKey.password: login_model.password,
      });
      LoginResponseModel loginResponse = LoginResponseModel.fromMap(response);
      log("succeful");
      await InsertIntoDB().insertUser(response: loginResponse);

      // save token and refresh token in the cach helper
      // CacheHelper().saveData(
      //     key: ApiKey.access_token, value: login_response.access_token);
      // CacheHelper().saveData(
      //     key: ApiKey.refresh_token, value: login_response.refresh_token);
      // CacheHelper().saveData(key: ApiKey.id, value: login_response.id);

      return right(loginResponse);
    } catch (e) {
      log("responce is $e},");

      return left(e.toString());
      // TODO
    }
  }

  Future<Either<String, dynamic>> logout() async {
    try {
      log("message");

      LogoutModel? logoutResponse;
      Either<String, dynamic> refreshToken = await getAccessToken();

      if (refreshToken.isRight()) {
        RegExp regExp = RegExp(r'access_token:\s*(\S+)(?=\s*\})');
        Match? match = regExp.firstMatch(refreshToken.toString());
        var response = await api!.post(EndPoint.logout, match!.group(1)!);
        logoutResponse = LogoutModel.fromMap(response);
      } else {
        log("$refreshToken ");
        throw Exception("there is an error wait for new update");
      }

      await DeleteFromDb().deletUser();
      // clear all data in cash
      // CacheHelper().clearData(key: ApiKey.access_token);
      // CacheHelper().clearData(key: ApiKey.refresh_token);
      // CacheHelper().clearData(key: ApiKey.id);

      return right(logoutResponse);
    } catch (e) {
      return left(e.toString());
      // TODO
    }
  }

// to get access token by refresh token before any requist
// precondtion : .........................................
// postcondtion : the result Either error msg or responce with accesstoken
  Future<Either<String, dynamic>> getAccessToken() async {
    try {
      var refreshToken = await GetFromDB().getUser();
      log("fuck at all $refreshToken");

      var response = await api!.get(
        EndPoint.refresh,
        "",
        queryParameters: {
          ApiKey.token: refreshToken[DbHandlerStrings.coloumn_refresh_token]
        },
      );
      Map<String, dynamic> accesstoken = {
        DbHandlerStrings.coloumn_access_token: response[ApiKey.access_token],
      };
      await UpdateDb().updateUser(accesstoken);
      return right(accesstoken);
    } catch (e) {
      log("typess $e");
      return left(e.toString());
    }
  }
}
