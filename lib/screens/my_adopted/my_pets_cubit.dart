import 'package:animal_app/models/get_my_animals_model.dart';
import 'package:animal_app/network/api_constants.dart';
import 'package:animal_app/network/dio_helper.dart';
import 'package:animal_app/screens/my_adopted/my_pets_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:logger/web.dart';

class MyPetsCubit extends Cubit<MyPetsState> {
  MyPetsCubit() : super(InitialMyPetsState());

  var logger = Logger();

  MyAnimalsModel? myAnimalsModel;

  Future<void> getMyPets() async {
    emit(GetMyPetsLoadingState());
    await DioHelper.getData(
            url: ApiConstants.getMyAnimals, token: ApiConstants.userToken)
        .then((value) {
      logger.d(value.data);
      myAnimalsModel = MyAnimalsModel.fromJson(value.data);
      emit(GetMyPetsSuccessState(myAnimalsModel!));
    }).catchError((error) {
      print(error.toString());
      print("Get My Pets Error");
      emit(GetMyPetsErrorState(error.toString()));
    });
  }
}
