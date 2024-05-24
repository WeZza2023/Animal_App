import 'package:animal_app/components/components.dart';
import 'package:animal_app/components/custom_texts.dart';
import 'package:animal_app/components/product_item.dart';
import 'package:animal_app/constants/constant_colors.dart';
import 'package:animal_app/constants/constant_sizes.dart';
import 'package:animal_app/extention/extetion.dart';
import 'package:animal_app/generated/l10n.dart';
import 'package:animal_app/screens/home/home-cubit.dart';
import 'package:animal_app/screens/home/home-state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class MyPetsScreen extends StatelessWidget {
  const MyPetsScreen({super.key});
  static String id = 'MyPetsScreen';

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
          child:
              cubit.getRequestsModel == null || state is GetRequestsLoadingState
                  ? AppLoadingProgress()
                  : SingleChildScrollView(
                      child: Column(
                        children: [
                          const SizedBox(
                            height: 20,
                          ),
                          AppDivider(
                            categoryName:
                                "${S.of(context).numOfPets} : ${cubit.getRequestsModel!.data!.isEmpty ? "0" : cubit.getRequestsModel!.data!.where((notification) => notification.status == "accepted").toList().length}",
                          ).bP16,
                          cubit.getRequestsModel!.data!.isEmpty
                              ? BodyLargeText(
                                      S.of(context).youdidnotRequestanyAnimal)
                                  .vP16
                              : Wrap(spacing: 12, children: [
                                  for (int i = 0;
                                      i <
                                          (cubit.getRequestsModel!.data!.isEmpty
                                              ? 0
                                              : cubit.getRequestsModel!.data!
                                                  .where((notification) =>
                                                      notification.status ==
                                                      "accepted")
                                                  .toList()
                                                  .length);
                                      i++)
                                    Transform(
                                      transform: Matrix4.skewY(0.2),
                                      alignment: AlignmentDirectional.center,
                                      child: ProductItem(
                                        onPressed: () {},
                                        type: cubit.getRequestsModel!.data![i]
                                            .animal!.type!,
                                        gender: cubit.getRequestsModel!.data![i]
                                            .animal!.sex!,
                                        typeName: cubit.getRequestsModel!
                                            .data![i].animal!.title!,
                                        city: cubit.getRequestsModel!.data![i]
                                            .animal!.location!,
                                        image: "assets/icons/dog.png",
                                      ).vP16,
                                    ),
                                ])
                        ],
                      ),
                    ),
        ),
      ),
    );
  }
}
