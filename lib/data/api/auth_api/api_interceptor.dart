import 'dart:developer';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:path/path.dart';
import 'package:tasky/bussiness_logic/get_user_bloc/get_user_bloc.dart';
import 'package:tasky/cache/cache_helper.dart';
import 'package:tasky/data/api/auth_api/end_points.dart';
import 'package:tasky/data/api/db/db_handler.dart';
import 'package:tasky/data/model/get_user_model.dart';
import 'package:tasky/data/repo/operation/auth_repo.dart';

class ApiInterceptor extends Interceptor {
  @override
  void onRequest(
      RequestOptions options, RequestInterceptorHandler handler) async {
    //
    GetUserModel currentUser;
    List<dynamic> user = await GetFromDB().getUser();
    if (user.isNotEmpty) {
      options.headers[ApiKey.Authorization] =
          "Bearer ${user[0][DbHandlerStrings.coloumn_access_token]}";
      log("$user");
    } else {
      options.headers[ApiKey.Authorization] = "";
    }

    super.onRequest(options, handler);
    //
  }
}
