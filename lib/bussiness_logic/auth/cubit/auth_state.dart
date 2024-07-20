part of 'auth_cubit.dart';

@immutable
sealed class AuthState {}


// operation related to sign in
final class AuthInitial extends AuthState {}

final class SigninSuccess extends AuthState {
  
}

final class SigninLoading extends AuthState {}

final class SigninFailure extends AuthState {
  final String error_message;
  SigninFailure({required this.error_message});
}

// operation related to register
final class registerSuccess extends AuthState {}

final class registerLoading extends AuthState {}

final class registerfailure extends AuthState {
   final String error_message;
  registerfailure({required this.error_message});
}

// user logout 
final class LogoutSuccess extends AuthState {}

final class LogoutLoading extends AuthState {}

final class Logoutfailure extends AuthState {
   final String error_message;
  Logoutfailure({required this.error_message});
}




// operation related to display user information
final class GetUserSuccess extends AuthState {}

final class GetUserLoading extends AuthState {}

final class GetUserFailure extends AuthState {
  final String error_message;
  GetUserFailure({required this.error_message});
}
