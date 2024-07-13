import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:tasky/data/model/operation_model.dart/profile_model.dart';
import 'package:tasky/data/repo/operation/auth_repo.dart';
import 'package:tasky/data/repo/operation/get_repo.dart';

part 'profile_state.dart';

class ProfileCubit extends Cubit<ProfileState> {
  ProfileCubit(this.getRepo) : super(ProfileInitial());
  final GetRepo getRepo;

  getprofile() async {
    emit(ProfileLoading());
    final response = await getRepo.getProfile();
    response.fold(
        (message) => emit(ProfileFailure(error_message: message)),
        (profile_response_modeel) => emit(
            ProfileSuccess(profileModelResponse: profile_response_modeel)));
  }
}
