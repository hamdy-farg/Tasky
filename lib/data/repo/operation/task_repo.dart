import 'dart:developer';

import 'package:dartz/dartz.dart';
import 'package:tasky/data/api/auth_api/api_consumer.dart';
import 'package:tasky/data/api/auth_api/end_points.dart';
import 'package:tasky/data/model/operation_model.dart/task_model.dart';
import 'package:tasky/data/repo/error/exceptions.dart';
import 'package:tasky/data/repo/operation/auth_repo.dart';
import 'package:tasky/data/repo/operation/get_repo.dart';

class TaskRepo {
  final ApiConsumer api;
  TaskRepo({required this.api});

//to get All User Tasks
//pre condition: .....
//postcondition: error msg or taskModellist
  Future<Either<String, dynamic>> getTasks() async {
    try {
<<<<<<< HEAD
      // to store the data from server

      List<dynamic> response = [];
      // to store the data tasks as taskmodel
      List<TaskModel> taskModelList = [];
      // to get access token by refresh token
      Either<String, dynamic> refreshToken =
          await AuthRepo(api: api).getAccessToken();
      refreshToken.fold((msg) {
        throw Exception(msg);
      }, (AccessToken) async {});

      if (refreshToken.isRight()) {
        RegExp regExp = RegExp(r'access_token:\s*(\S+)(?=\s*\})');
        Match? match = regExp.firstMatch(refreshToken.toString());
        response = await api.get(EndPoint.todos, match!.group(1)!,
            queryParameters: {"page": 1});
      } else {
        log("$refreshToken ");
        throw Exception("there is an error wait for new update");
      }
      log("\n\n$response\n ");
      for (var element in response) {
        taskModelList.add(TaskModel.fromJson(element));
      }

      return right(taskModelList);
=======
      List<TaskModel> task_model_list = [];
      List<dynamic> response =
          await api!.get(EndPoint.todos, queryParameters: {"page": 1});
      response.forEach(
        (element) => task_model_list.add(TaskModel.fromJson(element)),
      );
      return right(task_model_list);
>>>>>>> parent of 9029cf5 (d)
    } on ServerException catch (e) {
      // if (e.errorModel.message == "Unauthorized") {
      //   checkIfAutherized(api: api, func: TaskRepo().getTasks());
      // }
      return left(e.errorModel.message);
    }
  }

// addTask: To add New task to The server and our offline db
// precondition : must provie with requestTaskModel
// @ requistTaskModel:
// postcondition: return with error msg of responce from server
  Future<Either<String, dynamic>> addTask(
      {RequistTaskModel? requistTaskModel}) async {
    try {
<<<<<<< HEAD
      var response;
      // to get access token by send refresh token to server
      Either<String, dynamic> refreshToken =
          await AuthRepo(api: api).getAccessToken();

      if (refreshToken.isRight()) {
        RegExp regExp = RegExp(r'access_token:\s*(\S+)(?=\s*\})');
        Match? match = regExp.firstMatch(refreshToken.toString());
        response = await api.post(EndPoint.todos, match!.group(1)!,
            data: requistTaskModel!.toJson());
      } else {
        log("$refreshToken ");
        throw Exception("there is an error wait for new update");
=======
      final response =
          await api!.post(EndPoint.todos, data: requistTaskModel!.toJson());
      final add_task_response = RequistTaskModel.fromJson(response);
      return Right(add_task_response);
    } on ServerException catch (e) {
      if (e.errorModel.message == "Unauthorized") {
        checkIfAutherized(
            api: api,
            func: TaskRepo().addTask(requistTaskModel: requistTaskModel));
>>>>>>> parent of 9029cf5 (d)
      }

      final addTaskResponse = RequistTaskModel.fromJson(response);
      return Right(addTaskResponse);
    } catch (e) {
      return left(e.toString());
    }
  }
}
