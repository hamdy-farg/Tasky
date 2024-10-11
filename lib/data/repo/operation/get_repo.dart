import 'package:dartz/dartz.dart';
import 'package:tasky/cache/cache_helper.dart';
import 'package:tasky/data/api/auth_api/api_consumer.dart';
import 'package:tasky/data/api/auth_api/end_points.dart';
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
      final response = await api!.get(EndPoint.profile);
      final get_profile_model = ProfileModelResponse.fromMap(response);

      return right(get_profile_model);
    } on ServerException catch (e) {
      if (e.errorModel.message == "Unauthorized") {
        checkIfAutherized(api: api, func: GetRepo().getProfile());
      }
      return left(e.errorModel.message);
    }
  }
}
