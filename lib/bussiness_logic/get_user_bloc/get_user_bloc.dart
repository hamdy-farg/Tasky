import 'dart:developer';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tasky/bussiness_logic/get_user_bloc/get_user_event.dart';
import 'package:tasky/bussiness_logic/get_user_bloc/get_user_state.dart';

class GetUserBloc extends Bloc<LoginEvent, LoginState> {
  GetUserBloc() : super(LoginState()) {
    on<AddUserLoginResponseEvent>(_userLoginResponse);
    on<AddUserGetDataEvent>(_userGetData);
  }

  void _userLoginResponse(
      AddUserLoginResponseEvent event, Emitter<LoginState> emit) {
    log("state");
    //print("my email is ${event.email}");
    emit(state.copyWith(
      cloumn_id: event.responce.id,
      coloumn_access_token: event.responce.access_token,
      coloumn_refresh_token: event.responce.refresh_token,
    ));
  }

  void _userGetData(AddUserGetDataEvent event, Emitter<LoginState> emit) {
    // print("my password is ${event.password}");
    emit(state.copyWith(
      column_user_name: event.user.column_user_name,
      coloumn_rules: event.user.coloumn_rules,
      coloumn_active: event.user.coloumn_active,
      coloumn_experience_year: event.user.coloumn_experience_year,
      coloumn_level: event.user.coloumn_level,
      coloumn_access_token: event.user.coloumn_created_at,
      coloumn_updated_at: event.user.coloumn_updated_at,
      coloumn_version: event.user.coloumn_version,
    ));
  }
}
