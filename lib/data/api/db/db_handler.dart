import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';
import 'package:tasky/bussiness_logic/get_user_bloc/get_user_bloc.dart';
import 'package:tasky/data/model/get_user_model.dart';
import 'package:tasky/data/model/operation_model.dart/task_model.dart';

class DbHandlerStrings {
  static const _db_name = 'tasky5.db';
  static const _db_version = 3;
  //
  static const todos_table = "Todos";
  static const table = 'user';
  static const cloumn_id = '_id';
  static const coloumn_experience_year = 'experience_year';
  static const column_user_name = 'user_name';
  static const cloumn_phone = 'phone';
  static const cloumn_address = 'address';
  static const coloumn_level = 'level';
  static const coloumn_active = 'active';
  static const coloumn_access_token = 'access_token';
  static const coloumn_refresh_token = 'refresh_token';
  static const coloumn_rules = 'rules';
  static const coloumn_created_at = 'created_at';
  static const coloumn_updated_at = 'updated_at';
  static const coloumn_version = 'version';

  //? TODO
  static const coloumn_todo_id = '_id';
  static const column_todo_image = 'image';
  static const coloumn_todo_title = 'phone';
  static const cloumn_todo_desc = 'desc';
  static const coloumn_todo__priority = 'priority';
  static const coloumn_todo__user_id = 'user';
  static const coloumn_todo__status = 'status';

  static const coloumn_todo__version = "__v";

  static const coloumn_todo__todo_created_at = 'created_at';
  static const coloumn_todo__todo_updated_at = 'updated_at';
}

class DbHandler {
  // make this a as singleton class
  DbHandler._privateConstructor();
  static final DbHandler instance = DbHandler._privateConstructor();
  static Future<Database> openMyDatabase() async {
    log("message4");

    final path = join(await getDatabasesPath(), DbHandlerStrings._db_name);
    log("message5");

    return await openDatabase(path, version: DbHandlerStrings._db_version,
        onCreate: (db, version) async {
      log("message6");
      await db.execute("""
        CREATE TABLE "${DbHandlerStrings.todos_table}" (
         "${DbHandlerStrings.coloumn_todo_id}"  TEXT NOT NULL,
          "${DbHandlerStrings.column_todo_image}" TEXT NOT NULL,
          "${DbHandlerStrings.coloumn_todo_title}" TEXT NOT NULL,
          "${DbHandlerStrings.cloumn_todo_desc}" TEXT NOT NULL,
          "${DbHandlerStrings.coloumn_todo__priority}" TEXT NOT NULL,
          "${DbHandlerStrings.coloumn_todo__status}" TEXT NOT NULL,
          "${DbHandlerStrings.coloumn_todo__user_id}" TEXT NOT NULL,
          "${DbHandlerStrings.coloumn_todo__version}" INTEGER NOT NULL,
          "${DbHandlerStrings.coloumn_todo__todo_created_at}" TEXT NOT NULL,
          "${DbHandlerStrings.coloumn_todo__todo_updated_at}" TEXT NOT NULL
        )
""");
      db.execute("""
        CREATE TABLE "${DbHandlerStrings.table}" (
         "${DbHandlerStrings.cloumn_id}"  TEXT NOT NULL,
          "${DbHandlerStrings.column_user_name}" TEXT NOT NULL,
          "${DbHandlerStrings.coloumn_rules}" TEXT NOT NULL,
          "${DbHandlerStrings.coloumn_active}" INTEGER NOT NULL,
          "${DbHandlerStrings.coloumn_experience_year}" INTEGER NOT NULL,
          "${DbHandlerStrings.coloumn_level}" TEXT NOT NULL,
          "${DbHandlerStrings.coloumn_created_at}" TEXT NOT NULL,
          "${DbHandlerStrings.coloumn_updated_at}" TEXT NOT NULL,
          "${DbHandlerStrings.coloumn_version}" INTEGER NOT NULL,
          "${DbHandlerStrings.coloumn_access_token}" TEXT NOT NULL,
          "${DbHandlerStrings.coloumn_refresh_token}" TEXT NOT NULL
        )
""");
    });
  }
}

class GetFromDB {
  GetAllTodos() async {
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

  getUser() async {
    try {
      final db = await DbHandler.openMyDatabase();
      final rows = await db.rawQuery(
        'SELECT * FROM ${DbHandlerStrings.table}',
      );
      log("1");
      return rows;
    } catch (e) {
      return e.toString();
    }
  }
}

class InsertIntoDB {
  insertUser(BuildContext context) async {
    final state = context.read<GetUserBloc>().state;
    try {
      final db = await DbHandler.openMyDatabase();
      await db.delete(DbHandlerStrings.table);
      final rows = await db.insert(
        'user',
        {
          DbHandlerStrings.cloumn_id: state.cloumn_id,
          DbHandlerStrings.column_user_name: state.column_user_name,
          DbHandlerStrings.coloumn_rules: state.coloumn_rules,
          DbHandlerStrings.coloumn_active: state.coloumn_active,
          DbHandlerStrings.coloumn_experience_year:
              state.coloumn_experience_year,
          DbHandlerStrings.coloumn_level: state.coloumn_level,
          DbHandlerStrings.coloumn_created_at: state.coloumn_created_at,
          DbHandlerStrings.coloumn_updated_at: state.coloumn_updated_at,
          DbHandlerStrings.coloumn_version: state.coloumn_version,
          DbHandlerStrings.coloumn_access_token: state.coloumn_access_token,
          DbHandlerStrings.coloumn_refresh_token: state.coloumn_refresh_token,
        },
      );
      log("$rows");
      return rows;
    } catch (e) {
      return e.toString();
    }
  }

  insertTodos(TaskModel taskModel) async {
    try {
      final db = await DbHandler.openMyDatabase();
      await db.delete(DbHandlerStrings.table);
      final rows = await db.insert(
        DbHandlerStrings.todos_table,
        {
          DbHandlerStrings.coloumn_todo_id: taskModel.id,
          DbHandlerStrings.column_todo_image: taskModel.image,
          DbHandlerStrings.coloumn_todo_title: taskModel.title,
          DbHandlerStrings.cloumn_todo_desc: taskModel.desc,
          DbHandlerStrings.coloumn_todo__priority: taskModel.priority,
          DbHandlerStrings.coloumn_todo__status: taskModel.priority,
          DbHandlerStrings.coloumn_todo__user_id: taskModel.user,
          DbHandlerStrings.coloumn_todo__version: taskModel.iV,
          DbHandlerStrings.coloumn_todo__todo_created_at: taskModel.createdAt,
          DbHandlerStrings.coloumn_todo__todo_updated_at: taskModel.updatedAt
        },
      );
      log("$rows");
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