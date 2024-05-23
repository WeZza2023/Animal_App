import 'package:animal_app/components/components.dart';
import 'package:animal_app/components/custom_texts.dart';
import 'package:animal_app/components/product_item.dart';
import 'package:animal_app/constants/constant_colors.dart';
import 'package:animal_app/constants/constant_sizes.dart';
import 'package:animal_app/extention/extetion.dart';
import 'package:animal_app/generated/l10n.dart';
import 'package:flutter/material.dart';


class MyPetsScreen extends StatelessWidget {
  const MyPetsScreen({super.key});
  static String id = 'MyPetsScreen';

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
              AppDivider(categoryName: "${S.of(context).numOfPets} : ", ).bP16,
              Wrap(
                  spacing: 12,
                  children: [
                    for (int i = 0; i < 10; i++)
                      Transform(
                        transform: Matrix4.skewY(0.2),
                        alignment: AlignmentDirectional.center,
                        child: ProductItem(onPressed: (){},type: "كلب",gender: "ذكر", typeName: "كلب لولو", city: "مصر",image: "assets/icons/dog.png",).vP16,
                      ),
                  ]
              )

            ],
          ),
        ),
      ),
    );
  }
}
