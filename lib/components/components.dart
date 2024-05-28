import 'package:animal_app/components/custom_texts.dart';
import 'package:animal_app/constants/constant_sizes.dart';
import 'package:animal_app/extention/extetion.dart';
import 'package:animal_app/generated/l10n.dart';
import 'package:animal_app/models/country_code_model.dart';
import 'package:animal_app/screens/signup/signup-cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:lottie/lottie.dart';

import '../constants/constant_colors.dart';
import '../enum/icons.dart';

Widget defaultTextButton({
  required Function()? function,
  required String text,
  double? width,
  Color? color,
  Color? borderColor,
  Color? textColor,
  ThemeImageIcon? icon,
  bool? hasBorder,
}) =>
    SizedBox(
      width: width,
      child: TextButton(

        onPressed: function,
        style: TextButton.styleFrom(

          backgroundColor: color ?? KDefaultColor,
          side: hasBorder != null
              ? BorderSide(color: borderColor ?? KselectedTabColor, width: 2)
              : null,
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            if (icon != null)
              Row(
                children: [
                  ThemeImageIconWidget(
                    icon,
                    scale: 2.5,
                  ),
                  const SizedBox(
                    width: 8,
                  ),
                ],
              ),
            Text(
              text.toUpperCase(),
              style: TextStyle(
                  color: textColor ?? Colors.white,
                  fontWeight: FontWeight.bold),
            ),
          ],
        ),
      ),
    );
Widget AppPopupDialog(
    {required List<Widget> body,
      required String title,
      required String textB1,
      required String textB2,
      required Function() onTapB1,
      required Function() onTapB2,
      Color? colorB1,
      Color? colorB2}) {
  return AlertDialog(
    content: SingleChildScrollView(
      child: Column(
        children: body,
      ),
    ),
    title: Center(child: BodyLargeText(title)),
    actions: [
      defaultTextButton(
        text: textB1,
        function: onTapB1,
        color: colorB1,
      ),
      defaultTextButton(
        text: textB2,
        function: onTapB2,
        color: colorB2,
      )
    ],
  );
}

Widget DefaultTab({
  required ThemeImageIcon icon,
  ThemeImageIcon? secIcon,
  String? title,
  Color? titleColor,
  required Color? iconColor,
  required Color selectedColor,
}) =>
    Container(
      decoration: BoxDecoration(
        color: selectedColor,
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.5),
            blurRadius: 2,
            spreadRadius: 1,
            offset: const Offset(0, 4),
          ),
        ],
        borderRadius: BorderRadius.circular(15),
        border: const BorderDirectional(
            bottom: BorderSide(color: KDefaultColor, width: 0.5),
            start: BorderSide(color: KDefaultColor, width: 0.5)),
      ),
      constraints: const BoxConstraints(minHeight: 48, maxHeight: 50),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          if (title != null)
            Row(
              children: [
                BodyMediumText(
                  title,
                  color: titleColor,
                ),
                const SizedBox(
                  width: 8,
                ),
              ],
            ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              ThemeImageIconWidget(
                icon,
                scale: 2,
                color: iconColor,
              ),
              if (secIcon != null)
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const SizedBox(
                      width: 8,
                    ),
                    ThemeImageIconWidget(
                      secIcon,
                      scale: 2.5,
                      color: iconColor,
                    ),
                  ],
                ),
            ],
          ),
        ],
      ),
    );

Widget OrdersItem({
  required Color color,
  required String status,
  required String location,
  required String time,
  required String name,
  required ThemeImageIcon image,
  required Function(double ratingValue) onRatingUpdate,
}) =>
    Container(
      decoration: BoxDecoration(
        border: BorderDirectional(
          bottom: BorderSide(color: color, width: 2),
          end: BorderSide(color: color, width: 2),
        ),
        borderRadius: BorderRadius.circular(20),
        color: Colors.white,
        boxShadow: [
          BoxShadow(
            color: color.withOpacity(0.5),
            blurRadius: 10,
          ),
        ],
      ),
      child: Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
        Row(
          children: [
            Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(20),
                color: Colors.white,
                border: BorderDirectional(
                  end: BorderSide(color: color, width: 2),
                ),
              ),
              child: ThemeImageIconWidget(
                image,
                color: color,
                scale: 1,
              ).p(12),
            ),
            const SizedBox(
              width: 8,
            ),
            Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                BodyMediumText(
                  name,
                  color: color,
                  weight: FontWeight.bold,
                ).bP8,
                BodySmallText(
                  '$location , $time',
                  color: color,
                  weight: FontWeight.normal,
                ),
              ],
            ),
          ],
        ),
        Row(
          children: [
            Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                RatingBar.builder(
                  itemSize: 20,
                  initialRating: 0,
                  minRating: 1,
                  direction: Axis.horizontal,
                  allowHalfRating: true,
                  itemCount: 5,
                  itemBuilder: (context, _) => const Icon(
                    Icons.star,
                    color: Colors.amber,
                  ),
                  onRatingUpdate: onRatingUpdate,
                ).bP8,
                BodyMediumText(
                  status,
                  color: color,
                  weight: FontWeight.bold,
                ),
              ],
            ),
            const SizedBox(
              width: 20,
            ),
          ],
        )
      ]),
    ).tP16.hP8;

