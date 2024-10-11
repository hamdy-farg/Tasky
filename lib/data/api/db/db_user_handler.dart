import 'dart:developer';

import 'package:tasky/constants/db_handler_strings.dart';
import 'package:tasky/data/api/db/db_handler.dart';
import 'package:tasky/data/model/auth_model/login_model.dart';

abstract class DbUserConsumer {
  const DbUserConsumer();
  get();

  insert({required LoginResponseModel model});
  update({required Map<String, dynamic> map});
  delete();
}

class DbUser extends DbUserConsumer {
  @override
  get() async {
    try {
      final db = await DbHandler.openMyDatabase();
      log("gettin user");

      final rows = await db.rawQuery(
        'SELECT * FROM ${DbHandlerStrings.table}',
      );
      log("db is $rows");
      return rows[0];
    } catch (e) {
      return e.toString();
    }
  }

  @override
  update({required Map<String, dynamic> map}) {}

  @override
  delete() async {
    try {
      log("useeeeeeeee");
      final db = await DbHandler.openMyDatabase();
      final rows = await db.delete(
        DbHandlerStrings.table,
      );
      return rows;
    } catch (e) {
      return e.toString();
    }
  }

  @override
  insert({required LoginResponseModel model}) async {
    log(" ${model.id} , ${model.access_token} ,${model.refresh_token}");
    log("hiiiiiiiiii");
    try {
      log("path of db");

      final db = await DbHandler.openMyDatabase();
      log("path of db${db.path}");
      await db.delete(DbHandlerStrings.table);
      final rows = await db.insert(
        "user",
        {
          DbHandlerStrings.cloumn_id: model.id,
          DbHandlerStrings.column_user_name: "",
          DbHandlerStrings.coloumn_rules: "",
          DbHandlerStrings.coloumn_active: "",
          DbHandlerStrings.coloumn_experience_year: "",
          DbHandlerStrings.cloumn_address: "",
          DbHandlerStrings.cloumn_phone: "",
          DbHandlerStrings.coloumn_level: "",
          DbHandlerStrings.coloumn_created_at: "",
          DbHandlerStrings.coloumn_updated_at: "",
          DbHandlerStrings.coloumn_version: "",
          DbHandlerStrings.coloumn_access_token: model.access_token,
          DbHandlerStrings.coloumn_refresh_token: model.refresh_token,
        },
      );
      log("$rows");
      return rows;
    } catch (e) {
      log("[Error In inserting Login  Data ] \n ${e.toString()}");
      rethrow;
    }
  }
}
