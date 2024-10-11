import 'dart:developer';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';
import 'package:tasky/bussiness_logic/get_user_bloc/get_user_bloc.dart';
import 'package:tasky/bussiness_logic/get_user_bloc/get_user_event.dart';
import 'package:tasky/constants/db_handler_strings.dart';
import 'package:tasky/data/api/db/db_user_handler.dart';
import 'package:tasky/data/model/auth_model/login_model.dart';
import 'package:tasky/data/model/get_user_model.dart';
import 'package:tasky/data/model/operation_model.dart/task_model.dart';

class DbHandler {
  // make this a as singleton class
  DbHandler._privateConstructor() {
    DbHandler.openMyDatabase();
  }
  static final DbHandler instance = DbHandler._privateConstructor();
  factory DbHandler() {
    return instance;
  }
  static Future<Database> openMyDatabase() async {
    final path = join(await getDatabasesPath(), DbHandlerStrings.db_name);

    return await openDatabase(path, version: DbHandlerStrings.db_version,
        onCreate: (db, version) async {
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
          "${DbHandlerStrings.cloumn_address}" TEXT NOT NULL,
          "${DbHandlerStrings.cloumn_phone}" TEXT NOT NULL,
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

