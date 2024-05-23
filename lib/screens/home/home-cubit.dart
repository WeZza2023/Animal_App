import 'package:animal_app/enum/icons.dart';
import 'package:animal_app/generated/l10n.dart';
import 'package:animal_app/models/get_animals_model.dart';
import 'package:animal_app/models/get_notifications_model.dart';
import 'package:animal_app/network/api_constants.dart';
import 'package:animal_app/network/dio_helper.dart';
import 'package:animal_app/screens/home/layouts/add-animal-layout.dart';
import 'package:animal_app/screens/home/layouts/discover-layout.dart';
import 'package:animal_app/screens/home/layouts/home-layout.dart';
import 'package:animal_app/screens/home/layouts/more-layout.dart';
import 'package:animal_app/screens/home/layouts/requests-layout.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';
import 'package:logger/web.dart';
import '../../constants/constant_colors.dart';
import '../../models/requests_model.dart';
import 'home-state.dart';

class HomeCubit extends Cubit<HomeState> {
  HomeCubit() : super(InitialState());

  var logger = Logger();

  int currentTabIndex = 0;
  int currentNavIndex = 0;
  int currentPage = 1;
  bool isSearcBarShown = false;
  List<XFile> pickedImages = [];
  List<MultipartFile> imageFiles = [];
  ImagePicker picker = ImagePicker();
  GetAnimalsModel? getAnimalsModel;
  GetRequestsModel? getRequestsModel;
  GetNotificationsModel? getNotificationsModel;
  String filterAnimals = '';
  double itemOpacity = 1;

  List<Widget> layouts = [
    const HomeLayout(),
    const RequestsLayout(),
    AddAnimalLayout(),
    const DiscoverLayout(),
    const MoreLayout(),
  ];
  Color selectedTabTextColor = KMaintextColor;
  ThemeImageIcon selectedCatTabIcon = ThemeImageIcon.cat;
  ThemeImageIcon selectedDogTabIcon = ThemeImageIcon.dog;

  void ChangeBottomNavBar(int index) {
    currentNavIndex = index;

    if (currentNavIndex == 1) {
      getRequests();
    }
    emit(IsNavChangedState());
  }

  void onTabChanged(int index) {
    currentTabIndex = index;
    selectedTabTextColor = Colors.white;
    if (currentTabIndex == 0) {
      filterAnimals = '';
    }
    if (currentTabIndex == 1) {
      filterAnimals = 'cat';
    }
    if (currentTabIndex == 2) {
      filterAnimals = 'dog';
    }
    emit(IsTabChangedState());
  }

  Future<void> changeOpacity() async {
    itemOpacity = 0;
    await Future.delayed(Duration(milliseconds: 400)).then((value) {
      itemOpacity = 1;
    });
    emit(ChangeOpacityPageState());
  }

  void changeSearchBar() {
    isSearcBarShown = !isSearcBarShown;
    emit(IsSearchBarShownState());
  }

  void pickImage() async {
    final List<XFile> images = await picker.pickMultiImage();
    if (images.isNotEmpty) {
      pickedImages.addAll(images);
    }
    // pickedImages = images;
    // for (var image in pickedImages) {
    //   final multipartFile = await MultipartFile.fromFile(image.path, filename: image.name);
    //   print(multipartFile.filename);
    //   imageFiles.add(multipartFile);
    //   print(imageFiles);
    // }
    print(imageFiles);
    emit(IsImagePickedState());
  }

  void clearPickedImages() {
    pickedImages.clear();
    imageFiles.clear();
    emit(ClearPickedImagesState());
  }

  void getAnimals({required int currentPage}) {
    emit(GetAnimalsLoadingState());
    DioHelper.getData(
            url: "${ApiConstants.animal}?page=$currentPage",
            token: ApiConstants.userToken)
        .then((value) {
      logger.d(value.data);
      getAnimalsModel = GetAnimalsModel.fromJson(value.data);
      emit(GetAnimalsSuccessState(getAnimalsModel!));
    }).catchError((error) {
      logger.d(error.toString());
      emit(GetAnimalsErrorState(error.toString()));
    });
  }

