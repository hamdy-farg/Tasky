import 'package:dio/dio.dart';
import 'package:tasky/cache/cache_helper.dart';
import 'package:tasky/data/api/auth_api/end_points.dart';

class ApiInterceptor extends Interceptor {
  @override
  void onRequest(RequestOptions options, RequestInterceptorHandler handler) {
    //
    options.headers[ApiKey.Authorization] =
        CacheHelper().getData(key: ApiKey.access_token) != null
            ? 'Bearer ${CacheHelper().getData(key: ApiKey.access_token)}'
            : null;

    super.onRequest(options, handler);
    //
  }
}
