import 'package:animal_app/components/components.dart';
import 'package:animal_app/components/custom_texts.dart';
import 'package:animal_app/components/product_item.dart';
import 'package:animal_app/constants/constant_colors.dart';
import 'package:animal_app/constants/constant_sizes.dart';
import 'package:animal_app/enum/icons.dart';
import 'package:animal_app/extention/extetion.dart';
import 'package:animal_app/generated/l10n.dart';
import 'package:animal_app/network/api_constants.dart';
import 'package:animal_app/screens/home/home-cubit.dart';
import 'package:animal_app/screens/home/home-state.dart';
import 'package:animal_app/screens/notifications/notifications_cubit.dart';
import 'package:animal_app/screens/notifications/notifications_state.dart';
import 'package:animal_app/screens/view_animal/view_animal_notification_screen.dart';
import 'package:animal_app/screens/view_animal/view_animal_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class NotificationsScreen extends StatelessWidget {
  const NotificationsScreen({super.key});
  static String id = 'NotificationsScreen';

  @override
  Widget build(BuildContext context) {
    var cubit = BlocProvider.of<HomeCubit>(context);
    return BlocConsumer<HomeCubit, HomeState>(
      listener: (context, state) {},
      builder: (context, state) => Scaffold(
        appBar: AppBar(
            backgroundColor: Colors.transparent,
            actions: [
              Container(
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(20),
                    color: Colors.white),
                child: Row(
                  children: [
                    BodyMediumText(
                      S.of(context).notifications,
                      color: KDefaultColor,
                      weight: FontWeight.bold,
                    ),
                    const Icon(
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
            child: cubit.getNotificationsModel == null ||
                    state is GetNotificationsLoadingState
                ? AppLoadingProgress().tP25
                : SingleChildScrollView(
                    child: Column(
                      children: [
                        const SizedBox(
                          height: 20,
                        ),
                        AppDivider(
                                categoryName:
                                    "${S.of(context).receivedNotifications} : ${cubit.getNotificationsModel!.data!.where((notification) => notification.status == "pending").toList().length}",
                                color: Colors.grey)
                            .bP16,
                        Wrap(spacing: 12, children: [
                          for (int i = 0;
                              i < cubit.getNotificationsModel!.data!.length;
                              i++)
                            if (cubit.getNotificationsModel!.data![i].status ==
                                "pending")
                              NotificationItem(
                                onTap: () {
                                  Navigator.push(context, MaterialPageRoute(
                                    builder: (context) {
                                      return ViewAnimalNotificationScreen(
                                        outIndex: i,
                                      );
                                    },
                                  ));
                                },
                                time: cubit.getNotificationsModel!.data![i]
                                    .getDuration(context),
                                title: "طلب تبني",
                                location: cubit.getNotificationsModel!.data![i]
                                    .animal!.location!,
                                subTitle: "قام محمد بالطلب للتبني",
                                image: cubit.getNotificationsModel!.data![i]
                                            .animal!.type ==
                                        'cat'
                                    ? ThemeImageIcon.cat
                                    : ThemeImageIcon.dog,
                              ),
                        ]),
                      ],
                    ),
                  )),
      ),
    );
  }
}
