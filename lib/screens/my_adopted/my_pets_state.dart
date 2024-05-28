import 'package:animal_app/models/get_my_animals_model.dart';

abstract class MyPetsState {}

class InitialMyPetsState extends MyPetsState {}

class GetMyPetsLoadingState extends MyPetsState {}

class GetMyPetsSuccessState extends MyPetsState {
  final MyAnimalsModel myAnimalsModel;

  GetMyPetsSuccessState(this.myAnimalsModel);
}

class GetMyPetsErrorState extends MyPetsState {
  String error;
  GetMyPetsErrorState(this.error);
}
