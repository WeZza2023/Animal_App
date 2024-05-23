import 'package:animal_app/components/components.dart';
import 'package:animal_app/components/custom_texts.dart';
import 'package:animal_app/constants/constant_colors.dart';
import 'package:animal_app/constants/constant_sizes.dart';
import 'package:animal_app/extention/extetion.dart';
import 'package:animal_app/generated/l10n.dart';
import 'package:animal_app/network/api_constants.dart';
import 'package:animal_app/screens/home/home-cubit.dart';
import 'package:animal_app/screens/home/home-state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ViewAnimalScreen extends StatelessWidget {
  const ViewAnimalScreen({super.key, required this.outIndex,required this.isNotification});
  static String id = 'ViewAnimalScreen';
  final int outIndex;
  final bool isNotification;

  @override
  Widget build(BuildContext context) {
    var cubit = BlocProvider.of<HomeCubit>(context);
    return BlocConsumer<HomeCubit, HomeState>(
      listener: (context, state) {},
      builder: (context, state) => Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.transparent,
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
            child: Column(
              children: [
                const SizedBox(
                  height: 20,
                ),
                Column(
                  children: [
                    ViewAnimalItem(
                      text: cubit
                          .getAnimalsModel!.data!.animals![outIndex].title
                          .toString(),
                    ),
                    ViewAnimalItem(
                      text: cubit.getAnimalsModel!.data!.animals![outIndex].type
                          .toString(),
                    ),
                    ViewAnimalItem(
                      text: cubit.getAnimalsModel!.data!.animals![outIndex].sex
                          .toString(),
                    ),
                    ViewAnimalItem(
                      text: cubit.getAnimalsModel!.data!.animals![outIndex].age
                          .toString(),
                    ),
                    ViewAnimalItem(
                      text: cubit
                          .getAnimalsModel!.data!.animals![outIndex].location
                          .toString(),
                    ),
                    ViewAnimalItem(
                      height: 200,
                      text: cubit
                          .getAnimalsModel!.data!.animals![outIndex].adaptReason
                          .toString(),
                    ),
                    Container(
                      decoration: BoxDecoration(
                        boxShadow: [
                          BoxShadow(
                            color: Colors.grey.withOpacity(0.5),
                            spreadRadius: 3,
                            blurRadius: 5,
                            offset: const Offset(0, 3),
                          )
                        ],
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: Column(
                        children: [
                          Container(
                            decoration: BoxDecoration(
                              boxShadow: [
                                BoxShadow(
                                  color: Colors.grey.withOpacity(0.5),
                                  spreadRadius: 2,
                                  blurRadius: 5,
                                  offset: const Offset(0, 3),
                                )
                              ],
                              borderRadius: const BorderRadius.only(
                                  topRight: Radius.circular(12),
                                  topLeft: Radius.circular(12)),
                              color: KDefaultColor,
                            ),
                            child: Stack(
                              children: [
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    BodyMediumText(
                                      S.of(context).photos,
                                      color: Colors.white,
                                      weight: FontWeight.bold,
                                    ).p16,
                                  ],
                                ),
                              ],
                            ),
                          ),
                          Container(
                            height: 100,
                            child: cubit.getAnimalsModel!.data!
                                    .animals![outIndex].images!.isEmpty
                                ? InkWell(
                                    onTap: () {},
                                    child: const Center(
                                        child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: [
                                        Icon(Icons.no_photography_outlined),
                                        SizedBox(width: 10),
                                        Text("No photos added"),
                                      ],
                                    )).p8,
                                  )
                                : ListView.builder(
                                    scrollDirection: Axis.horizontal,
                                    itemBuilder: (context, index) {
                                      return Container(
                                          constraints: const BoxConstraints(
                                            maxHeight: 80,
                                            minHeight: 70,
                                            minWidth: 90,
                                            maxWidth: 100,
                                          ),
                                          decoration: BoxDecoration(
                                            color: Colors.white,
                                            borderRadius:
                                                BorderRadius.circular(12),
                                            boxShadow: [
                                              BoxShadow(
                                                color: Colors.grey
                                                    .withOpacity(0.5),
                                                spreadRadius: 0,
                                                blurRadius: 4,
                                              ),
                                            ],
                                          ),
                                          child: Image.network(
                                            "${ApiConstants.baseUrlNOAPI}storage/${cubit.getAnimalsModel!.data!.animals![outIndex].images![index].path}",
                                            fit: BoxFit.fill,
                                            height: 90,
                                            width: 90,
                                            errorBuilder: (context, error,
                                                    stackTrace) =>
                                                AppLoadingProgress(),
                                          )).p(12);
                                    },
                                    itemCount: cubit.getAnimalsModel!.data!
                                        .animals![outIndex].images!.length,
                                  ),
                          )
                        ],
                      ),
                    ).hP16.vP16,
                    if (isNotification == false)
                    state is BuyAnimalLoadingState
                        ?  AppLoadingProgress().bP16
                        : defaultTextButton(
                            function: () {
                              cubit.buyAnimal(
                                  animalId: cubit.getAnimalsModel!.data!
                                      .animals![outIndex].id);
                            },
                            text: S.of(context).askForAdoption,
                            color: KselectedTabColor,
                            width: AppSizes.getScreenWidth(context),
                          ).bP16.hP16,
                    if (isNotification == true)
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          state is AcceptRequestLoadingState
                            ? const CircularProgressIndicator(
                                color: KDefaultColor,
                              ).bP16
                            : defaultTextButton(
                                function: () {
                                  cubit.acceptRequest(
                                      orderId: "5");
                                      // cubit.getNotificationsModel!.data!
                                      //     .animals![outIndex].id);
                                },
                                text: S.of(context).accept,
                            width: AppSizes.getScreenWidth(context)* 0.35,
                                color: KselectedTabColor,
                              ),

                          state is RejectRequestLoadingState
                              ? const CircularProgressIndicator(
                            color: KDefaultColor,
                          ).bP16
                              : defaultTextButton(
                            hasBorder: true,
                            function: () {
                              cubit.acceptRequest(
                                  orderId:"5");
                                  // cubit.getNotificationsModel!.data!
                                  //     .animals![outIndex].id);
                            },
                            text: S.of(context).reject,
                            color: Colors.white,
                            borderColor: Colors.red,
                            width: AppSizes.getScreenWidth(context)* 0.35,
                            textColor: Colors.red,
                          ),
                        ],
                      ).bP16,
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}