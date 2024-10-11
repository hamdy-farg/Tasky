import 'package:flutter/cupertino.dart';

@immutable
sealed class AcessTokenState {
  const AcessTokenState();
}

class AcessTokenInitial extends AcessTokenState {}

class AccessTokenSuccess extends AcessTokenState {
  final String access_token;
  const AccessTokenSuccess({required this.access_token});
}

class AcessTokenFailure extends AcessTokenState {
  final String msg;
  const AcessTokenFailure({required this.msg});
}

class AcessTokenLoading extends AcessTokenState {}
