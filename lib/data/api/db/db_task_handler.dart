import 'dart:developer';

import 'package:tasky/constants/db_handler_strings.dart';
import 'package:tasky/data/api/db/db_handler.dart';
import 'package:tasky/data/api/db/db_user_handler.dart';
import 'package:tasky/data/model/operation_model.dart/task_model.dart';

abstract class DbTaskConsumer {
  const DbTaskConsumer();
  get();

  insert({required TaskModel model});
  update({required Map<String, dynamic> map});
  delete();
}

class DbTask extends DbTaskConsumer {
  @override
  delete() async {
    try {
      final db = await DbHandler.openMyDatabase();
      final rows = await db.delete(
        DbHandlerStrings.todos_table,
        where: 'id = ?',
        whereArgs: [0],
      );
      return rows;
    } catch (e) {
      return e.toString();
    }
  }

  @override
  insert({required TaskModel model}) async {
    try {
      final db = await DbHandler.openMyDatabase();
      //
      final rows = await db.insert(
        DbHandlerStrings.todos_table,
        {
          DbHandlerStrings.coloumn_todo_id: model.id,
          DbHandlerStrings.column_todo_image: model.image,
          DbHandlerStrings.coloumn_todo_title: model.title,
          DbHandlerStrings.cloumn_todo_desc: model.desc,
          DbHandlerStrings.coloumn_todo__priority: model.priority,
          DbHandlerStrings.coloumn_todo__status: model.status,
          DbHandlerStrings.coloumn_todo__user_id: model.user,
          DbHandlerStrings.coloumn_todo__version: model.iV,
          DbHandlerStrings.coloumn_todo__todo_created_at: model.createdAt,
          DbHandlerStrings.coloumn_todo__todo_updated_at: model.updatedAt
        },
      );
      log("$rows rows");
      return rows;
    } catch (e) {
      log("$e insert error");
      rethrow;
    }
  }

  @override
  update({required Map<String, dynamic> map}) async {
    log("$map start updating access token");

    final db = await DbHandler.openMyDatabase();
    log("---------------------------------------");

    final user = await DbUser().get();
    log("$user  qqqqqqqqq");

    log("update");
    var success = await db.update(
      DbHandlerStrings.table,
      map,
      where: "${DbHandlerStrings.cloumn_id} = ?",
      whereArgs: [user[DbHandlerStrings.cloumn_id]],
    );
    log("$success ${user[DbHandlerStrings.cloumn_id]}");

    log("$success is not easy to");
    final s = await DbUser().get();
    log("$s  qqqqqqqqqm");
  }

  @override
  get() async {
    try {
      final db = await DbHandler.openMyDatabase();
      final rows = await db.rawQuery(
        'SELECT * FROM ${DbHandlerStrings.todos_table}',
      );
      return rows;
    } catch (e) {
      return e.toString();
    }
  }
}




// "${DbHandlerStrings.coloumn_todo_id}"  TEXT NOT NULL,
//         "${DbHandlerStrings.column_todo_image}" TEXT NOT NULL,
//         "${DbHandlerStrings.coloumn_todo_title}" TEXT NOT NULL,
//         "${DbHandlerStrings.cloumn_todo_desc}" TEXT NOT NULL,
//         "${DbHandlerStrings.coloumn_todo__priority}" TEXT NOT NULL,
//         "${DbHandlerStrings.coloumn_todo__status}" TEXT NOT NULL,
//         "${DbHandlerStrings.coloumn_todo__user_id}" TEXT NOT NULL,
//         "${DbHandlerStrings.coloumn_todo__version}" INTEGER NOT NULL,
//         "${DbHandlerStrings.coloumn_todo__todo_created_at}" TEXT NOT NULL,
//         "${DbHandlerStrings.coloumn_todo__todo_updated_at}" TEXT NOT NULL
