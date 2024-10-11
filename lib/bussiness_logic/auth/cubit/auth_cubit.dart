import 'dart:developer';

import 'package:bloc/bloc.dart';
import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:meta/meta.dart';
import 'package:tasky/data/api/auth_api/end_points.dart';
import 'package:tasky/data/api/db/db_handler.dart';
import 'package:tasky/data/model/auth_model/login_model.dart';
import 'package:tasky/data/model/auth_model/register_model.dart';
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
  login({required LoginModel login_model}) async {
    emit(SigninLoading());
    final response = await authRepo.login(login_model: login_model);
    response.fold((message) => emit(SigninFailure(error_message: message)),
        (registerResponseModeel) => emit(SigninSuccess()));
  }

  // logout event
  logout() async {
    emit(LogoutLoading());
    final response = await authRepo.logout();

    response.fold((message) => emit(Logoutfailure(error_message: message)),
        (registerResponseModeel) {
      log("done successfuly");
      emit(LogoutSuccess());
    });
  }
}
