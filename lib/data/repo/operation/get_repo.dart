import 'dart:developer';

import 'package:dartz/dartz.dart';
import 'package:tasky/bussiness_logic/auth/refresh_token_cubit.dart/refresh_token_cubit.dart';
import 'package:tasky/cache/cache_helper.dart';
import 'package:tasky/data/api/auth_api/api_consumer.dart';
import 'package:tasky/data/api/auth_api/end_points.dart';
import 'package:tasky/data/api/db/db_handler.dart';
import 'package:tasky/data/model/operation_model.dart/profile_model.dart';
import 'package:tasky/data/repo/error/exceptions.dart';
import 'package:tasky/data/repo/operation/auth_repo.dart';

class GetRepo {
  final ApiConsumer api;
  GetRepo({required this.api});
// to get All User Profile Data
// preCondition: ...
// postCondition : error msg profileModel
  Future<Either<String, dynamic>> getProfile() async {
    try {
      var response;
      Either<String, dynamic> refreshToken =
          await AuthRepo(api: api).getAccessToken();

      refreshToken.fold((msg) {}, (AccessToken) async {});
      ProfileModelResponse? profileModel;

      if (refreshToken.isRight()) {
        RegExp regExp = RegExp(r'access_token:\s*(\S+)(?=\s*\})');
        Match? match = regExp.firstMatch(refreshToken.toString());
        var response = await api.get(EndPoint.profile, match!.group(1)!);
        profileModel = ProfileModelResponse.fromMap(response);
      } else {
        log("$refreshToken ");
        throw Exception("there is an error wait for new update");
      }

      return right(profileModel);
    } catch (e) {
      return left(e.toString());
    }
  }
}
