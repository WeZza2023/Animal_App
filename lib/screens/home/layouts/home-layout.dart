import 'dart:convert';

import 'package:animal_app/components/components.dart';
import 'package:animal_app/components/custom_texts.dart';
import 'package:animal_app/components/product_item.dart';
import 'package:animal_app/constants/constant_colors.dart';
import 'package:animal_app/constants/constant_sizes.dart';
import 'package:animal_app/extention/extetion.dart';
import 'package:animal_app/generated/l10n.dart';
import 'package:animal_app/network/api_constants.dart';
import 'package:animal_app/screens/home/home-cubit.dart';
import 'package:animal_app/screens/home/home-state.dart';
import 'package:animal_app/screens/home/layouts/search_layout.dart';
import 'package:animal_app/screens/view_animal/view_animal_screen.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:lottie/lottie.dart';

import '../../../enum/icons.dart';

class HomeLayout extends StatefulWidget {
  const HomeLayout({super.key});

  @override
  State<HomeLayout> createState() => _HomeLayoutState();
}

class _HomeLayoutState extends State<HomeLayout> with TickerProviderStateMixin {
  late final TabController _tabController;
  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 3, vsync: this);
    BlocProvider.of<HomeCubit>(context).getAnimals(currentPage: 1);
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final cubit = BlocProvider.of<HomeCubit>(context);
    return BlocConsumer<HomeCubit, HomeState>(
        listener: (context, state) {
          if (state is GetAnimalsLoadingState) {
            print("Loading");
          }
          if (state is GetAnimalsErrorState) {
            print("Error");
          }
          if (state is GetAnimalsSuccessState) {
            print("Success");
          }
        },
        builder: (context, state) => Column(
              children: [
                if (cubit.isSearcBarShown)
                  SearchBar(
                    controller: cubit.searchController,
                    constraints:
                        const BoxConstraints(maxHeight: 50, minHeight: 48),
                    surfaceTintColor:
                        const MaterialStatePropertyAll(Colors.white),
                    shadowColor: const MaterialStatePropertyAll(Colors.grey),
                    elevation: const MaterialStatePropertyAll(5),
                    backgroundColor:
                        const MaterialStatePropertyAll(Colors.white),
                    hintText: S.of(context).search,
                    onChanged: (value) {
                      if (cubit.searchController.text.isNotEmpty) {
                        cubit.searchAnimal(name: value);
                      }
                    },
                    trailing: [
                      IconButton(
                        icon: const Icon(
                          Icons.search_rounded,
                          color: Colors.grey,
                        ),
                        onPressed: () {},
                      )
                    ],
                  ).tP16.hP16,
                if (cubit.searchController.text.isEmpty)
                  Column(
                    children: [
                      TabBar(
                        dividerColor: Colors.transparent,
                        controller: _tabController,
                        onTap: (index) async {
                          cubit.onTabChanged(index);
                          cubit.changeOpacity();
                        },
                        tabs: [
                          DefaultTab(
                            selectedColor: cubit.currentTabIndex == 0
                                ? KselectedTabColor
                                : Colors.white,
                            iconColor: cubit.currentTabIndex == 0
                                ? Colors.white
                                : KMaintextColor,
                            icon: ThemeImageIcon.cat,
                            secIcon: ThemeImageIcon.dog,
                          ),
                          DefaultTab(
                            selectedColor: cubit.currentTabIndex == 1
                                ? KselectedTabColor
                                : Colors.white,
                            iconColor: cubit.currentTabIndex == 1
                                ? Colors.white
                                : KMaintextColor,
                            titleColor: cubit.currentTabIndex == 1
                                ? cubit.selectedTabTextColor
                                : KMaintextColor,
                            icon: ThemeImageIcon.cat,
                            title: S.of(context).cats,
                          ),
                          DefaultTab(
                            selectedColor: cubit.currentTabIndex == 2
                                ? KselectedTabColor
                                : Colors.white,
                            iconColor: cubit.currentTabIndex == 2
                                ? Colors.white
                                : KMaintextColor,
                            titleColor: cubit.currentTabIndex == 2
                                ? cubit.selectedTabTextColor
                                : KMaintextColor,
                            icon: ThemeImageIcon.dog,
                            title: S.of(context).dogs,
                          ),
                        ],
                        indicatorSize: TabBarIndicatorSize.label,
                        indicatorColor: Colors.transparent,
                      ).hP16.tP16,
                      CarouselSlider(
                        options: CarouselOptions(
                            viewportFraction: 1.0,
                            height: 200,
                            autoPlay: true,
                            autoPlayCurve: Curves.fastOutSlowIn,
                            autoPlayAnimationDuration:
                                const Duration(milliseconds: 800),
                            autoPlayInterval: const Duration(seconds: 2),
                            aspectRatio: 2.0,
                            pauseAutoPlayOnTouch: true,
                            scrollPhysics: const ClampingScrollPhysics(),
                            onPageChanged: (index, reason) {}),
                        items: [Image.asset("assets/images/discount.png")],
                      ).bP8.hP16,
                      cubit.getAnimalsModel == null ||
                              state is GetAnimalsLoadingState
                          ? AppLoadingProgress()
                          : cubit.getAnimalsModel!.data!.animals!.isEmpty
                              ? BodyLargeText(
                                  S.of(context).thereIsNoAnimalsAddedYet)
                              : Column(
                                  children: [
                                    Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          IconButton(
                                              onPressed: () {
                                                if (cubit.getAnimalsModel!.data!
                                                        .lastPage ==
                                                    cubit.getAnimalsModel!.data!
                                                        .currentPage) {
                                                  ScaffoldMessenger.of(context)
                                                      .showSnackBar(AppSnackBar(
                                                          content: S
                                                              .of(context)
                                                              .noMoreResults,
                                                          color: Colors.red));
                                                } else {
                                                  cubit.getAnimals(
                                                      currentPage: int.parse(cubit
                                                              .getAnimalsModel!
                                                              .data!
                                                              .currentPage) +
                                                          1);
                                                }
                                              },
                                              icon: const Icon(Icons
                                                  .arrow_back_ios_rounded)),
                                          BodyMediumText(
                                              "${cubit.getAnimalsModel!.data!.currentPage} / ${cubit.getAnimalsModel!.data!.lastPage}",
                                              weight: FontWeight.bold,
                                              color: KMaintextColor),
                                          IconButton(
                                              onPressed: () {
                                                if (cubit.getAnimalsModel!.data!
                                                        .currentPage ==
                                                    "1") {
                                                  ScaffoldMessenger.of(context)
                                                      .showSnackBar(AppSnackBar(
                                                          content: S
                                                              .of(context)
                                                              .noMoreResults,
                                                          color: Colors.red));
                                                } else {
                                                  cubit.getAnimals(
                                                      currentPage: int.parse(cubit
                                                              .getAnimalsModel!
                                                              .data!
                                                              .currentPage) -
                                                          1);
                                                }
                                              },
                                              icon: const Icon(Icons
                                                  .arrow_forward_ios_rounded)),
                                        ]).p16,
                                    cubit.currentTabIndex != 0?
                                           cubit.getAnimalsModel!.data!.animals!
                                                .where((element) =>
                                                    element.type ==
                                                    cubit.filterAnimals)
                                                .toList()
                                                .isEmpty
                                            ? Column(
                                                children: [
                                                  AppLoadingFailed(big: true),
                                                  BodyLargeText(
                                                    S
                                                        .of(context)
                                                        .thereIsNoResultsInThisPage,
                                                    weight: FontWeight.bold,
                                                  ),
                                                  BodyLargeText(
                                                      S
                                                          .of(context)
                                                          .youCanMoveToTheNextPage,
                                                      weight: FontWeight.bold),
                                                ],
                                              )
                                            : Wrap(spacing: 12, children: [
                                                for (int i = 0;
                                                    i <
                                                        cubit
                                                            .getAnimalsModel!
                                                            .data!
                                                            .animals!
                                                            .length;
                                                    i++)
                                                  if (cubit.currentTabIndex ==
                                                          0 ||
                                                      cubit
                                                              .getAnimalsModel!
                                                              .data!
                                                              .animals![i]
                                                              .type ==
                                                          cubit.filterAnimals)
                                                    AnimatedOpacity(
                                                      duration: const Duration(
                                                          milliseconds: 500),
                                                      opacity:
                                                          cubit.itemOpacity,
                                                      child: Transform(
                                                        transform:
                                                            Matrix4.skewY(0.2),
                                                        alignment:
                                                            AlignmentDirectional
                                                                .center,
                                                        child: ProductItem(
                                                          onPressed: () {
                                                            Navigator.push(
                                                                context,
                                                                MaterialPageRoute(
                                                              builder:
                                                                  (context) {
                                                                return ViewAnimalScreen(
                                                                  outIndex: i,
                                                                );
                                                              },
                                                            ));
                                                          },
                                                          type: cubit
                                                              .getAnimalsModel!
                                                              .data!
                                                              .animals![i]
                                                              .type,
                                                          gender: cubit
                                                              .getAnimalsModel!
                                                              .data!
                                                              .animals![i]
                                                              .sex,
                                                          typeName: cubit
                                                              .getAnimalsModel!
                                                              .data!
                                                              .animals![i]
                                                              .age,
                                                          city: cubit
                                                              .getAnimalsModel!
                                                              .data!
                                                              .animals![i]
                                                              .location,
                                                          image: cubit
                                                                  .getAnimalsModel!
                                                                  .data!
                                                                  .animals![i]
                                                                  .images!
                                                                  .isEmpty
                                                              ? "https://static.vecteezy.com/system/resources/previews/004/968/529/original/search-no-results-found-concept-illustration-flat-design-eps10-simple-modern-graphic-element-for-landing-page-empty-state-ui-infographic-icon-with-editable-stroke-line-outline-linear-vector.jpg"
                                                              : cubit.getAnimalsModel!.data!.animals![i].images![0].path,
                                                        ).vP16,
                                                      ),
                                                    ),
                                              ])
                                        : Wrap(spacing: 12, children: [
                                            for (int i = 0;
                                                i <
                                                    cubit.getAnimalsModel!.data!
                                                        .animals!.length;
                                                i++)
                                              if (cubit.currentTabIndex == 0 ||
                                                  cubit.getAnimalsModel!.data!
                                                          .animals![i].type ==
                                                      cubit.filterAnimals)
                                                AnimatedOpacity(
                                                  duration: const Duration(
                                                      milliseconds: 500),
                                                  opacity: cubit.itemOpacity,
                                                  child: Transform(
                                                    transform:
                                                        Matrix4.skewY(0.2),
                                                    alignment:
                                                        AlignmentDirectional
                                                            .center,
                                                    child: ProductItem(
                                                      onPressed: () {
                                                        Navigator.push(context,
                                                            MaterialPageRoute(
                                                          builder: (context) {
                                                            return ViewAnimalScreen(
                                                              outIndex: i,
                                                            );
                                                          },
                                                        ));
                                                      },
                                                      type: cubit
                                                          .getAnimalsModel!
                                                          .data!
                                                          .animals![i]
                                                          .type,
                                                      gender: cubit
                                                          .getAnimalsModel!
                                                          .data!
                                                          .animals![i]
                                                          .sex,
                                                      typeName: cubit
                                                          .getAnimalsModel!
                                                          .data!
                                                          .animals![i]
                                                          .age,
                                                      city: cubit
                                                          .getAnimalsModel!
                                                          .data!
                                                          .animals![i]
                                                          .location,
                                                      image: cubit
                                                              .getAnimalsModel!
                                                              .data!
                                                              .animals![i]
                                                              .images!
                                                              .isEmpty
                                                          ? "https://static.vecteezy.com/system/resources/previews/004/968/529/original/search-no-results-found-concept-illustration-flat-design-eps10-simple-modern-graphic-element-for-landing-page-empty-state-ui-infographic-icon-with-editable-stroke-line-outline-linear-vector.jpg"
                                                          : cubit.getAnimalsModel!.data!.animals![i].images![0].path,
                                                    ).vP16,
                                                  ),
                                                ),
                                          ]),
                                  ],
                                ),
                    ],
                  ),
                if (cubit.searchController.text.isNotEmpty && cubit.searchModel != null) const SearchLayout()
              ],
            ));
  }
}
