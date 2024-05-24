import 'package:animal_app/components/components.dart';
import 'package:animal_app/components/custom_texts.dart';
import 'package:animal_app/constants/constant_colors.dart';
import 'package:animal_app/constants/constant_sizes.dart';
import 'package:animal_app/extention/extetion.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';

class ProductItem extends StatelessWidget {
  const ProductItem({
    super.key,
    required this.onPressed,
    required this.type,
    required this.gender,
    required this.typeName,
    required this.city,
    required this.image,
  });

  final Function() onPressed;
  final String type;
  final String gender;
  final String typeName;
  final String city;
  final String image;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onPressed,
      child: Stack(
        children: [
          Container(
            height: AppSizes.getScreenHeight(context) * 0.35,
            width: AppSizes.getScreenWidth(context) * 0.45,
            decoration: const BoxDecoration(
              gradient: LinearGradient(
                colors: KGradientColors,
                begin: Alignment.bottomRight,
                end: Alignment.topLeft,
              ),
              borderRadius: BorderRadius.all(
                Radius.circular(25),
              ),
            ),
            child: Transform(
              transform: Matrix4.skewY(-0.2),
              alignment: Alignment.center,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      IconButton(
                        onPressed: () {},
                        icon: const Icon(
                          Icons.favorite_outline_rounded,
                        ),
                      ),
                      Column(
                        children: [
                          BodyMediumText(
                            '$type . $gender',
                            color: KMaintextColor,
                          ),
                          BodyMediumText(
                            typeName,
                            color: KselectedTabColor,
                            weight: FontWeight.bold,
                          ),
                          BodyMediumText(
                            city,
                            color: KMaintextColor,
                          ),
                        ],
                      ),
                    ],
                  ).vP8,
                ],
              ).p8,
            ),
          ),
          PositionedDirectional(
            top: 30,
            end: 10,
            child: Transform(
              transform: Matrix4.skewY(-0.2),
              child: ClipRRect(
                borderRadius: BorderRadius.all(Radius.circular(20)),
                child: Image.network(
                  loadingBuilder: (context, child, loadingProgress) {
                    if (loadingProgress == null) return child;
                    return AppLoadingProgress();
                  },
                  errorBuilder: (context, error, stackTrace) =>
                  AppLoadingFailed(),
                  image,
                  height: 90,
                  width: 100,
                  fit: BoxFit.fill,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
