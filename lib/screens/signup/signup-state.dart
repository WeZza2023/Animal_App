import 'package:animal_app/models/login_model.dart';
import 'package:animal_app/models/register_model.dart';
import 'package:animal_app/models/verfication_model.dart';
import 'package:animal_app/models/verify_model.dart';

abstract class SignupState {}

class InitialState extends SignupState {}

class IsPassShowState extends SignupState {}

class ChangeCountryCodeState extends SignupState {}

class ReSendTimerState extends SignupState {}

class ReSendTimerCancelState extends SignupState {}

class VerificationLoadingState extends SignupState {}

class VerificationModelSuccessState extends SignupState {
  final VerificationSuccessModel? verificationSuccessModel;

  VerificationModelSuccessState(this.verificationSuccessModel);
}

class VerificationModelErrorState extends SignupState {
  final VerificationErrorModel? verificationErrorModel;

  VerificationModelErrorState(this.verificationErrorModel);
}

class VerificationErrorState extends SignupState {
  final String error;
  VerificationErrorState(this.error);
}

class SignupLoadingState extends SignupState {}

class SignupSuccessState extends SignupState {
  // final VerificationModel verificationModel;
  // SignupSuccessState(this.verificationModel);
}

class SignupErrorState extends SignupState {
  final String error;
  SignupErrorState(this.error);

}

// class VerificationLoadingState extends SignupState {}
//
// class VerificationSuccessState extends SignupState {
//   final VerifyModel verifyModel;
//   VerificationSuccessState(this.verifyModel);
// }
//
// class VerificationErrorState extends SignupState {
//   final String error;
//   VerificationErrorState(this.error);
//
// }

class StoreTokenLoadingState extends SignupState{}

class StoreTokenSuccessState extends SignupState{}

class StoreTokenErrorState extends SignupState{
  final String error;
  StoreTokenErrorState(this.error);
}

class GetDeviceTokenState extends SignupState{}


