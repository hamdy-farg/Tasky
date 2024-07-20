import 'dart:developer';

import 'package:bloc/bloc.dart';
import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tasky/bussiness_logic/get_user_bloc/get_user_bloc.dart';
import 'package:tasky/bussiness_logic/get_user_bloc/get_user_event.dart';
import 'package:tasky/bussiness_logic/operation/todos/cubit/todo_cubit.dart';
import 'package:tasky/data/api/auth_api/dio_consumer.dart';
import 'package:tasky/data/api/db/db_handler.dart';

import 'package:tasky/data/model/auth_model/login_model.dart';
import 'package:tasky/data/model/auth_model/register_model.dart';
import 'package:tasky/data/model/error_model.dart';
import 'package:tasky/data/repo/error/exceptions.dart';
import 'package:tasky/data/repo/operation/auth_repo.dart';
import 'package:tasky/data/repo/operation/get_repo.dart';

part 'auth_state.dart';

class AuthCubit extends Cubit<AuthState> {
  AuthCubit(this.authRepo) : super(AuthInitial());

  final AuthRepo authRepo;
  return_to_init() {
    emit(AuthInitial());
  }

  register({required RegisterModel register_model}) async {
    emit(registerLoading());
    final response = await authRepo.register(register_model: register_model);

    response.fold((message) => emit(registerfailure(error_message: message)),
        (signupResponseModel) => emit(registerSuccess()));
  }

  // login event
  login(
      {required LoginModel login_model, required BuildContext context}) async {
    emit(SigninLoading());
    log('startt');

    try {
      final response = await authRepo.login(login_model: login_model);
      response.fold((message) {
        emit(SigninFailure(error_message: message));
      }, (LoginResponseModeel) async {
        context
            .read<GetUserBloc>()
            .add(AddUserLoginResponseEvent(LoginResponseModeel));
        await InsertIntoDB().insertUser(context);

        final profileModel =
            await GetRepo(api: DioConsumer(dio: Dio())).getProfile();

        //
        profileModel.fold((message) {
          throw ServerException(
              errorModel: ErrorModel(message: "error", statusCode: 404));
        }, (ProfileRespomseModel) {
          ProfileRespomseModel;
        });
        // ignore: use_build_context_synchronously
        context.read<TodoCubit>().getTodos();
        emit(SigninSuccess());
      });
    } on Exception catch (e) {
      Object error;
      if (e.toString().contains("[connection error]")) {
        error = "connection problem check internet";
      } else if (e.toString().contains("[bad response]")) {
        error = "something wrong with your phone number or password";
      } else {
        error = e;
      }
      emit(SigninFailure(error_message: error.toString()));

      // TODO
    }
  }

  // login event
  logout() async {
    emit(LogoutLoading());
    final response = await authRepo.logout();
    response.fold((message) => emit(Logoutfailure(error_message: message)),
        (registerResponseModeel) => emit(LogoutSuccess()));
  }
}
