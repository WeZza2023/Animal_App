import 'dart:io';

import 'package:animal_app/components/components.dart';
import 'package:animal_app/components/custom_texts.dart';
import 'package:animal_app/components/default_formfield.dart';
import 'package:animal_app/constants/constant_colors.dart';
import 'package:animal_app/constants/constant_sizes.dart';
import 'package:animal_app/extention/extetion.dart';
import 'package:animal_app/generated/l10n.dart';
import 'package:animal_app/network/api_constants.dart';
import 'package:animal_app/network/payment_service/payment_cubit.dart';
import 'package:animal_app/screens/home/home-cubit.dart';
import 'package:animal_app/screens/home/home-state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class AddAnimalLayout extends StatelessWidget {
  AddAnimalLayout({super.key});
  final TextEditingController animalNameController = TextEditingController();
  final TextEditingController animalTypeController = TextEditingController();
  final TextEditingController animalGenderController = TextEditingController();
  final TextEditingController cityController = TextEditingController();
  final TextEditingController animalAgeController = TextEditingController();
  final TextEditingController adoptionReasonController =
      TextEditingController();
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    final cubit = BlocProvider.of<HomeCubit>(context);
    return BlocConsumer<HomeCubit, HomeState>(
      listener: (context, state) {
        if (state is AddAnimalSuccessState) {
          ScaffoldMessenger.of(context).showSnackBar(AppSnackBar(
              content: S.of(context).addedAnimalSuccessfully,
              color: Colors.green));
          animalNameController.clear();
          animalTypeController.clear();
          animalGenderController.clear();
          cityController.clear();
          animalAgeController.clear();
          adoptionReasonController.clear();
          cubit.clearPickedImages();
        } else if (state is AddAnimalErrorState) {
          ScaffoldMessenger.of(context).showSnackBar(AppSnackBar(
              content: S.of(context).processError, color: Colors.red));
        }
      },
      builder: (context, state) => Form(
        key: formKey,
        child: Column(
          children: [
            MianTextFormField(
              animalNameController: animalNameController,
              labelText: S.of(context).animalName,
              validation: (value) {
                if (value == null || value.isEmpty) {
                  ScaffoldMessenger.of(context).showSnackBar(AppSnackBar(
                      content: "please enter animal name",
                      color: Colors.red));
                  return "";

                }
              },
            ),
            MianDropDownFormField(
              labelText: S.of(context).animalType,
              validation: (value) {
                if (value == null || value.isEmpty) {
                  ScaffoldMessenger.of(context).showSnackBar(AppSnackBar(
                      content: "please enter animal type",
                      color: Colors.red));
                  return "";
                }
              },
              animalTypeController: animalTypeController,
              items: const ["dog", "cat"],
            ),
            MianDropDownFormField(
              labelText: S.of(context).animalGender,
              validation: (value) {
                if (value == null || value.isEmpty) {
                  ScaffoldMessenger.of(context).showSnackBar(AppSnackBar(
                      content: "please enter animal gender",
                      color: Colors.red));
                  return "";
                }
              },
              animalTypeController: animalGenderController,
              items: const ["male", "female"],
            ),
            MianTextFormField(
              animalNameController: cityController,
              validation: (value) {
                if (value == null || value.isEmpty) {
                  ScaffoldMessenger.of(context).showSnackBar(AppSnackBar(
                      content: "please enter the location",
                      color: Colors.red));
                  return "";
                }
              },
              labelText: S.of(context).city,
            ),
            MianTextFormField(
              textInputType: TextInputType.number,
              validation: (value) {
                if (value == null || value.isEmpty) {
                  ScaffoldMessenger.of(context).showSnackBar(AppSnackBar(
                      content: "please enter animal age",
                      color: Colors.red));
                  return "";
                }
              },
              animalNameController: animalAgeController,
              labelText: S.of(context).animalAge,
            ),
            MianTextFormField(
              height: 200,
              textInputType: TextInputType.text,
              validation: (value) {
                if (value == null || value.isEmpty) {
                  ScaffoldMessenger.of(context).showSnackBar(AppSnackBar(
                      content: "please enter adoption reason",
                      color: Colors.red));
                  return "";
                }
              },
              animalNameController: adoptionReasonController,
              labelText: S.of(context).adoptionReason,
            ),
            Container(
              decoration: BoxDecoration(
                boxShadow: [
                  BoxShadow(
                    color: Colors.grey.withOpacity(0.5),
                    spreadRadius: 3,
                    blurRadius: 5,
                    offset: const Offset(0, 3),
                  )
                ],
                color: Colors.white,
                borderRadius: BorderRadius.circular(12),
              ),
              child: Column(
                children: [
                  Container(
                    decoration: BoxDecoration(
                      boxShadow: [
                        BoxShadow(
                          color: Colors.grey.withOpacity(0.5),
                          spreadRadius: 2,
                          blurRadius: 5,
                          offset: const Offset(0, 3),
                        )
                      ],
                      borderRadius: const BorderRadius.only(
                          topRight: Radius.circular(12),
                          topLeft: Radius.circular(12)),
                      color: KDefaultColor,
                    ),
                    child: Stack(
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            BodyMediumText(
                              S.of(context).photos,
                              color: Colors.white,
                              weight: FontWeight.bold,
                            ).p16,
                          ],
                        ),
                        if (cubit.pickedImages.isNotEmpty)
                          PositionedDirectional(
                              end: 0,
                              child: IconButton(
                                  onPressed: () {
                                    cubit.clearPickedImages();
                                  },
                                  icon: const Icon(
                                    Icons.delete_forever_outlined,
                                    color: Colors.white,
                                  )))
                      ],
                    ),
                  ),
                  Container(
                    height: 100,
                    child: cubit.pickedImages.isEmpty
                        ? InkWell(
                            onTap: () {
                              cubit.pickImage();
                            },
                            child: Center(
                                child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                const Icon(Icons.add_photo_alternate_outlined),
                                const SizedBox(width: 10),
                                Text(S.of(context).addPhotos),
                              ],
                            )).p8,
                          )
                        : ListView.builder(
                            scrollDirection: Axis.horizontal,
                            itemBuilder: (context, index) {
                              return Container(
                                constraints: const BoxConstraints(
                                  maxHeight: 80,
                                  minHeight: 70,
                                  minWidth: 90,
                                  maxWidth: 100,
                                ),
                                decoration: BoxDecoration(
                                  color: Colors.white,
                                  borderRadius: BorderRadius.circular(12),
                                  boxShadow: [
                                    BoxShadow(
                                      color: Colors.grey.withOpacity(0.5),
                                      spreadRadius: 0,
                                      blurRadius: 4,
                                    ),
                                  ],
                                ),
                                child: Image.file(
                                    File(cubit.pickedImages[index].path),
                                    fit: BoxFit.cover),
                              ).p(12);
                            },
                            itemCount: cubit.pickedImages.length,
                          ),
                  )
                ],
              ),
            ).hP16.vP16,
            state is AddAnimalLoadingState
                ?  AppLoadingProgress()
                : defaultTextButton(
                    function: () async{
                      // await PaymentCubit.get(context).getAuthToken();
                      //  PaymentCubit.get(context).addInvoice(token: '', amount: '21', clientMobile: '626', clientName: "clientName", orderNumber: "orderNumber", products: [{ "name": "name", "price": "price", "quantity": "quantity"},]);

                      if (formKey.currentState!.validate()){
                    await    cubit.addAnimal(
                          name: animalNameController.text,
                          type: animalTypeController.text,
                          gender: animalGenderController.text,
                          location: cityController.text,
                          age: animalAgeController.text,
                          reason: adoptionReasonController.text,
                        );
                      }
                    },
                    text: S.of(context).confirmPost,
                    color: KselectedTabColor,
                    width: AppSizes.getScreenWidth(context) ,
                  ).bP16.hP16
          ],
        ),
      ),
    );
  }
}
