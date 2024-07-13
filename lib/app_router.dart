import 'package:flutter/material.dart';
import 'package:tasky/constants/Screens.dart';
import 'package:tasky/presentation/auth_screens/entry_screen.dart';
import 'package:tasky/presentation/auth_screens/login_screen.dart';
import 'package:tasky/presentation/auth_screens/register_screen.dart';
import 'package:tasky/presentation/operations_screens/add_new_task_screen.dart';
import 'package:tasky/presentation/operations_screens/main_screen.dart';
import 'package:tasky/presentation/operations_screens/profile_screen.dart';
import 'package:tasky/presentation/operations_screens/task_details_screen.dart';

class AppRouter {
  Route? generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case Screens.entery_screen:
        return MaterialPageRoute(builder: (_) => EntryScreen());
      case Screens.login_screen:
        return MaterialPageRoute(builder: (_) => LoginScreen());
      case Screens.register_screen:
        return MaterialPageRoute(builder: (_) => RegisterScreen());
      case Screens.home_screen:
        return MaterialPageRoute(builder: (_) => HomeScreen());
      case Screens.add_task_screen:
        return MaterialPageRoute(builder: (_) => AddNewTaskScreen());
      case Screens.task_details_screen:
        return MaterialPageRoute(builder: (_) => TaskDetailsScreen());
      case Screens.profile_screen:
        return MaterialPageRoute(builder: (_) => ProfileScreen());
    }
  }
}