Widget AppDivider({
  String? categoryName,
  Color? color,
}) =>
    Stack(
      children: [
        Divider(thickness: 0.5, color: color ?? KMaintextColor).hP16,
        PositionedDirectional(
            start: -2,
            bottom: -1,
            child: BodyLargeText(
              '●',
              color: color ?? KMaintextColor,
            ).hP16),
        PositionedDirectional(
            end: -2,
            bottom: -1,
            child: BodyLargeText('●', color: color ?? KMaintextColor).hP16),
        if (categoryName != null)
          PositionedDirectional(
              start: 80,
              bottom: 3,
              child: Container(
                color: Colors.white,
                child: BodySmallText(
                  categoryName,
                  color: color ?? KMaintextColor,
                  weight: FontWeight.bold,
                ).hP4,
              )),
      ],
    );

Widget MoreItem({
  IconData? icon,
  required String title,
  required Function() onTap,
}) =>
    InkWell(
      onTap: onTap,
      child: Container(
        decoration: BoxDecoration(
          border: const BorderDirectional(
            bottom: BorderSide(color: Colors.black45, width: 1),
          ),
          borderRadius: BorderRadius.circular(30),
          color: Colors.white,
          boxShadow: [
            BoxShadow(
                color: Colors.grey.withOpacity(0.5),
                blurRadius: 3,
                spreadRadius: 1),
          ],
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            BodyMediumText(title),
            if (icon != null)
              Icon(
                icon,
                color: Colors.black45,
              ),
          ],
        ).p16,
      ).hP8.bP8,
    );

Widget MyRatingItem({
  required String time,
  required String name,
  required Function() onTap,
  required Function(double ratingValue) onRatingUpdate,
  required String adopted,
  required double rate,
}) =>
    InkWell(
      onTap: onTap,
      child: Container(
        decoration: BoxDecoration(
          border: const BorderDirectional(
            bottom: BorderSide(color: Colors.black45, width: 1),
          ),
          borderRadius: BorderRadius.circular(30),
          color: Colors.white,
          boxShadow: [
            BoxShadow(
                color: Colors.grey.withOpacity(0.5),
                blurRadius: 3,
                spreadRadius: 1),
          ],
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                BodyLargeText(
                  name,
                  weight: FontWeight.bold,
                ).bP8,
                RatingBar.builder(
                  ignoreGestures: true,
                  itemSize: 20,
                  initialRating: rate,
                  direction: Axis.horizontal,
                  allowHalfRating: true,
                  itemCount: 5,
                  itemBuilder: (context, _) => const Icon(
                    Icons.star,
                    color: Colors.yellow,
                  ),
                  onRatingUpdate: onRatingUpdate,
                ),
              ],
            ),
            Column(
              children: [
                BodyMediumText(
                  time,
                  color: Colors.green,
                  weight: FontWeight.bold,
                ).bP8,
                BodySmallText(
                  adopted,
                  color: Colors.grey,
                ),
              ],
            ),
          ],
        ).p8.hP8,
      ).hP8.bP16,
    );

Widget NotificationItem({
  required String time,
  required String title,
  required String subTitle,
  required Function() onTap,
  required String location,
  required ThemeImageIcon image,
}) =>
    InkWell(
      onTap: onTap,
      child: Container(
        decoration: BoxDecoration(
          border: const BorderDirectional(
            bottom: BorderSide(color: Colors.green, width: 1),
            end: BorderSide(color: Colors.green, width: 1),
          ),
          borderRadius: BorderRadius.circular(30),
          color: Colors.white,
          boxShadow: [
            BoxShadow(
                color: Colors.grey.withOpacity(0.5),
                blurRadius: 3,
                spreadRadius: 1),
          ],
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Row(
              children: [
                ThemeImageIconWidget(
                  image,
                  color: Colors.black,
                  scale: 1,
                ),
                const SizedBox(
                  width: 12,
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    BodyLargeText(
                      title,
                      weight: FontWeight.bold,
                    ).bP8,
                    BodyMediumText(
                      subTitle,
                      weight: FontWeight.bold,
                      color: Colors.grey,
                    ),
                  ],
                ),
              ],
            ),
            Column(
              children: [
                BodyMediumText(
                  time,
                  color: Colors.green,
                  weight: FontWeight.bold,
                ).bP8,
                BodySmallText(
                  location,
                  color: Colors.grey,
                ),
              ],
            ),
          ],
        ).p8.hP8,
      ).hP8.bP16,
    );

