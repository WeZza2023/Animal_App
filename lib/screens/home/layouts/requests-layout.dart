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
          if (state is GetRequestsSuccessState) {
            // cubit.getRequestsModel = state.getRequestsModel;
          }
        },
        builder: (context, state) => state is GetRequestsLoadingState ||
                cubit.getRequestsModel == null
            ?  Center(
                child:AppLoadingProgress()).tP25
            : cubit.getRequestsModel!.data!.isEmpty
                ? Container(
                    height: AppSizes.getScreenHeight(context),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        BodyLargeText(S.of(context).youdidnotRequestanyAnimal),
                      ],
                    ))
                : Wrap(spacing: 12, children: [
                    for (int i = 0;
                        i < cubit.getRequestsModel!.data!.length;
                        i++)
                      OrdersItem(
                          image:
                              cubit.getRequestsModel!.data![i].animal!.type ==
                                      'cat'
                                  ? ThemeImageIcon.cat
                                  : ThemeImageIcon.dog,
                          color: cubit.getRequestsModel!.data![i].status ==
                                  "pending"
                              ? Colors.yellow
                              : cubit.getRequestsModel!.data![i].status ==
                                      "rejected"
                                  ? Colors.red
                                  : cubit.getRequestsModel!.data![i].status ==
                                          "accepted"
                                      ? Colors.green
                                      : Colors.blue,
                          status: cubit.getRequestsModel!.data![i].status!,
                          location: cubit
                              .getRequestsModel!.data![i].animal!.location!,
                          time: cubit.getRequestsModel!.data![i].getDuration(),
                          name: cubit.getRequestsModel!.data![i].animal!.title!,
                          onRatingUpdate: (rating) {
                            print(rating);
                          }),
                  ]));
  }
}
