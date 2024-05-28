import 'package:animal_app/components/components.dart';
import 'package:animal_app/components/custom_texts.dart';
import 'package:animal_app/components/product_item.dart';
import 'package:animal_app/constants/constant_colors.dart';
import 'package:animal_app/constants/constant_sizes.dart';
import 'package:animal_app/extention/extetion.dart';
import 'package:animal_app/generated/l10n.dart';
import 'package:animal_app/screens/my_adopted/my_pets_cubit.dart';
import 'package:animal_app/screens/my_adopted/my_pets_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class MyPetsAnimalScreen extends StatelessWidget {
  const MyPetsAnimalScreen({super.key});
  static String id = 'MyPetsAnimalScreen';

  @override
  Widget build(BuildContext context) {
    var cubit = BlocProvider.of<MyPetsCubit>(context);
    return BlocConsumer<MyPetsCubit, MyPetsState>(
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
          child: state is GetMyPetsLoadingState || cubit.myAnimalsModel == null
              ? AppLoadingProgress()
              : cubit.myAnimalsModel!.data!.isEmpty
                  ? Center(child: BodyLargeText(S.of(context).youDidNotPostAnyAnimal))
                  : SingleChildScrollView(
                      child: Column(
                        children: [
                          const SizedBox(
                            height: 20,
                          ),
                          AppDivider(
                            categoryName:
                                "${S.of(context).numOfAdoptedAnimals} : ${cubit.myAnimalsModel!.data!.length}",
                          ).bP16,
                          Wrap(spacing: 12, children: [
                            for (int i = 0;
                                i < cubit.myAnimalsModel!.data!.length;
                                i++)
                              Transform(
                                transform: Matrix4.skewY(0.2),
                                alignment: AlignmentDirectional.center,
                                child: ProductItem(
                                  onPressed: () {},
                                  type: cubit.myAnimalsModel!.data![i].type!,
                                  gender: cubit.myAnimalsModel!.data![i].sex!,
                                  typeName:
                                      cubit.myAnimalsModel!.data![i].title!,
                                  city:
                                      cubit.myAnimalsModel!.data![i].location!,
                                  image: cubit.myAnimalsModel!.data![i].images!
                                          .isEmpty
                                      ? "https://static.vecteezy.com/system/resources/previews/004/968/529/original/search-no-results-found-concept-illustration-flat-design-eps10-simple-modern-graphic-element-for-landing-page-empty-state-ui-infographic-icon-with-editable-stroke-line-outline-linear-vector.jpg"
                                      : cubit.myAnimalsModel!.data![i]
                                          .images![0].path!,
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
