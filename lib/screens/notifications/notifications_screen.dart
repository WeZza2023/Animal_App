import 'package:animal_app/components/components.dart';
import 'package:animal_app/components/custom_texts.dart';
import 'package:animal_app/components/product_item.dart';
import 'package:animal_app/constants/constant_colors.dart';
import 'package:animal_app/constants/constant_sizes.dart';
import 'package:animal_app/extention/extetion.dart';
import 'package:animal_app/network/api_constants.dart';
import 'package:animal_app/screens/notifications/notifications_cubit.dart';
import 'package:animal_app/screens/notifications/notifications_state.dart';
import 'package:animal_app/screens/view_animal/view_animal_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class NotificationsScreen extends StatelessWidget {
  const NotificationsScreen({super.key});
  static String id = 'NotificationsScreen';

  @override
  Widget build(BuildContext context) {
    var cubit = BlocProvider.of<NotificationsCubit>(context);
    return BlocConsumer<NotificationsCubit, NotificationsState>(
      listener: (context, state) {},
      builder: (context, state) => Scaffold(
        appBar: AppBar(
            backgroundColor: Colors.transparent,
            actions: [
              Container(
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(20),
                    color: Colors.white),
                child: const Row(
                  children: [
                    BodyMediumText(
                      "الاشعارات",
                      color: KDefaultColor,
                      weight: FontWeight.bold,
                    ),
                    Icon(
                      Icons.notifications_none_rounded,
                      color: KDefaultColor,
                    ),
                  ],
                ).p8,
              ).p8,
            ],
            leading: IconButton(
              onPressed: () {
                Navigator.pop(context);
              },
              icon: const Icon(
                Icons.cancel,
                color: Colors.white,
                size: 30,
              ),
            )),
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
                AppDivider(
                        categoryName: "الاشعارات غير المقروءة 11",
                        color: Colors.grey)
                    .bP16,
                Wrap(spacing: 12, children: [
                  for (int i = 0;
                      i < 4;
                      // cubit.getNotificationsModel!.data!.animals!.length;
                      i++)
                    NotificationItem(
                      onTap: () {
                        Navigator.push(context, MaterialPageRoute(
                          builder: (context) {
                            return ViewAnimalScreen(
                              outIndex: i,
                              isNotification: true,
                            );
                          },
                        ));

                        // cubit.buyAnimal(
                        //     animalId: cubit
                        //         .getAnimalsModel!.data!.animals![i].id);
                        // print(ApiConstants.deviceToken);
                      },
                      time: '',
                      // cubit.getNotificationsModel!.data!.animals![i].type,
                      title: '',
                      // cubit.getNotificationsModel!.data!.animals![i].sex,
                      location: '',
                      // cubit
                      //     .getNotificationsModel!.data!.animals![i].location,

                      // cubit.getNotificationsModel!.data!.animals![i]
                      //     .images!.isEmpty
                      //     ? "https://static.vecteezy.com/system/resources/previews/004/968/529/original/search-no-results-found-concept-illustration-flat-design-eps10-simple-modern-graphic-element-for-landing-page-empty-state-ui-infographic-icon-with-editable-stroke-line-outline-linear-vector.jpg"
                      //     : "${ApiConstants.baseUrl}${cubit.getNotificationsModel!.data!.animals![i].images![0].path}",
                    ),
                ]),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
