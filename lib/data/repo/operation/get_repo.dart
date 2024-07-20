import 'dart:developer';

import 'package:dartz/dartz.dart';
import 'package:tasky/data/api/auth_api/api_consumer.dart';
import 'package:tasky/data/api/auth_api/end_points.dart';
import 'package:tasky/data/api/db/db_handler.dart';
import 'package:tasky/data/model/operation_model.dart/profile_model.dart';
import 'package:tasky/data/repo/error/exceptions.dart';

class GetRepo {
  final ApiConsumer? api;
  GetRepo({this.api});

  Future<Either<String, dynamic>> getProfile() async {
    try {
      log("starting");

      final response = await api!.get(EndPoint.profile);

      log("$response");
      ProfileModelResponse getProfileModel =
          ProfileModelResponse.fromMap(response);
      return right(getProfileModel);
    } on ServerException catch (e) {
      // if (e.errorModel.message == "Unauthorized") {
      //   checkIfAutherized(api: api, func: GetRepo().getProfile());
      // }
      return left(e.errorModel.message);
    }
  }
}
