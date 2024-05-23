import 'package:animal_app/models/get_notifications_model.dart';
import 'package:animal_app/network/api_constants.dart';
import 'package:animal_app/network/dio_helper.dart';
import 'package:animal_app/screens/notifications/notifications_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class NotificationsCubit extends Cubit<NotificationsState> {
  NotificationsCubit() : super(NotificationsInitial());







}