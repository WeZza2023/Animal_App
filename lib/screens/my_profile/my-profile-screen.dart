import 'package:animal_app/components/components.dart';
import 'package:animal_app/constants/constant_colors.dart';
import 'package:animal_app/constants/constant_sizes.dart';
import 'package:animal_app/extention/extetion.dart';
import 'package:animal_app/generated/l10n.dart';
import 'package:animal_app/models/login_model.dart';
import 'package:animal_app/screens/login/login_screen.dart';
import 'package:animal_app/screens/my_profile/my-profile-cubit.dart';
import 'package:animal_app/screens/my_profile/my-profile-state.dart';
import 'package:animal_app/shared_prefs/network.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class MyProfileScreen extends StatelessWidget {
  MyProfileScreen({super.key});
  static String id = 'MyProfileScreen';

  @override
  Widget build(BuildContext context) {
    var cubit = BlocProvider.of<MyProfileCubit>(context);
    return BlocConsumer<MyProfileCubit, MyProfileState>(
      listener: (context, state) {
        if (state is SuccessMyProfileState) {}
      },
      builder: (context, state) => Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.transparent,
          actions: [
            IconButton(
                onPressed: () {},
                icon: const Icon(
                  Icons.search_rounded,
                  color: Colors.white,
                )),
            IconButton(
                onPressed: () {},
                icon: const Icon(
                  Icons.notifications_none_rounded,
                  color: Colors.white,
                )),
          ],
          leading: InkWell(
            onTap: () {
              Navigator.pop(context);
            },
            child: const Icon(
              Icons.cancel,
              color: Colors.white,
              size: 30,
            ),
          ),
        ),
        backgroundColor: KDefaultColor,
        body: Container(
          constraints: BoxConstraints(
            minHeight: AppSizes.getScreenHeight(context),
          ),
          decoration: const BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(20),
              topRight: Radius.circular(20),
            ),
          ),
          width: AppSizes.getScreenWidth(context),
          child: SingleChildScrollView(
              child: state is LoadingMyProfileState ||
                      cubit.myProfileModel == null
                  ? Center(child: AppLoadingProgress()).tP25
                  : Column(
                      children: [
                        const SizedBox(
                          height: 20,
                        ),
                        AppDivider(
                                categoryName: "حسابك ذهبي",
                                color: Colors.yellow)
                            .bP16,
                        Container(
                          decoration: const BoxDecoration(
                            color: Colors.white,
                            border: BorderDirectional(
                                start:
                                    BorderSide(width: 2, color: Colors.yellow),
                                end: BorderSide(width: 2, color: Colors.yellow),
                                bottom:
                                    BorderSide(width: 2, color: Colors.yellow)),
                            borderRadius: BorderRadius.all(
                              Radius.circular(20),
                            ),
                          ),
                          child: Column(
                            children: [
                              MoreItem(
                                      title:
                                          "${S.of(context).name} : ${cubit.myProfileModel!.data!.name}",
                                      onTap: () {})
                                  .tP8,
                              MoreItem(
                                  title:
                                      "${S.of(context).id} : ${cubit.myProfileModel!.data!.id} ",
                                  onTap: () {}),
                              MoreItem(
                                  title:
                                      "${S.of(context).email} : ${cubit.myProfileModel!.data!.email}",
                                  onTap: () {}),
                              MoreItem(
                                      title:
                                          "${S.of(context).phone} : ${cubit.myProfileModel!.data!.phone}",
                                      onTap: () {})
                                  .bP25,

                              // MoreItem(title: "${S.of(context).myPets} : ", onTap: () {}),
                              // MoreItem(
                              //     title: "${S.of(context).myAdoptedAnimals} : ",
                              //     onTap: () {})
                              //     .bP25,
                              defaultTextButton(
                                  text: S.of(context).logout,
                                  function: () {
                                    cubit.logout();
                                    Navigator.pushReplacementNamed(
                                        context, LoginScreen.id);
                                  }).hP16.bP8
                            ],
                          ),
                        ).hP16
                      ],
                    )),
        ),
      ),
    );
  }
}