  Future<void> addAnimal({
    required String name,
    required String type,
    required String gender,
    required String location,
    required String age,
    required String reason,
  }) async {
    print(imageFiles);
    emit(AddAnimalLoadingState());
    for (var image in pickedImages) {
      final multipartFile =
          await MultipartFile.fromFile(image.path, filename: image.name);
      imageFiles.add(multipartFile);
    }
    Map<String, dynamic> json = {
      'title': name,
      'type': type,
      'sex': gender,
      'location': location,
      'age': age,
      'adapt_reason': reason,
      'images': imageFiles,
    };
    print(json);
    DioHelper.postData(
      url: ApiConstants.addAnimal,
      token: ApiConstants.userToken,
      data: FormData.fromMap(json),
      onSendProgress: (int sent, int total) {
        logger.d("$sent / $total");
      },
    ).then((value) {
      logger.d(value.data);
      emit(AddAnimalSuccessState());
    }).catchError((error) {
      print(error.toString());
      print("ADD FAILED");
      emit(AddAnimalErrorState(error.toString()));
    });
  }

  Future<void> buyAnimal({
    required String animalId,
  }) async {
    emit(BuyAnimalLoadingState());
    DioHelper.postData(
      url: ApiConstants.buy,
      data: {
        'animal_id': animalId,
        'title': "some title",
        'body': "order to buy animal",
      },
      token: ApiConstants.userToken,
    ).then((value) async {
      print(value.data);
      emit(BuyAnimalSuccessState());
    }).catchError((error) {
      print(error.toString());
      print("BUY FAILED");
      emit(BuyAnimalErrorState(error.toString()));
    });
  }

  Future<void> getRequests() async {
    emit(GetRequestsLoadingState());
    DioHelper.getData(url: ApiConstants.requests, token: ApiConstants.userToken)
        .then((value) {
      logger.d(value.data);
      getRequestsModel = GetRequestsModel.fromJson(value.data);
      emit(GetRequestsSuccessState(getRequestsModel!));
    }).catchError((error) {
      print(error.toString());
      emit(GetRequestsErrorState(error.toString()));
    });
  }

  Future<void> getNotifications() async {
    emit(GetNotificationsLoadingState());
    await DioHelper.getData(
            url: ApiConstants.getNotifications, token: ApiConstants.userToken)
        .then((value) {
      print(value.data);
      print("Get Notifications Success");
      // getNotificationsModel = GetNotificationsModel.fromJson(value.data);
      emit(GetNotificationsSuccessState(getNotificationsModel!));
    }).catchError((error) {
      print(error.toString());
      print("Get Notifications Error");
      emit(GetNotificationsErrorState(error.toString()));
    });
  }

  Future<void> acceptRequest({
    required String orderId,
  }) async {
    emit(AcceptRequestLoadingState());
    DioHelper.postData(
        url: ApiConstants.accept,
        token: ApiConstants.userToken,
        data: {
          'order_id': orderId,
          'title': "some title",
          'body': "accept to buy animal",
        }).then((value) {
      print(value.data);
      print('Accept Request Success');
      emit(AcceptRequestSuccessState());
    }).catchError((error) {
      print(error.toString());
      print('Accept Request Failed');
      emit(AcceptRequestErrorState(error.toString()));
    });
  }

  Future<void> rejectRequest({required String orderId}) async {
    emit(AcceptRequestLoadingState());
    DioHelper.postData(
        url: ApiConstants.refuse,
        token: ApiConstants.userToken,
        data: {
          'order_id': orderId,
          'title': "some title",
          'body': "reject to buy animal",
        }).then((value) {
      print(value.data);
      print('Reject Request Success');
      emit(AcceptRequestSuccessState());
    }).catchError((error) {
      print(error.toString());
      print('Reject Request Failed');
      emit(AcceptRequestErrorState(error.toString()));
    });
  }
}
