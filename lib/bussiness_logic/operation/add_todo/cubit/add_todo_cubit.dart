import 'package:bloc/bloc.dart';
import 'package:dio/dio.dart';
import 'package:image_picker/image_picker.dart';
import 'package:meta/meta.dart';
import 'package:tasky/data/model/operation_model.dart/task_model.dart';
import 'package:tasky/data/repo/operation/task_repo.dart';

part 'add_todo_state.dart';

class AddTodoCubit extends Cubit<AddTodoState> {
  AddTodoCubit(this.task_repo) : super(AddTodoInitial());
  TaskRepo task_repo;

  uplod_image(XFile image) {
    emit(imageLoading());
    XFile? todo_image = image;
    emit((imageLoaded(image: todo_image)));
  }

  return_to_init() {
    emit(AddTodoInitial());
  }

  addTodo({required RequistTaskModel requist_task_model}) async {
    emit(AddTodoloading());
    final response =
        await task_repo.addTask(requistTaskModel: requist_task_model);
    response.fold(
      (message) => emit(AddTodoFailure(error_message: message)),
      (response_task_model) => emit(
        AddTodoSuccess(),
      ),
    );
  }
}
