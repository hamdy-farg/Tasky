import 'package:tasky/data/model/auth_model/login_model.dart';
import 'package:tasky/data/model/get_user_model.dart';

abstract class LoginEvent {
  const LoginEvent();
}

class AddUserLoginResponseEvent extends LoginEvent {
  final LoginResponseModel responce;
  const AddUserLoginResponseEvent(this.responce);
}

class AddUserGetDataEvent extends LoginEvent {
  final GetUserModel user;
  const AddUserGetDataEvent(this.user);
}
