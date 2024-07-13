part of 'add_todo_cubit.dart';

@immutable
sealed class AddTodoState {}

final class AddTodoInitial extends AddTodoState {}

final class AddTodoloading extends AddTodoState {}

final class AddTodoFailure extends AddTodoState {
  final String error_message;
  AddTodoFailure({required this.error_message});
}

final class AddTodoSuccess extends AddTodoState {}

final class imageLoading extends AddTodoState {}

final class imageLoaded extends AddTodoState {
  XFile image;
  imageLoaded({required this.image});
}