Widget SearchItem({
  required String age,
  required String name,
  required String subTitle,
  required Function() onTap,
  required String location,
  required String image,
}) =>
    InkWell(
      onTap: onTap,
      child: Container(
        decoration: BoxDecoration(
          border: const BorderDirectional(
            bottom: BorderSide(color: KDefaultColor, width: 1),
            end: BorderSide(color: KDefaultColor, width: 1),
          ),
          borderRadius: BorderRadius.circular(30),
          color: Colors.white,
          boxShadow: [
            BoxShadow(
                color: Colors.grey.withOpacity(0.5),
                blurRadius: 3,
                spreadRadius: 1),
          ],
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Row(
              children: [
                ClipRRect(
                  borderRadius: const BorderRadius.all(Radius.circular(20)),
                  child: Image.network(
                    loadingBuilder: (context, child, loadingProgress) {
                      if (loadingProgress == null) return child;
                      return AppLoadingProgress();
                    },
                    errorBuilder: (context, error, stackTrace) =>
                        AppLoadingFailed(big: false),
                    image,
                    height: 50,
                    width: 70,
                    fit: BoxFit.fill,
                  ),
                ),
                const SizedBox(
                  width: 12,
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    BodyLargeText(
                      name,
                      weight: FontWeight.bold,
                    ).bP8,
                    BodyMediumText(
                      subTitle,
                      weight: FontWeight.bold,
                      color: Colors.grey,
                    ),
                  ],
                ),
              ],
            ),
            Column(
              children: [
                BodyMediumText(
                  age,
                  color: KMaintextColor,
                  weight: FontWeight.bold,
                ).bP8,
                BodySmallText(
                  location,
                  color: Colors.grey,
                ),
              ],
            ),
          ],
        ).p8.hP8,
      ).hP8.tP16,
    );

SnackBar AppSnackBar({
  required String content,
  required Color color,
}) =>
    SnackBar(
      elevation: 20,
      duration: const Duration(seconds: 1),
      showCloseIcon: true,
      backgroundColor: color,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.only(
            topRight: Radius.circular(20), topLeft: Radius.circular(20)),
      ),
      content: Text(content),
    );

Widget CountryCodesSheet({
  required context,
}) {
  var cubit = BlocProvider.of<SignupCubit>(context);

  return Container(
    height: AppSizes.getScreenHeight(context) / 1.5,
    width: AppSizes.getScreenWidth(context),
    child: SingleChildScrollView(
      child: Column(children: [
        BodyLargeText(
          S.of(context).selectyourcountrycode,
          weight: FontWeight.bold,
        ).bP16,
        SizedBox(
          height: AppSizes.getScreenHeight(context),
          child: ListView.builder(
            itemCount: countryCodes.length,
            itemBuilder: (context, index) => InkWell(
              onTap: () {
                print(countryCodes[index].code);
                Navigator.pop(context);
                cubit.changeCountryCode(code: countryCodes[index].code);
              },
              child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    BodyMediumText(countryCodes[index].code,
                        weight: FontWeight.bold, color: KDefaultColor),
                    BodyMediumText(
                      countryCodes[index].name,
                      weight: FontWeight.bold,
                      color: KMaintextColor,
                    ),
                  ]).hP16.vP8,
            ),
          ),
        )
      ]),
    ),
  );
}

Widget AppLoadingProgress() => Center(
      child: ClipRRect(
          borderRadius: BorderRadius.circular(200),
          child: LottieBuilder.asset(
            "assets/icons/loading.json",
            height: 50,
            width: 50,
            repeat: true,
          )),
    );

Widget AppLoadingFailed({required bool big}) => ClipRRect(
      child: Center(
        child: LottieBuilder.asset(
          "assets/icons/fail.json",
          height: big ? 90 : 50,
          width: big ? 90 : 70,
          repeat: true,
        ),
      ),
    );

Widget ViewAnimalItem({required String text, double? height}) => Container(
      height: height,
      decoration: BoxDecoration(
        border: const BorderDirectional(
          bottom: BorderSide(color: KDefaultColor, width: 1),
          start: BorderSide(color: KDefaultColor, width: 0.5),
        ),
        borderRadius: BorderRadius.circular(30),
        color: Colors.white,
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.5),
            blurRadius: 3,
            spreadRadius: 1,
            offset: const Offset(0, 3),
          ),
        ],
      ),
      child: Row(
        children: [
          BodySmallText(
            text,
            weight: FontWeight.bold,
          ),
        ],
      ).p25,
    ).hP16.tP16;
