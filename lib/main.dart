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
<<<<<<< HEAD
  await const DbAuthRepo().check();
  String? isLogin;
  runApp(MyApp(
    app_router: AppRouter(),
    is_login: isLogin,
=======
  await AuthRepo().check();
  String? is_login;
  runApp(MyApp(
    app_router: AppRouter(),
    is_login: is_login,
>>>>>>> parent of 9029cf5 (d)
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
<<<<<<< HEAD
=======
    is_login = AuthRepo.refresh_token;
>>>>>>> parent of 9029cf5 (d)
    return ScreenUtilInit(
      child: MultiBlocProvider(
        providers: [
          BlocProvider(
<<<<<<< HEAD
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
=======
            create: (context) =>
                AuthCubit(AuthRepo(api: DioConsumer(dio: Dio()))),
            child: Container(),
          ),
          BlocProvider(
            create: (context) =>
                ProfileCubit(GetRepo(api: DioConsumer(dio: Dio()))),
            child: Container(),
          ),
          BlocProvider(
            create: (context) =>
                TodoCubit(taskRepo: TaskRepo(api: DioConsumer(dio: Dio()))),
            child: Container(),
          ),
          BlocProvider(
            create: (context) =>
                AddTodoCubit(TaskRepo(api: DioConsumer(dio: Dio()))),
>>>>>>> parent of 9029cf5 (d)
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
<<<<<<< HEAD
          initialRoute: DbAuthRepo.refreshToken == null
              ? Screens.entery_screen
              : Screens.home_screen,
=======
          initialRoute:
              is_login == null ? Screens.entery_screen : Screens.home_screen,
>>>>>>> parent of 9029cf5 (d)
          onGenerateRoute: app_router.generateRoute,
        ),
      ),
    );
  }
}
