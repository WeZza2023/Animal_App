import 'dart:async';

import 'package:animal_app/constants/constant_colors.dart';
import 'package:animal_app/models/country_code_model.dart';
import 'package:animal_app/models/login_model.dart';
import 'package:animal_app/models/register_model.dart';
import 'package:animal_app/models/verfication_model.dart';
import 'package:animal_app/models/verify_model.dart';
import 'package:animal_app/network/api_constants.dart';
import 'package:animal_app/network/dio_helper.dart';
import 'package:animal_app/screens/signup/signup-state.dart';
import 'package:animal_app/shared_prefs/network.dart';
import 'package:dio/dio.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:logger/logger.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:url_launcher/url_launcher_string.dart';

class SignupCubit extends Cubit<SignupState> {
  SignupCubit() : super(InitialState());

  bool isPass = true;
  IconData passIcon = Icons.remove_red_eye;
  String countryCode = '-  -';
  late RegisterModel registerModel;
  late VerifyModel verifyModel;
  late VerificationErrorModel verificationErrorModel;
  late VerificationSuccessModel verificationSuccessModel;
  bool canReSend = false;
  int reSendTime = 10;
  Timer? _timer;

  Logger logger = Logger();

  isPassShow() {
    isPass = !isPass;
    passIcon = isPass ? Icons.remove_red_eye : Icons.visibility_off;
    emit(IsPassShowState());
  }

  void changeCountryCode({required String code}) {
    countryCode = code;
    emit(ChangeCountryCodeState());
  }

  void reSendCounter() {
    _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      if (reSendTime == 0) {
        _timer!.cancel();
        reSendTime = 10;
        canReSend = true;
        emit(ReSendTimerCancelState());
      } else {
        reSendTime--;
        canReSend = false;
        emit(ReSendTimerState());
      }
    });
  }

  Future<void> userRegister({
    required String name,
    required String email,
    required String password,
    required String phone,
  }) async {
    emit(VerificationLoadingState());
    await DioHelper.postData(url: ApiConstants.register, data: {
      'name': name,
      'email': email,
      'phone': "$countryCode $phone",
      'password': password,
    }).then((value) {
      logger.d(value.data);
      if (value.data is Map) {
        print(value.data);
        verificationErrorModel = VerificationErrorModel.fromJson(value.data);
        emit(VerificationModelErrorState(verificationErrorModel));
      } else if (value.data is List) {
        print(value.data);
        verificationSuccessModel =
            VerificationSuccessModel.fromJson(value.data);
        emit(VerificationModelSuccessState(verificationSuccessModel));
      }
    }).catchError((error) {
      print(error.toString());
      print("USER REGISTER FAILED");
      emit(VerificationErrorState(error.toString()),);
    });
  }



  Future<void> isVerifiedUser({
    required String email,
  }) async {
    emit(SignupLoadingState());
    await DioHelper.postData(url: ApiConstants.resend, data: {
      'email': email,
    }).then((value) {
      print(value.data);
      // verifyModel = VerifyModel.fromJson(value.data);
      emit(SignupSuccessState());
    }).catchError((error) {
      print(error.toString());
      print("USER VERIFICATION FAILED");
      emit(SignupErrorState(error.toString()));
    });
  }



  // Future<void> verifyUser() async {
  //   emit(VerificationLoadingState());
  //
  //   DioHelper.getWhatsappAuth(
  //     url: ApiConstants.verify,
  //     token: "B_j_S6rabuUngRyQOlQto4IB8dJD0plj",
  //   ).then((value) {
  //     print(value.data);
  //     verifyModel = VerifyModel.fromJson(value.data);
  //     emit(VerificationSuccessState(verifyModel));
  //   }).catchError((error) {
  //     print(error.toString());
  //     print("USER VERIFICATION FAILED");
  //     emit(VerificationErrorState(error.toString()));
  //   });
  // }

  void openVerifyLink(Uri url) async {
    if (await canLaunchUrl(url)) {
      await launchUrl(url);
    } else {
      throw "Could not launch $url";
    }
  }

  Future<void> storeToken({
    required String? token,
  }) async {
    emit(StoreTokenLoadingState());
    await DioHelper.postData(
        url: ApiConstants.storeToken,
        token: ApiConstants.userToken,
        data: {
          'device_token': token,
        }).then((value) {
      print(value.data);
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
