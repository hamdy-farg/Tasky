import 'package:bloc/bloc.dart';
import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:meta/meta.dart';
import 'package:tasky/data/api/auth_api/end_points.dart';
<<<<<<< HEAD
import 'package:tasky/data/api/db/db_handler.dart';
=======
>>>>>>> parent of 9029cf5 (d)
import 'package:tasky/data/model/auth_model/login_model.dart';
import 'package:tasky/data/model/auth_model/register_model.dart';
import 'package:tasky/data/repo/operation/auth_repo.dart';

part 'auth_state.dart';

class AuthCubit extends Cubit<AuthState> {
  AuthCubit(this.authRepo) : super(AuthInitial());

  final AuthRepo authRepo;
  return_to_init() {
    emit(AuthInitial());
  }

  register({required RegisterModel register_model}) async {
    print("111111111");
    emit(registerLoading());
    final response = await authRepo.register(register_model: register_model);
    response.fold((message) => emit(registerfailure(error_message: message)),
        (signup_response_model) => emit(registerSuccess()));
  }

  // login event
  login({required LoginModel login_model}) async {
    emit(SigninLoading());
    final response = await authRepo.login(login_model: login_model);
    response.fold((message) => emit(SigninFailure(error_message: message)),
<<<<<<< HEAD
        (registerResponseModeel) => emit(SigninSuccess()));
=======
        (register_response_modeel) => emit(SigninSuccess()));
>>>>>>> parent of 9029cf5 (d)
  }

  // logout event
  logout() async {
    emit(LogoutLoading());
    final response = await authRepo.logout();

    response.fold((message) => emit(Logoutfailure(error_message: message)),
<<<<<<< HEAD
        (registerResponseModeel) {
      log("done successfuly");
      emit(LogoutSuccess());
    });
=======
        (register_response_modeel) => emit(LogoutSuccess()));
>>>>>>> parent of 9029cf5 (d)
  }
}
