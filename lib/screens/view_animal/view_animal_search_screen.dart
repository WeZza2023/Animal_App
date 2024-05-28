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

class ViewAnimalSearchScreen extends StatelessWidget {
  const ViewAnimalSearchScreen({
    super.key,
    required this.outIndex,
  });
  static String id = 'ViewAnimalSearchScreen';
  final int outIndex;

  @override
  Widget build(BuildContext context) {
    var cubit = BlocProvider.of<HomeCubit>(context);
    return BlocConsumer<HomeCubit, HomeState>(
      listener: (context, state) {
        if (state is BuyAnimalSuccessState) {
          Navigator.pop(context);
          ScaffoldMessenger.of(context).showSnackBar(AppSnackBar(
              content: S.of(context).yourRequestHasBeenSentSuccessfully,
              color: Colors.green));
        } else if (state is BuyAnimalErrorState) {
          ScaffoldMessenger.of(context).showSnackBar(
              AppSnackBar(content: state.error, color: Colors.red));
        }
      },
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
                      text: cubit.searchModel!.data![outIndex].title.toString(),
                    ),
                    ViewAnimalItem(
                      text: cubit.searchModel!.data![outIndex].type.toString(),
                    ),
                    ViewAnimalItem(
                      text: cubit.searchModel!.data![outIndex].sex.toString(),
                    ),
                    ViewAnimalItem(
                      text: cubit.searchModel!.data![outIndex].age.toString(),
                    ),
                    ViewAnimalItem(
                      text: cubit.searchModel!.data![outIndex].location
                          .toString(),
                    ),
                    ViewAnimalItem(
                      height: 200,
                      text: cubit.searchModel!.data![outIndex].adaptReason
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
                            child: cubit.searchModel!.data![outIndex].images!
                                    .isEmpty
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
                                          child: ClipRRect(
                                            borderRadius:
                                                BorderRadius.circular(12),
                                            child: Image.network(
                                              cubit.searchModel!.data![outIndex].images![index].path!,
                                              fit: BoxFit.fill,
                                              height: 90,
                                              width: 90,
                                              loadingBuilder: (context, child,
                                                      loadingProgress) {
                                                if (loadingProgress == null) return child;
                                                return AppLoadingProgress();
                                              },
                                              errorBuilder: (context, error,
                                                      stackTrace) =>
                                                  AppLoadingFailed(big: true),
                                            ),
                                          )).p(12);
                                    },
                                    itemCount: cubit.searchModel!
                                        .data![outIndex].images!.length,
                                  ),
                          )
                        ],
                      ),
                    ).hP16.vP16,
                    state is BuyAnimalLoadingState
                        ? AppLoadingProgress().bP16
                        : defaultTextButton(
                            function: () {
                              cubit.buyAnimal(
                                  animalId:
                                      "${cubit.searchModel!.data![outIndex].id}");
                            },
                            text: S.of(context).askForAdoption,
                            color: KselectedTabColor,
                            width: AppSizes.getScreenWidth(context),
                          ).bP16.hP16,
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
