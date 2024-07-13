part of 'todo_cubit.dart';

@immutable
sealed class TodosState {}

final class TodosInitial extends TodosState {}

final class TodosLoading extends TodosState {}

final class TodosFailure extends TodosState {
  final String error_message;
  TodosFailure({required this.error_message});
}

final class TodosSuccess extends TodosState {
  List<TaskModel> task_model_list;
  TodosSuccess(this.task_model_list);
}
