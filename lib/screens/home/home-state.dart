import 'package:animal_app/models/get_animals_model.dart';
import 'package:animal_app/models/get_notifications_model.dart';
import 'package:animal_app/models/requests_model.dart';

abstract class HomeState {}

class InitialState extends HomeState {}

class IsTabChangedState extends HomeState {}

class IsNavChangedState extends HomeState {}

class ChangeOpacityPageState extends HomeState{}

class IsSearchBarShownState extends HomeState {}

class IsImagePickedState extends HomeState {}

class ClearPickedImagesState extends HomeState {}

class GetAnimalsLoadingState extends HomeState {}

class GetAnimalsSuccessState extends HomeState {
  final GetAnimalsModel getAnimalsModel;
  GetAnimalsSuccessState(this.getAnimalsModel);

}

class GetAnimalsErrorState extends HomeState {
  final String error;
  GetAnimalsErrorState (this.error);
}

class AddAnimalLoadingState extends HomeState {}

class AddAnimalSuccessState extends HomeState {}

class AddAnimalErrorState extends HomeState {
  final String error;
  AddAnimalErrorState (this.error);
}

class BuyAnimalLoadingState extends HomeState {}

class BuyAnimalSuccessState extends HomeState {

}

class BuyAnimalErrorState extends HomeState {
  final String error;
  BuyAnimalErrorState(this.error);
}

class SendNotificationLoadingState extends HomeState {}

class SendNotificationSuccessState extends HomeState {}

class SendNotificationErrorState extends HomeState {
  final String error;
  SendNotificationErrorState(this.error);
}

class GetRequestsLoadingState extends HomeState {}

class GetRequestsSuccessState extends HomeState {
  final GetRequestsModel getRequestsModel;

  GetRequestsSuccessState(this.getRequestsModel);
}

class GetRequestsErrorState extends HomeState {
  final String error;
  GetRequestsErrorState(this.error);
}

class GetNotificationsLoadingState extends HomeState {}

class GetNotificationsSuccessState extends HomeState {
  final GetNotificationsModel getNotificationsModel;

  GetNotificationsSuccessState(this.getNotificationsModel);
}

class GetNotificationsErrorState extends HomeState {
  final String error;
  GetNotificationsErrorState(this.error);
}

class ChangeCurrentPageState extends HomeState{}

class AcceptRequestLoadingState extends HomeState {}

class AcceptRequestSuccessState extends HomeState {}

class AcceptRequestErrorState extends HomeState {
  final String error;
  AcceptRequestErrorState(this.error);
}

class RejectRequestLoadingState extends HomeState {}

class RejectRequestSuccessState extends HomeState {}

class RejectRequestErrorState extends HomeState {
  final String error;
  RejectRequestErrorState(this.error);
}