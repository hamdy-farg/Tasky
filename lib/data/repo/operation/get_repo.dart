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
      Either<String, dynamic> refreshToken = await AuthRepo().getAccessToken();
      refreshToken.fold((msg) {
        throw Exception(msg);
      }, (AccessToken) async {
        response = await api.get(EndPoint.profile, AccessToken);
      });
      final getProfileModel = ProfileModelResponse.fromMap(response);

      return right(getProfileModel);
    } on ServerException catch (e) {
      return left(e.errorModel.message);
    }
  }
}
