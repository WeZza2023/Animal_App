import 'package:animal_app/models/country_code_model.dart';
import 'package:animal_app/models/login_model.dart';
import 'package:animal_app/models/register_model.dart';
import 'package:animal_app/models/verify_model.dart';
import 'package:animal_app/network/api_constants.dart';
import 'package:animal_app/network/dio_helper.dart';
import 'package:animal_app/screens/signup/signup-state.dart';
import 'package:animal_app/shared_prefs/network.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:url_launcher/url_launcher_string.dart';

class SignupCubit extends Cubit<SignupState> {
  SignupCubit() : super(InitialState());

  bool isPass = true;
  IconData passIcon = Icons.remove_red_eye;
  String countryCode = '-  -';
  late RegisterModel registerModel;
  late VerifyModel verifyModel;

  isPassShow() {
    isPass = !isPass;
    passIcon = isPass ? Icons.remove_red_eye : Icons.visibility_off;
    emit(IsPassShowState());
  }

  void changeCountryCode({required String code}) {
    countryCode = code;
    emit(ChangeCountryCodeState());
  }

  Future<void> userRegister({
    required String name,
    required String email,
    required String password,
    required String phone,
  }) async {
    emit(SignupLoadingState());

    DioHelper.postData(url: ApiConstants.register, data: {
      'name': name,
      'email': email,
      'phone': "$countryCode $phone",
      'password': password,
    }).then((value) async {
      print(value.data);
      registerModel = RegisterModel.fromJson(value.data);
      print("USER REGISTERED SUCCESSFULLY");
      emit(SignupSuccessState(
        registerModel,
      ));
      verifyUser().then((value) {

      });
    }).catchError((error) {
      print(error.toString());
      print("USER REGISTER FAILED");
      emit(SignupErrorState(error.toString()));
    });
  }

  Future<void> verifyUser() async {
    emit(VerificationLoadingState());

    DioHelper.getWhatsappAuth(
      url: ApiConstants.verify,
      token: "B_j_S6rabuUngRyQOlQto4IB8dJD0plj",
    ).then((value) {
      print(value.data);
      verifyModel = VerifyModel.fromJson(value.data);
      emit(VerificationSuccessState(verifyModel));
    }).catchError((error) {
      print(error.toString());
      print("USER VERIFICATION FAILED");
      emit(VerificationErrorState(error.toString()));
    });
  }

  void openVerifyLink(Uri url) async {
    if (await canLaunchUrl(url)) {
      await launchUrl(url);
    } else {
      throw "Could not launch $url";
    }
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

