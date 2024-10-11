import 'package:dartz/dartz.dart';
import 'package:tasky/data/api/auth_api/api_consumer.dart';
import 'package:tasky/data/api/auth_api/end_points.dart';
import 'package:tasky/data/model/operation_model.dart/task_model.dart';
import 'package:tasky/data/repo/error/exceptions.dart';
import 'package:tasky/data/repo/operation/auth_repo.dart';
import 'package:tasky/data/repo/operation/get_repo.dart';

class TaskRepo {
  final ApiConsumer? api;
  TaskRepo({this.api});
//to get All User Tasks
//pre condition: .....
//postcondition: error msg or taskModellist

  Future<Either<String, dynamic>> getTasks() async {
    try {
      // to store the data from server

      List<dynamic> response = [];
      // to store the data tasks as taskmodel
      List<TaskModel> taskModelList = [];
      // to get access token by refresh token
      Either<String, dynamic> refreshToken = await AuthRepo().getAccessToken();
      refreshToken.fold((msg) {
        throw Exception(msg);
      }, (AccessToken) async {
        response = await api!
            .get(EndPoint.todos, AccessToken, queryParameters: {"page": 1});
      });
      for (var element in response) {
        taskModelList.add(TaskModel.fromJson(element));
      }

      return right(taskModelList);
    } on ServerException catch (e) {
      // if (e.errorModel.message == "Unauthorized") {
      //   checkIfAutherized(api: api, func: TaskRepo().getTasks());
      // }
      return left(e.errorModel.message);
    }
  }

  Future<Either<String, dynamic>> addTask(
      {RequistTaskModel? requistTaskModel}) async {
    try {
      var response;
      // to get access token by send refresh token to server
      Either<String, dynamic> refreshToken = await AuthRepo().getAccessToken();
      //chc
      refreshToken.fold((msg) {
        throw Exception(msg);
      }, (AccessToken) async {
        await api!.post(EndPoint.todos, AccessToken,
            data: requistTaskModel!.toJson());
      });
      final addTaskResponse = RequistTaskModel.fromJson(response);
      return Right(addTaskResponse);
    } on ServerException catch (e) {
      // if (e.errorModel.message == "Unauthorized") {
      //   checkIfAutherized(
      //       api: api,
      //       func: TaskRepo().addTask(requistTaskModel: requistTaskModel));
      // }
      return left(e.errorModel.message);
    }
  }
}
