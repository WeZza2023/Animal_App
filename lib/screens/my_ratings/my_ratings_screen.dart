import 'package:animal_app/components/components.dart';
import 'package:animal_app/constants/constant_colors.dart';
import 'package:animal_app/constants/constant_sizes.dart';
import 'package:animal_app/extention/extetion.dart';
import 'package:flutter/material.dart';

class MyRatingsScreen extends StatelessWidget {
  const MyRatingsScreen({super.key});
  static String id = 'MyRatingsScreen';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
              AppDivider(categoryName: "عدد التقيمات 11", color: Colors.grey)
                  .bP16,
              MyRatingItem(
                  onTap: () {},
                  onRatingUpdate: (value) {},
                  rate: 2,
                  name: "مريم",
                  time: "منذ قليل",
                  adopted: 'تبني كلب'),
              MyRatingItem(
                  onTap: () {},
                  onRatingUpdate: (value) {},
                  rate: 2,
                  name: "مريم",
                  time: "منذ قليل",
                  adopted: 'تبني كلب'),
            ],
          ),
        ),
      ),
    );
  }
}
