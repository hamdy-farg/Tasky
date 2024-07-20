import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tasky/bussiness_logic/auth/cubit/auth_cubit.dart';
import 'package:tasky/bussiness_logic/get_user_bloc/get_user_bloc.dart';
import 'package:tasky/bussiness_logic/operation/add_todo/cubit/add_todo_cubit.dart';
import 'package:tasky/bussiness_logic/operation/profile/cubit/profile_cubit.dart';
import 'package:tasky/bussiness_logic/operation/todos/cubit/todo_cubit.dart';
import 'package:tasky/constants/Screens.dart';
import 'package:tasky/data/api/auth_api/dio_consumer.dart';
import 'package:tasky/data/repo/operation/auth_repo.dart';
import 'package:tasky/data/repo/operation/get_repo.dart';
import 'package:tasky/data/repo/operation/task_repo.dart';
import 'package:tasky/presentation/auth_screens/entry_screen.dart';
import 'package:tasky/presentation/auth_screens/login_screen.dart';
import 'package:tasky/presentation/auth_screens/register_screen.dart';
import 'package:tasky/presentation/operations_screens/add_new_task_screen.dart';
import 'package:tasky/presentation/operations_screens/main_screen.dart';
import 'package:tasky/presentation/operations_screens/profile_screen.dart';
import 'package:tasky/presentation/operations_screens/task_details_screen.dart';

class AppRouter {
  static List<dynamic> Route() {
    return [
      PageEntity(
        route: Screens.entery_screen,
        page: const EntryScreen(),
        bloc: BlocProvider(
          create: (context) =>
              AuthCubit(AuthRepo(api: DioConsumer(dio: Dio()))),
          child: Container(),
        ),
      ),
      PageEntity(
        route: Screens.login_screen,
        page: const LoginScreen(),
        bloc: BlocProvider(
          create: (context) =>
              ProfileCubit(GetRepo(api: DioConsumer(dio: Dio()))),
          child: Container(),
        ),
      ),
      PageEntity(
        route: Screens.register_screen,
        page: const RegisterScreen(),
        bloc: BlocProvider(
          create: (context) =>
              TodoCubit(taskRepo: TaskRepo(api: DioConsumer(dio: Dio()))),
          child: Container(),
        ),
      ),
      PageEntity(
          route: Screens.home_screen,
          page: const HomeScreen(),
          bloc: BlocProvider(
            create: (context) =>
                AddTodoCubit(TaskRepo(api: DioConsumer(dio: Dio()))),
            child: Container(),
          )),
      PageEntity(
        route: Screens.add_task_screen,
        page: const AddNewTaskScreen(),
        bloc: BlocProvider(
          create: (context) => GetUserBloc(),
          child: Container(),
        ),
      ),
      const PageEntity(
          route: Screens.task_details_screen, page: TaskDetailsScreen()),
      const PageEntity(route: Screens.profile_screen, page: ProfileScreen())
    ];
  }

  static List<dynamic> allBlocProviders(BuildContext context) {
    List<dynamic> blocProvider = <dynamic>[];
    for (var bloc in Route()) {
      if (bloc.bloc != null) {
        blocProvider.add(bloc.bloc);
      }
    }
    return blocProvider;
  }

  static MaterialPageRoute generateRoute(RouteSettings settings) {
    if (settings.name != null) {
      var result = Route().where((element) => element.route == settings.name);
      if (result.isNotEmpty) {
        return MaterialPageRoute(
            builder: (_) => result.first.page, settings: settings);
      }
    }
    return MaterialPageRoute(
        builder: (_) => const LoginScreen(), settings: settings);
  }
}

class PageEntity {
  final String route;
  final Widget page;
  final dynamic bloc;

  const PageEntity({required this.route, required this.page, this.bloc});
}
