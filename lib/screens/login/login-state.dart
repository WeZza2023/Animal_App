import 'package:animal_app/models/login_model.dart';

abstract class LoginState {}

class InitialState extends LoginState {}

class IsPassShowState extends LoginState {}

class LoginLoadingState extends LoginState {}

class LoginSuccessState extends LoginState {
  final LoginModel loginModel;

  LoginSuccessState(this.loginModel);
}

class LoginErrorState extends LoginState {
  final String error;
  LoginErrorState(this.error);
}

class GetDeviceTokenState extends LoginState{}

class DeleteDeviceTokenState extends LoginState{}

class StoreTokenLoadingState extends LoginState{}

class StoreTokenSuccessState extends LoginState{}

class StoreTokenErrorState extends LoginState{
  final String error;
  StoreTokenErrorState(this.error);
}