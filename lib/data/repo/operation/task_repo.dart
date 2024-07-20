import 'package:dartz/dartz.dart';
import 'package:tasky/data/api/auth_api/api_consumer.dart';
import 'package:tasky/data/api/auth_api/end_points.dart';
import 'package:tasky/data/api/db/db_handler.dart';
import 'package:tasky/data/model/operation_model.dart/task_model.dart';
import 'package:tasky/data/repo/error/exceptions.dart';
import 'package:tasky/data/repo/operation/auth_repo.dart';
import 'package:tasky/data/repo/operation/get_repo.dart';

class TaskRepo {
  final ApiConsumer? api;
  TaskRepo({this.api});

  Future<Either<String, dynamic>> getTasks() async {
    try {
      List<TaskModel> taskModelList = [];
      List<dynamic> response =
          await api!.get(EndPoint.todos, queryParameters: {"page": 1});
      for (var element in response) {
        taskModelList.add(TaskModel.fromJson(element));
      }
      for (var element in taskModelList) {
        try {
          await InsertIntoDB().insertTodos(element);
        } catch (e) {
          return left(e.toString());
        }
      }

      return right(taskModelList);
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
      TaskModel addTaskResponse = TaskModel.fromJson(response);

      await InsertIntoDB().insertTodos(addTaskResponse);

      return Right(addTaskResponse);
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
