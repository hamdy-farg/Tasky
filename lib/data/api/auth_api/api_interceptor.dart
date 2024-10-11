import 'dart:developer';

import 'package:dio/dio.dart';
import 'package:tasky/cache/cache_helper.dart';
import 'package:tasky/data/api/auth_api/end_points.dart';

class ApiInterceptor extends Interceptor {
  final String access_token;
  const ApiInterceptor({required this.access_token});

  @override
  void onRequest(RequestOptions options, RequestInterceptorHandler handler) {
    //
    options.headers[ApiKey.Authorization] = 'Bearer $access_token';

    super.onRequest(options, handler);
    //
  }
}
