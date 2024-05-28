import 'package:animal_app/firebase_options.dart';
import 'package:animal_app/network/api_constants.dart';
import 'package:animal_app/network/dio_helper.dart';
import 'package:animal_app/network/firebase_service.dart';
import 'package:animal_app/network/payment_service/payment_cubit.dart';
import 'package:animal_app/screens/home/home-cubit.dart';
import 'package:animal_app/screens/home/home-screen.dart';
import 'package:animal_app/screens/login/login-cubit.dart';
import 'package:animal_app/screens/login/login_screen.dart';
import 'package:animal_app/screens/my_pets/my_adopted_screen.dart';
import 'package:animal_app/screens/my_profile/my-profile-screen.dart';
import 'package:animal_app/screens/my_ratings/my_ratings_screen.dart';
import 'package:animal_app/screens/notifications/notifications_screen.dart';
import 'package:animal_app/screens/signup/signup-cubit.dart';
import 'package:animal_app/screens/signup/signup_screen.dart';
import 'package:animal_app/screens/view_animal/view_animal_screen.dart';
import 'package:animal_app/shared_prefs/network.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_localizations/flutter_localizations.dart';

import 'generated/l10n.dart';
import 'screens/my_adopted/my_pets_cubit.dart';
import 'screens/my_adopted/my_pets_screen.dart';
import 'screens/my_profile/my-profile-cubit.dart';
import 'screens/notifications/notifications_cubit.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  DioHelper.init();
  await CacheHelper.init();
  String initialId = HomeScreen.id;
 await FCMService().initialize();

  try {
    ApiConstants.userToken = CacheHelper.getData(key: 'token');
    ApiConstants.userId = CacheHelper.getData(key: 'id');
    ApiConstants.deviceToken = CacheHelper.getData(key: 'device_token');
  } catch (e) {
    print(e.toString());
    ApiConstants.userToken = "";
    ApiConstants.userId = "";
  }
  print(ApiConstants.userToken);
  print(ApiConstants.userId);
  print(ApiConstants.deviceToken);

  if (ApiConstants.userToken == "") {
    initialId = LoginScreen.id;
  } else {
    initialId = HomeScreen.id;
  }
  runApp(AnimalApp(
    initialId: initialId,
  ));
}

class AnimalApp extends StatelessWidget {
  const AnimalApp({super.key, this.initialId});
  final String? initialId;
  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        // BlocProvider<PaymentCubit>(create: (context) => PaymentCubit()),
        BlocProvider<LoginCubit>(create: (context) => LoginCubit()),
        BlocProvider<SignupCubit>(create: (context) => SignupCubit()),
        BlocProvider<HomeCubit>(create: (context) => HomeCubit()),
        BlocProvider<MyProfileCubit>(create: (context) => MyProfileCubit()),
        BlocProvider<NotificationsCubit>(create: (context) => NotificationsCubit()),
        BlocProvider<MyPetsCubit>(create: (context) => MyPetsCubit())
      ],
      child: MaterialApp(
        locale: const Locale('ar'),
        localizationsDelegates: const [
          S.delegate,
          GlobalMaterialLocalizations.delegate,
          GlobalWidgetsLocalizations.delegate,
          GlobalCupertinoLocalizations.delegate,
        ],
        supportedLocales: S.delegate.supportedLocales,
        theme: ThemeData(fontFamily: "Almarai"),
        debugShowCheckedModeBanner: false,
        routes: {
          LoginScreen.id: (context) => LoginScreen(),
          SignupScreen.id: (context) => SignupScreen(),
          HomeScreen.id: (context) => const HomeScreen(),
          MyProfileScreen.id: (context) =>  MyProfileScreen(),
          MyAdoptedAnimalScreen.id: (context) => const MyAdoptedAnimalScreen(),
          MyPetsAnimalScreen.id: (context) => const MyPetsAnimalScreen(),
          MyRatingsScreen.id: (context) => const MyRatingsScreen(),
          NotificationsScreen.id: (context) => const NotificationsScreen(),
        },
        initialRoute: initialId,
      ),
    );
  }
}
