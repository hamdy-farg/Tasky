import 'package:dartz/dartz.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tasky/bussiness_logic/auth/refresh_token_cubit.dart/refresh_token_state.dart';
import 'package:tasky/data/api/auth_api/end_points.dart';
import 'package:tasky/data/repo/operation/auth_repo.dart';
import 'package:tasky/data/repo/operation/get_repo.dart';

class AccessTokenCubit extends Cubit<AcessTokenState> {
  AccessTokenCubit(this.auth_repo) : super(AcessTokenInitial());
  final AuthRepo auth_repo;
  getAcessToken() async {
    emit(AcessTokenLoading());
    Either<String, dynamic> AcessToken = await auth_repo.getAccessToken();
    AcessToken.fold(
        ((msg) => emit(AcessTokenFailure(msg: msg))),
        (response) => emit(
            AccessTokenSuccess(access_token: response[ApiKey.access_token])));
  }
}
