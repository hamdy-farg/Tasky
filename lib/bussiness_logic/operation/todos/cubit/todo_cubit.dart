import 'package:bloc/bloc.dart';
import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:meta/meta.dart';
import 'package:tasky/data/api/db/db_handler.dart';
import 'package:tasky/data/model/operation_model.dart/task_model.dart';
import 'package:tasky/data/repo/operation/task_repo.dart';

part 'todo_state.dart';

class TodoCubit extends Cubit<TodosState> {
  TodoCubit({required this.taskRepo}) : super(TodosInitial());
  TaskRepo taskRepo;

  getTodos() async {
    emit(TodosLoading());
    final response = await taskRepo.getTasks();
    response.fold((message) => emit(TodosFailure(error_message: message)),
        (taskModelList) => emit(TodosSuccess(taskModelList)));
  }

  displayTodos() async {
    emit(TodosLoading());
    try {
      List<TaskModel> tasks = [];
      List response = await GetFromDB().GetAllTodos();
      for (var element in response) {
        tasks.add(TaskModel.fromJson(element));
      }
      emit(TodosSuccess(tasks));
    } catch (e) {
      emit(TodosFailure(error_message: e.toString()));
    }
  }
}
