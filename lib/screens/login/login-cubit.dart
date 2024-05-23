import 'package:animal_app/network/api_constants.dart';
import 'package:animal_app/network/dio_helper.dart';
import 'package:animal_app/screens/login/login-state.dart';
import 'package:animal_app/shared_prefs/network.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../models/login_model.dart';

class LoginCubit extends Cubit<LoginState> {
  LoginCubit() : super(InitialState());

 bool isPass = true;
 IconData passIcon = Icons.remove_red_eye;
  late LoginModel loginModel;



  isPassShow(){
   isPass = !isPass;
   passIcon = isPass ? Icons.remove_red_eye : Icons.visibility_off;
   emit(IsPassShowState());
 }

  Future<void> userLogin({
    required String email,
    required String password,
  }) async {
    emit(LoginLoadingState());

    DioHelper.postData(url: ApiConstants.login, data: {
      'email': email,
      'password': password,
    }).then((value) async {
      print(value.data);
      loginModel = LoginModel.fromJson(value.data);
      print("USER LOGIN SUCCESSFULLY");
      emit(LoginSuccessState(loginModel));
      // await getDeviceToken();
    }).catchError((error) {
      print(error.toString());
      print("USER LOGIN FAILED");
      emit(LoginErrorState(error.toString()));
    });
  }

  Future<void> storeToken({
   required String? token,
  }) async
  {
    emit(StoreTokenLoadingState());
    await DioHelper.postData(url: ApiConstants.storeToken, token: ApiConstants.userToken, data: {
      'device_token': token,
    }
    ).then((value) {
      print(value.data);
      print("STORE TOKEN SUCCESSFULLY");
      emit(StoreTokenSuccessState());
    }).catchError((error) {
      print(error.toString());
      print("STORE TOKEN FAILED");
      emit(StoreTokenErrorState(error.toString()));
    });
  }

  Future<void> getDeviceToken() async {
    ApiConstants.deviceToken = await FirebaseMessaging.instance.getToken();
    CacheHelper.saveData(
      key: 'device_token',
      value: ApiConstants.deviceToken.toString(),
    );
    print(ApiConstants.deviceToken);
    emit(GetDeviceTokenState());
  }

}