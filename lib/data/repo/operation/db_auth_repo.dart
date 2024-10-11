import 'package:tasky/cache/cache_helper.dart';
import 'package:tasky/constants/db_handler_strings.dart';
import 'package:tasky/data/api/db/db_handler.dart';
import 'package:tasky/data/api/db/db_user_handler.dart';

class DbAuthRepo {
  static String? refreshToken;
  const DbAuthRepo();
  Future<String?> check() async {
    try {
      await CacheHelper().init();
      refreshToken =
          await DbUser().get()[DbHandlerStrings.coloumn_refresh_token];
    } catch (e) {
      refreshToken = null;
      return null;
    }
    return null;
  }
}
