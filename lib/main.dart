import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:tasky/app_router.dart';
import 'package:tasky/bussiness_logic/auth/cubit/auth_cubit.dart';
import 'package:tasky/bussiness_logic/auth/refresh_token_cubit.dart/refresh_token_cubit.dart';
import 'package:tasky/bussiness_logic/operation/profile/cubit/profile_cubit.dart';
import 'package:tasky/bussiness_logic/operation/todos/cubit/todo_cubit.dart';
import 'package:tasky/constants/Screens.dart';
import 'package:tasky/data/api/auth_api/dio_consumer.dart';
import 'package:tasky/data/repo/operation/auth_repo.dart';
import 'package:tasky/data/repo/operation/db_auth_repo.dart';
import 'package:tasky/data/repo/operation/get_repo.dart';
import 'package:tasky/data/repo/operation/task_repo.dart';

import 'bussiness_logic/operation/add_todo/cubit/add_todo_cubit.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await const DbAuthRepo().check();
  String? isLogin;
  runApp(MyApp(
    app_router: AppRouter(),
    is_login: isLogin,
  ));
}

class MyApp extends StatelessWidget {
  String? is_login;
  final AppRouter app_router;
  MyApp({
    required this.is_login,
    super.key,
    required this.app_router,
  });

  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      child: MultiBlocProvider(
        providers: [
          BlocProvider(
            create: (context) => AuthCubit(AuthRepo(
              api: DioConsumer(
                dio: Dio(),
              ),
            )),
            child: Container(),
          ),
          BlocProvider(
            create: (context) => AccessTokenCubit(AuthRepo(
              api: DioConsumer(
                dio: Dio(),
              ),
            )),
            child: Container(),
          ),
          BlocProvider(
            create: (context) => ProfileCubit(GetRepo(
                api: DioConsumer(
              dio: Dio(),
            ))),
            child: Container(),
          ),
          BlocProvider(
            create: (context) => TodoCubit(
                taskRepo: TaskRepo(
                    api: DioConsumer(
              dio: Dio(),
            ))),
            child: Container(),
          ),
          BlocProvider(
            create: (context) => AddTodoCubit(TaskRepo(
                api: DioConsumer(
              dio: Dio(),
            ))),
            child: Container(),
          )
        ],
        child: MaterialApp(
          debugShowCheckedModeBanner: false,
          theme: ThemeData(
            scaffoldBackgroundColor: Colors.white,
            colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
            useMaterial3: true,
          ),
          initialRoute: DbAuthRepo.refreshToken == null
              ? Screens.entery_screen
              : Screens.home_screen,
          onGenerateRoute: app_router.generateRoute,
        ),
      ),
    );
  }
}
