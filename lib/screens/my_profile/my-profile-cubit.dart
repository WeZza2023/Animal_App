import 'package:animal_app/models/my_profile_model.dart';
import 'package:animal_app/network/api_constants.dart';
import 'package:animal_app/network/dio_helper.dart';
import 'package:animal_app/screens/my_profile/my-profile-state.dart';
import 'package:animal_app/shared_prefs/network.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class MyProfileCubit extends Cubit<MyProfileState> {
  MyProfileCubit() : super(InitialState());

  MyProfileModel? myProfileModel;

  Future<void> getMyProfile() async {
    emit(LoadingMyProfileState());
  await  DioHelper.getData(
            url: ApiConstants.myProfile, token: ApiConstants.userToken)
        .then((value)  {
      myProfileModel = MyProfileModel.fromJson(value.data);
      print(value.data);
      emit(SuccessMyProfileState(myProfileModel!));
    }).catchError((error) {
      emit(ErrorMyProfileState(error.toString()));
    });
  }

  Future<void> logout() async {
    CacheHelper.removeData(key: 'token');
    CacheHelper.removeData(key: 'id');
    CacheHelper.removeData(key: 'device_token');
    await FirebaseMessaging.instance.deleteToken();
    ApiConstants.deviceToken = null;
    print('Disconnected from FCM');
    emit(DeleteDeviceTokenState());
  }
}
