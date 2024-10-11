// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:developer';

import 'package:dio/dio.dart';
import 'package:tasky/data/model/error_model.dart';

class ServerException implements Exception {
  final ErrorModel errorModel;
  ServerException({
    required this.errorModel,
  });
}

void handleDioExceptions(DioException e) {
  switch (e.type) {
    case DioExceptionType.connectionTimeout:
      throw ServerException(
          errorModel: ErrorModel.fromMap(
        e.response!.data,
      ));
    // TODO: Handle this case.
    case DioExceptionType.sendTimeout:
      throw ServerException(
          errorModel: ErrorModel.fromMap(
        e.response!.data,
      ));
    // TODO: Handle this case.
    case DioExceptionType.receiveTimeout:
      throw ServerException(
          errorModel: ErrorModel.fromMap(
        e.response!.data,
      ));
    // TODO: Handle this case.
    case DioExceptionType.badCertificate:
      throw ServerException(
          errorModel: ErrorModel.fromMap(
        e.response!.data,
      ));
    // TODO: Handle this case.
    case DioExceptionType.cancel:
      throw ServerException(
          errorModel: ErrorModel.fromMap(
        e.response!.data,
      ));
    // TODO: Handle this case.
    case DioExceptionType.connectionError:
      log("how are you ${e.response!.data}");
      throw ServerException(
          errorModel: ErrorModel.fromMap(
        e.response!.data,
      ));
    // TODO: Handle this case.
    case DioExceptionType.unknown:
      throw ServerException(
          errorModel: ErrorModel.fromMap(
        e.response!.data,
      ));
    // TODO: Handle this case.
    case DioExceptionType.badResponse:
      switch (e.response?.statusCode) {
        case 400: // Bad request
          throw ServerException(
              errorModel: ErrorModel.fromMap(e.response!.data));
        case 401: //unauthorized
          throw ServerException(
              errorModel: ErrorModel.fromMap(e.response!.data));
        case 403: //forbidden
          throw ServerException(
              errorModel: ErrorModel.fromMap(e.response!.data));
        case 404: //not found
          throw ServerException(
              errorModel: ErrorModel.fromMap(e.response!.data));
        case 409: //cofficient
          throw ServerException(
              errorModel: ErrorModel.fromMap(e.response!.data));
        case 422: //  Unprocessable Entity
          throw ServerException(
              errorModel: ErrorModel.fromMap(e.response!.data));
        case 504: // Server exception
          throw ServerException(
              errorModel: ErrorModel.fromMap(e.response!.data));
      }
  }
}

