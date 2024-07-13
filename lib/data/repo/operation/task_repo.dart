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

  Future<Either<String, dynamic>> getTasks() async {
    try {
      List<TaskModel> task_model_list = [];
      List<dynamic> response =
          await api!.get(EndPoint.todos, queryParameters: {"page": 1});
      response.forEach(
        (element) => task_model_list.add(TaskModel.fromJson(element)),
      );
      return right(task_model_list);
    } on ServerException catch (e) {
      if (e.errorModel.message == "Unauthorized") {
        checkIfAutherized(api: api, func: TaskRepo().getTasks());
      }
      return left(e.errorModel.message);
    }
  }

  Future<Either<String, dynamic>> addTask(
      {RequistTaskModel? requistTaskModel}) async {
    try {
      final response =
          await api!.post(EndPoint.todos, data: requistTaskModel!.toJson());
      final add_task_response = RequistTaskModel.fromJson(response);
      return Right(add_task_response);
    } on ServerException catch (e) {
      if (e.errorModel.message == "Unauthorized") {
        checkIfAutherized(
            api: api,
            func: TaskRepo().addTask(requistTaskModel: requistTaskModel));
      }
      return left(e.errorModel.message);
    }
  }
}
