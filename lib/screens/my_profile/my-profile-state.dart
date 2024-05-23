import 'package:animal_app/models/my_profile_model.dart';

abstract class MyProfileState {}

class InitialState extends MyProfileState {}

class LoadingMyProfileState extends MyProfileState {}

class SuccessMyProfileState extends MyProfileState {
  final MyProfileModel myProfileModel;
  SuccessMyProfileState(this.myProfileModel);
}

class ErrorMyProfileState extends MyProfileState {
  final String error;
  ErrorMyProfileState(this.error);
}

class DeleteDeviceTokenState extends MyProfileState{}