import 'package:animal_app/components/components.dart';
import 'package:animal_app/components/custom_texts.dart';
import 'package:animal_app/components/product_item.dart';
import 'package:animal_app/constants/constant_colors.dart';
import 'package:animal_app/constants/constant_sizes.dart';
import 'package:animal_app/enum/icons.dart';
import 'package:animal_app/extention/extetion.dart';
import 'package:animal_app/screens/home/home-cubit.dart';
import 'package:animal_app/screens/home/home-state.dart';
import 'package:animal_app/screens/view_animal/view_animal_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../generated/l10n.dart';

class RequestsLayout extends StatelessWidget {
  const RequestsLayout({super.key});

  @override
  Widget build(BuildContext context) {
    var cubit = BlocProvider.of<HomeCubit>(context);
    return BlocConsumer<HomeCubit, HomeState>(
      listener: (context, state) {
        if (state is GetRequestsLoadingState) {
          print("Loading");
        }
      },
      builder: (context, state) => cubit.getRequestsModel == null
          ? AppLoadingProgress().tP25
          : cubit.getRequestsModel!.data!.isEmpty
              ? Container(
                  height: AppSizes.getScreenHeight(context),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      BodyLargeText(S.of(context).youdidnotRequestanyAnimal),
                    ],
                  ))
              : Column(
                  children: [
                    state is GetRequestsLoadingState
                        ? AppLoadingProgress()
                        : Wrap(
                            spacing: 12,
                            children: [
                              for (int i = 0;
                                  i < cubit.getRequestsModel!.data!.length;
                                  i++)
                                InkWell(
                                  onTap: () {
                                    if (cubit.getRequestsModel!.data![i]
                                            .status ==
                                        "accepted") {
                                      showDialog(
                                        context: context,
                                        builder: (context) {
                                          return Container(
                                            child: AlertDialog(
                                              backgroundColor: Colors.white,
                                              content: SingleChildScrollView(
                                                child: Column(
                                                  children: [
                                                    Container(
                                                      decoration: BoxDecoration(
                                                        border:
                                                            const BorderDirectional(
                                                          bottom: BorderSide(
                                                              color:
                                                                  Colors.blue,
                                                              width: 2),
                                                          end: BorderSide(
                                                              color:
                                                                  Colors.blue,
                                                              width: 2),
                                                        ),
                                                        borderRadius:
                                                            BorderRadius
                                                                .circular(30),
                                                        color:
                                                            Color(0xffEEEBF5),
                                                        // boxShadow: [
                                                        //   BoxShadow(
                                                        //       color: Colors.grey.withOpacity(0.5),
                                                        //       blurRadius: 3,
                                                        //       spreadRadius: 1),
                                                        // ],
                                                      ),
                                                      child: Row(
                                                        mainAxisAlignment:
                                                            MainAxisAlignment
                                                                .spaceBetween,
                                                        children: [
                                                          const Column(
                                                            crossAxisAlignment:
                                                                CrossAxisAlignment
                                                                    .center,
                                                            children: [
                                                              BodyExtraLargeText(
                                                                "200\$",
                                                                color: Colors
                                                                    .orange,
                                                                weight:
                                                                    FontWeight
                                                                        .bold,
                                                              ),
                                                              BodyMediumText(
                                                                "لاكمال عملية الاستلام",
                                                                color:
                                                                    KMaintextColor,
                                                              ),
                                                              BodyMediumText(
                                                                "قم باكمال عملية",
                                                                color:
                                                                    KMaintextColor,
                                                              ),
                                                              BodyMediumText(
                                                                "الدفع, سوف يتم",
                                                                color:
                                                                    KMaintextColor,
                                                              ),
                                                              BodyMediumText(
                                                                "خصم 200 ر.س",
                                                                color:
                                                                    KMaintextColor,
                                                              ),
                                                              BodyMediumText(
                                                                "من حسابك.",
                                                                color:
                                                                    KMaintextColor,
                                                              ),
                                                            ],
                                                          ),
                                                          Column(
                                                            children: [
                                                              Image.asset(
                                                                "assets/images/paylink_logo.png",
                                                                scale: 2.5,
                                                              ),
                                                            ],
                                                          ),
                                                        ],
                                                      ).p16,
                                                    ),
                                                  ],
                                                ).tP16,
                                              ),
                                              shape: RoundedRectangleBorder(
                                                borderRadius:
                                                    BorderRadius.circular(20),
                                              ),
                                              title: Container(
                                                  width:
                                                      AppSizes.getScreenWidth(
                                                          context),
                                                  decoration:
                                                      const BoxDecoration(
                                                    boxShadow: [
                                                      BoxShadow(
                                                        color: Colors.grey,
                                                        blurRadius: 15,
                                                        spreadRadius: 1,
                                                      )
                                                    ],
                                                    color: KDefaultColor,
                                                    borderRadius:
                                                        BorderRadius.vertical(
                                                            top:
                                                                Radius.circular(
                                                                    20)),
                                                  ),
                                                  child: Center(
                                                    child:  BodyMediumText(
                                                      S.of(context).toCompleteYourOrderPleaseDoThePaymentProcess,
                                                      color: Colors.white,
                                                    ).p8,
                                                  )),
                                              titlePadding:
                                                  const EdgeInsets.all(0),
                                              actions: [
                                                defaultTextButton(
                                                  text: S.of(context).purchaseNow,
                                                  function: () {},
                                                )
                                              ],
                                            ),
                                          );
                                        },
                                      );
                                    } else if (cubit.getRequestsModel!.data![i]
                                            .status ==
                                        "refused") {
                                      ScaffoldMessenger.of(context)
                                          .showSnackBar(AppSnackBar(
                                              content: S.of(context).thisOrderIsRefused,
                                              color: Colors.red));
                                    } else if (cubit.getRequestsModel!.data![i]
                                            .status ==
                                        "pending") {
                                      ScaffoldMessenger.of(context)
                                          .showSnackBar(AppSnackBar(
                                              content: S.of(context).thisOrderIsPending,
                                              color: Colors.orange));
                                    }
                                  },
                                  child: OrdersItem(
                                      image: cubit.getRequestsModel!.data![i]
                                                  .animal!.type ==
                                              'cat'
                                          ? ThemeImageIcon.cat
                                          : ThemeImageIcon.dog,
                                      color: cubit.getRequestsModel!.data![i]
                                                  .status ==
                                              "pending"
                                          ? Colors.yellow
                                          : cubit.getRequestsModel!.data![i]
                                                      .status ==
                                                  "refused"
                                              ? Colors.red
                                              : Colors.green,
                                      status: cubit
                                          .getRequestsModel!.data![i].status!,
                                      location: cubit.getRequestsModel!.data![i]
                                          .animal!.location!,
                                      time: cubit.getRequestsModel!.data![i]
                                          .getDuration(context),
                                      name: cubit.getRequestsModel!.data![i]
                                          .animal!.title!,
                                      onRatingUpdate: (rating) {
                                        print(rating);
                                      }),
                                ),
                            ],
                          ),
                  ],
                ),
    );
  }
}
