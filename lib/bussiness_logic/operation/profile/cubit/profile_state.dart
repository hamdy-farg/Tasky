part of 'profile_cubit.dart';

@immutable
sealed class ProfileState {}

final class ProfileInitial extends ProfileState {}

final class ProfileLoading extends ProfileState {}

final class ProfileSuccess extends ProfileState {
  ProfileModelResponse profileModelResponse;
  ProfileSuccess({required this.profileModelResponse});
}

final class ProfileFailure extends ProfileState {
  final String error_message;
  ProfileFailure({required this.error_message});
}
