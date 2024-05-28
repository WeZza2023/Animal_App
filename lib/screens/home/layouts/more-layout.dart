import 'package:animal_app/components/components.dart';
import 'package:animal_app/extention/extetion.dart';
import 'package:animal_app/screens/home/home-cubit.dart';
import 'package:animal_app/screens/login/login_screen.dart';
import 'package:animal_app/screens/my_adopted/my_pets_cubit.dart';
import 'package:animal_app/screens/my_adopted/my_pets_screen.dart';
import 'package:animal_app/screens/my_pets/my_adopted_screen.dart';
import 'package:animal_app/screens/my_ratings/my_ratings_screen.dart';
import 'package:animal_app/shared_prefs/network.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../generated/l10n.dart';

class MoreLayout extends StatelessWidget {
  const MoreLayout({super.key});

  @override
  Widget build(BuildContext context) {
    var homeCubit = BlocProvider.of<HomeCubit>(context);
    var myPetsCubit = BlocProvider.of<MyPetsCubit>(context);
    return Column(
      children: [
        MoreItem(title: S.of(context).myPets,icon: Icons.pets_rounded,onTap: (){
          homeCubit.getRequests();
          Navigator.pushNamed(context, MyAdoptedAnimalScreen.id);
        }).tP8,
        MoreItem(title: S.of(context).myAdoptedAnimals,icon: Icons.pets_rounded,onTap: (){
          myPetsCubit.getMyPets();
          Navigator.pushNamed(context, MyPetsAnimalScreen.id);
        }),
        MoreItem(title: S.of(context).myRatings,icon: Icons.star,onTap: (){
          Navigator.pushNamed(context, MyRatingsScreen.id);
        }),
        MoreItem(title: S.of(context).help,icon: Icons.help_rounded,onTap: (){}),
        MoreItem(title: S.of(context).commonQuestions,icon: Icons.info_rounded,onTap: (){}),
        MoreItem(title: S.of(context).contactUs,icon: Icons.call,onTap: (){}),

      ],
    );
  }
}
